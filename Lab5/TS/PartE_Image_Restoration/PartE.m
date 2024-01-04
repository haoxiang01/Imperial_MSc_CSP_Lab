clc
clear
close all

% Parameters
addpath('../Image/')
addpath('Utils/')
SNR_dB = 20;
% Read the degraded image
img = imread('54.png'); 

img = im2double(img);
img = im2gray(img);
[width,height] = size(img);

% Define Gaussian degradation functions
h1 = fspecial('gaussian', [5 5], 1); % 5x5 Gaussian
h2 = fspecial('gaussian', [7 7], 1); % 7x7 Gaussian

degraded_img1= imfilter(img, h1, 'conv', 'circular'); % circular convolution
degraded_img2= imfilter(img, h2, 'conv', 'circular'); % circular convolution

figure;
% main title
mainTitle = ['Degraded Images with Different Filtering (SNR: ', num2str(SNR_dB), ' dB)'];
sgtitle(mainTitle);
subplot(2,6,1), imshow(degraded_img1),  title({'Degraded Image'; '5x5 Gaussian blur (\sigma^2=1)'});
subplot(2,6,7), imshow(degraded_img2),  title({'Degraded Image'; '7x7 Gaussian blur (\sigma^2=1)'});

% Through 20 dB AWGN Channel
noisy_img_1 = fAWGN(degraded_img1, SNR_dB);
noisy_img_2 = fAWGN(degraded_img1, SNR_dB);
subplot(2,6,2), imshow(noisy_img_1),  title({'Noisy Image'; '5x5 Gaussian blur | SNR = 20dB AWGN'});
subplot(2,6,8), imshow(noisy_img_2),  title({'Noisy Image'; '7x7 Gaussian blur | SNR = 20dB AWGN'});


% Restore using Inverse Filtering
restored_inverse_1 = fInverse_Filtering(degraded_img1, h1);
restored_inverse_2 = fInverse_Filtering(degraded_img2, h2);
subplot(2,6,3), imshow(restored_inverse_1), title({'Restored Noiseless Image';'Inverse Filtered 5x5'});
subplot(2,6,9), imshow(restored_inverse_2), title({'Restored Noiseless Image';'Inverse Filtered 7x7'});

restored_inverse_noise_1 = fInverse_Filtering(noisy_img_1, h1);
restored_inverse_noise_2 = fInverse_Filtering(noisy_img_1, h2);
subplot(2,6,4), imshow(restored_inverse_noise_1), title({'Restored Noisey Image';'Inverse Filtered 5x5'});
subplot(2,6,10), imshow(restored_inverse_noise_2), title({'Restored NoiseyImage';'Inverse Filtered 7x7'});

% Restore using Wiener Filtering
restored_wiener_1 =fWiener_Filtering(degraded_img1, h1, SNR_dB);
restored_wiener_2 = fWiener_Filtering(degraded_img1, h2, SNR_dB);
subplot(2,6,5), imshow(restored_wiener_1), title({'Restored Noiseless Image';'Wiener Filtered 5x5'});
subplot(2,6,11), imshow(restored_wiener_2), title({'Restored Noiseless Image';'Wiener Filtered 7x7'});

restored_wiener_noise_1 =fWiener_Filtering(noisy_img_1, h1, SNR_dB);
restored_wiener_noise_2 = fWiener_Filtering(noisy_img_2, h2, SNR_dB);
subplot(2,6,6), imshow(restored_wiener_noise_1), title({'Restored Noisey Image';'Wiener Filtered 5x5'});
subplot(2,6,12), imshow(restored_wiener_noise_2), title({'Restored Noisey Image';'Wiener Filtered 7x7'});
