close all
clear
clc

addpath('../Image/')
imgA = im2double(imread('1.png'));
imgB = im2double(imread('6.png'));
figure();
subplot(1,2,1); imshow(imgA);title('Image A');
subplot(1,2,2); imshow(imgB);title('Image B');

% Convert to grayscale if necessary
if size(imgA, 3) == 3
    imgA = rgb2gray(imgA);
end
if size(imgB, 3) == 3
    imgB = rgb2gray(imgB);
end

% Compute FFT of both images
fftA = fft2(imgA);
fftB = fft2(imgB);

% Extract phase of A and amplitude of B
phaseA = angle(fftA);
amplitudeB = abs(fftB);

% Combine phase of A with amplitude of B
combinedFFT = amplitudeB .* exp(1i * phaseA);

% Compute inverse FFT
newImage = ifft2(combinedFFT);

% Display the result
figure();
imshow(real(newImage), []);
title('New image: phase of image A + amplitude of image B');