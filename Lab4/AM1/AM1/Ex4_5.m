clc
clear all
close all

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];

S = spv(array,directions);

sigma2 = 0.0001;
SNR_dB = 10*log10(1 / sigma2);
Rmm = eye(3); 
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5);

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

% Detection Problem
eig_theoretical = eig(Rxx_theoretical);
eig_au = eig(Rxx_au);
eig_im = eig(Rxx_im);