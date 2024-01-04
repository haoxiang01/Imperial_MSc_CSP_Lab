clc
clear
close all

% Read the image and convert it to grayscale
X = imread('autumn.tif');
I = rgb2gray(X);

% Set the block size
blockSize = 8;

% Get the dimensions of the image
[rows, cols] = size(I);

% Define a range of threshold values to test
thresholds = [5, 10, 20, 35, 55, 80];

% Number of thresholds
numThresholds = length(thresholds);

% Create a figure for displaying images
figure;

% Loop through each threshold
for t = 1:numThresholds
    % Current threshold
    threshold = thresholds(t);

    % Initialize the matrix for the reconstructed image
    K = zeros(rows, cols);

    % Process each 8x8 block
    for i = 1:blockSize:rows
        for j = 1:blockSize:cols
            % Extract the block
            block = I(i:min(i+blockSize-1, rows), j:min(j+blockSize-1, cols));

            % Apply DCT to the block
            J = dct2(block);

            % Apply the threshold
            J(abs(J) < threshold) = 0;

            % Perform IDCT
            block = idct2(J);

            % Place the processed block back into the image
            K(i:min(i+blockSize-1, rows), j:min(j+blockSize-1, cols)) = block;
        end
    end

    % Adjust the range of the result for display
    K = mat2gray(K);

    % Display the reconstructed image with threshold in the title
    subplot(2, 3, t), imshow(K), title(['Threshold = ', num2str(threshold)]);
end
