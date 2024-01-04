clc
clear
close all

% Read the images
img1 = imread('cameraman.tif'); % Grayscale image
img2 = imread('kids.tif');    % RGB image

% Convert img2 to grayscale if it's RGB, as histogram matching requires both images to be of the same type
if size(img2, 3) == 3
    img2 = rgb2gray(img2);
end

% Histogram matching
% Match the histogram of img1 to that of img2
matched_img = imhistmatch(img1, img2);

% Display the images
subplot(3, 2, 1);
imshow(img1);
title('Original Image (Cameraman)');

subplot(3, 2, 2);
imhist(img1);
title('Histogram of Original Image');

subplot(3, 2, 3);
imshow(img2);
title('Reference Image (Kids)');

subplot(3, 2, 4);
imhist(img2);
title('Histogram of Reference Image');

subplot(3, 2, 5);
imshow(matched_img);
title('Histogram Matched Image');

subplot(3, 2, 6);
imhist(matched_img);
title('Histogram of Matched Image');
