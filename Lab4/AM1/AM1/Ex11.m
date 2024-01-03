clc
clear all;
close all;

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];

S = spv(array,directions);

sigma2 = 0.0001;
SNR_dB = 10*log10(1 / sigma2);
Rmm = [1 1 0; 1 1 0; 0 0 1];
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5);

load Xaudio/Xaudio.mat
load Ximage/Ximage.mat

% covariance matrix in practice
Rxx_au = X_au*X_au' / length(X_au(1,:));
Rxx_im = X_im*X_im' / length(X_im(1,:));

%estimated parameters
directions = [];
Rmm = [];
S = [];
sigma2 = [];
M = 3;

%% MUSIC algorithm
% Theoritical
Z = music(array, Rxx_theoretical, M);
plot2d3d(Z,[0:180],0,'gain in dB',['Coherent Theoritical MuSIC spectrum, SNR=' num2str(SNR_dB) 'dB']);

Z = smooth_music(array, Rxx_theoretical, M, 4);
plot2d3d(Z,[0:180],0,'gain in dB',['Spatial Smoothing MuSIC spectrum, SNR=' num2str(SNR_dB) 'dB']);