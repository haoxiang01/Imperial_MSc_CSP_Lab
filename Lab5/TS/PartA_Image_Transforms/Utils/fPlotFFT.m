function fPlotFFT(img, shift)
% Convert to grayscale if necessary
if size(img,3) == 3
    img = rgb2gray(img);
end
% Apply 2D FFT
fft_img = fft2(img);

% Shift zero frequency component to the center
if shift == 1
    fft_img_shifted = fftshift(fft_img);
end

% Compute log magnitude
log_magnitude = log1p(abs(fft_img_shifted));

% Display the log magnitude
imshow(log_magnitude, []);
colormap jet;
colorbar;
axis square;
title('Logarithmic amplitude of FFT');
end