clc
clear
close all

X = imread('cameraman.tif');

if size(X,3) == 3
    I = rgb2gray(X);
else
    I = X;
end

figure;
for i = 1:8
    k = 2^i*2;
    J = histeq(I, k);
    subplot(4,2,2*i-1), imhist(J,256); title(['Histogram with ' num2str(k) ' bins']);axis tight;
    subplot(4,2,2*i), imshow(J); title(['Image equalised by ' num2str(k) ' bins histogram']); 
end