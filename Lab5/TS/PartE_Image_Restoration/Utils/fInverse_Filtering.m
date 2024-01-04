function restored_img = fInverse_Filtering(img, H)
    % Determine the dimensions of the input image
    [width, height] = size(img);

    % Get the size of the degradation function H
    N = size(H, 1);
    
    % Initialize a zero-padded matrix for H
    H_padding = zeros(width, height); 

    % Padding H with zeros to match the size of the input image
    H_padding(1:N, 1:N) = H;

    % Compute the Fourier transform of the zero-padded H
    H_padding_fft = fft2(H_padding);

    % Compute the Fourier transform of the input image
    img_fft = fft2(img);
    
    % Apply inverse filtering: divide the Fourier transform of the image by 
    % the Fourier transform of the padded H
    restored_img_fft = img_fft ./ H_padding_fft;

    % Compute the inverse Fourier transform to obtain the restored image
    restored_img = ifft2(restored_img_fft);
end

