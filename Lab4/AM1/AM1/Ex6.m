clc
clear all
close all

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];
% Z = my_pattern(array);
% plot2d3d(Z,[0:180],0,'gain in dB','initial pattern');

S = spv(array,directions);

sigma2 = 0.0001;
sigma2_alt = 0.1;
SNR_dB = 10*log10(1 / sigma2);
SNR_dB_alt = 10*log10(1 / sigma2_alt);
Rmm = eye(3);
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5);
Rxx_theoretical_alt = S*Rmm*S' + sigma2_alt*eye(5,5);

load Xaudio/Xaudio.mat
load Ximage/Ximage.mat
%soundsc(real(X_au(2,:)), 11025);
%displayimage(X_im(2,:),image_size, 201,'The received signal at the 2nd antenna');

% covariance matrix in practice
Rxx_au = X_au*X_au' / length(X_au(1,:));
Rxx_im = X_im*X_im' / length(X_im(1,:));

%estimated parameters
directions = [];
Rmm = [];
S = [];
sigma2 = [];

%% Conventional Estimation Problem
%% Reception Problem
Sd = spv(array, [90,0]);
wopt = inv(Rxx_theoretical) * Sd;
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB',['Theoretical W-H array pattern, SNR=',num2str(SNR_dB),'dB']);

%Add breakpoint here to plot two figure
wopt = inv(Rxx_theoretical_alt) * Sd;
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB',['Theoretical W-H array pattern, SNR=',num2str(SNR_dB_alt),'dB']);