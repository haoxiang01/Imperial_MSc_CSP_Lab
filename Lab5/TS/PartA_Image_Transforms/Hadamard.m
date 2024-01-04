clc
clear
close all

% Read the image
img = imread('cameraman.tif');
% img = im2double(img);

% Convert to grayscale if necessary
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Resize image to the nearest power of 2 for both dimensions
[nrows, ncols] = size(img);
n = pow2(nextpow2(max(nrows, ncols))); % Compute the size for Hadamard matrix
resized_img = imresize(img, [n n]); % Resize the image


% Generate Hadamard matrix
H = hadamard(n); % Create a Hadamard matrix of size n x n
H_ordered = fOrderedHadamard(H);
% Apply Hadamard Transform
transformed_img = H * double(resized_img) * H / sqrt(n * n); % Perform the transformation
transformed_img_ordered = H_ordered * double(resized_img) * H_ordered / sqrt(n * n); % Perform the transformation

% Display the non-ordered Hadamard Transformed Image
figure();
subplot(1,2,1);
imshow(H,[]); title('The non-ordered Hadamard Matrix');
colormap gray;colorbar;axis square;axis on;

subplot(1,2,2);
imshow(log(abs(transformed_img) + 1), []); % Display the log of the absolute value to enhance visibility
title('The non-ordered Hadamard Transformed Image'); % Title for the displayed image
colormap gray;colorbar;axis square;axis on;

% Display the ordered Hadamard Transformed Image

figure();
subplot(1,2,1);
imshow(H_ordered,[]); title('The ordered Hadamard Matrix');
colormap gray;colorbar;axis square;axis on;

subplot(1,2,2);
imshow(log(abs(transformed_img_ordered) + 1), []); % Display the log of the absolute value to enhance visibility
title('The ordered Hadamard Transformed Image'); % Title for the displayed image
colormap gray;colorbar;axis square;axis on;

