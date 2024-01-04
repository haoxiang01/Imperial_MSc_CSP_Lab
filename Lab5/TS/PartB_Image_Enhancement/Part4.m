clc
clear
close all
X = imread('autumn.tif');
I = rgb2gray(X);

% Adding different noise characteristics
J1 = imnoise(I,'salt & pepper', 0.05); % Different noise density
J2 = imnoise(I,'gaussian', 0, 0.02);   % Gaussian noise

% Applying median filter with different neighborhood sizes
K1 = medfilt2(J1,[5 5]); % Larger neighborhood
K2 = medfilt2(J2,[3 3]); % Median filter on Gaussian noise

d = [3,5,7];
% Displaying images
figure;
subplot(2,2,1), imshow(J1)
title('Salt & Pepper Noise (Density 0.05)')
for i=1:3
    K= medfilt2(J1,[d(i) d(i)]);
    s = num2str(d(i));
    subplot(2,2,i+1), imshow(K); title(['Median Filter ' s 'x' s ' on Salt & Pepper Noise']);  
end

figure;
subplot(2,2,1), imshow(J2)
title('Gaussian Noise (Density 0.02)')
for i=1:3
    K= medfilt2(J2,[d(i) d(i)]);
    s = num2str(d(i));
    subplot(2,2,i+1), imshow(K); title(['Median Filter ' s 'x' s ' on Gaussian Noise']);  
end