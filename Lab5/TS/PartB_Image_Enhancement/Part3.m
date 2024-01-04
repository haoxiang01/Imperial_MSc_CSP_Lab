clc
clear
close all

X = imread('trees.tif');
if size(X,3) == 3
    I = rgb2gray(X);
else
    I = X;
end
figure();
subplot(2,2,1), imshow(edge(I,'sobel'));title('Sobel');
subplot(2,2,2), imshow(edge(I,'roberts'));title('Roberts');
subplot(2,2,3), imshow(edge(I,'prewitt'));title('Prewitt');
subplot(2,2,4), imshow(edge(I,'Log'));title('Log');

% Custom Sobel kernels for +/- 45 degrees
sobel45 = [-2 -1 0; -1 0 1; 0 1 2];   % 45 degree kernel
sobelMinus45 = [0 1 2; -1 0 1; -2 -1 0]; % - 45 degrees kernel

% Edge detection using custom Sobel kernels
edges45 = imfilter(I, sobel45);
edgesMinus45 = imfilter(I, sobelMinus45);

% Combine the edges
edgesCombined = edges45 | edgesMinus45;

% Display the result
figure();
subplot(1,3,1), imshow(edges45);title('Edges at + 45 Degrees(Sobel)');
subplot(1,3,2), imshow(edgesMinus45);title('Edges at - 45 Degrees(Sobel)');
subplot(1,3,3), imshow(edgesCombined);title('Edges at +/- 45 Degrees(Sobel)');
