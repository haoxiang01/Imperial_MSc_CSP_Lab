clc
clear
close all
addpath('Utils\')

img1 = imread('cameraman.tif');
img1 = im2double(img1);
figure();
imshow(img1);
title('Original Image');
figure();
fPlotFFT(img1,1);