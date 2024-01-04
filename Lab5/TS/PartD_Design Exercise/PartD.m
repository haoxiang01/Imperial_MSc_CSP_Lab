clc
clear
close all

% Parameters
addpath('../Image/')
addpath('Utils/')
blockSizes = [2, 4, 8, 16, 32, 64];
SNR_dB = 0; % Desired Signal-to-Noise Ratio in dB

imageFile = '25.png';

% Read, resize and convert the image to grayscale
I_original = imread(imageFile);
I = imresize(I_original, [128 128]);
I_gray = rgb2gray(I);
compressedRatio = 4;

% Create a figure
figure;

% main title
mainTitle = ['Images with Different Block Sizes (SNR: ', num2str(SNR_dB), ' dB)'];
sgtitle(mainTitle);

for idx = 1:length(blockSizes)
    blockSize = blockSizes(idx);
    
    for plotIdx = 1:5
        % Transmitter
        I_compressed = fDCT_Tx(I_gray, blockSize, compressedRatio);
        
        % fAWGN
        I_noisy = fAWGN(I_compressed, SNR_dB);

        % Receiver
        I_received_noisless = fIDCT_Rx(I_compressed, blockSize);
        I_received_noisy = fIDCT_Rx(I_noisy, blockSize);
        % Display the images
        subplot(length(blockSizes), 5, 5 * (idx - 1) + plotIdx);
        
        switch plotIdx
            case 1
                imshow(I_gray), title(['Original Image (Block Size: ', num2str(blockSize), ')']);
            case 2
                imshow(I_compressed), title(['Transmitted Compressed Image (Block Size: ', num2str(blockSize), ')']);
            case 3
                imshow(I_noisy), title(['Received Noisy Image (Block Size: ', num2str(blockSize), ')']);
            case 4
                imshow(I_received_noisless), title(['Reconstructed Image, No Noise (Block Size: ', num2str(blockSize), ')']);
            case 5
                imshow(I_received_noisy), title(['Reconstructed Image, AWGN (Block Size: ', num2str(blockSize), ')']);
        end
    end
end
