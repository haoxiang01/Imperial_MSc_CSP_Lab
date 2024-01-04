clc
clear
close all
X = imread('autumn.tif');
img_X = im2double(X);
figure();
imshow(img_X);
I = rgb2gray(X);
J = dct2(I);
figure();
colormap(jet(64)), imagesc(log(abs(J))), colorbar