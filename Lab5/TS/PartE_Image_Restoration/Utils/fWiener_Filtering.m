function restored_img = fWiener_Filtering(img, H, SNR_dB)
    [width, height] = size(img);
    N = size(H, 1);

    % Zero-padding the distortion matrix
    H_padding = zeros(width, height); 
    H_padding(1:N, 1:N) = H;
    H_padding_fft = fft2(H_padding);
    img_fft = fft2(img);

    % Power Spectrum of the degraded image
    pow_img = abs(img_fft).^2;

    % Convert SNR from dB to linear scale
    SNR_linear = 10^(SNR_dB / 10);

    % Estimate the noise power based on SNR
    signal_power = sum(sum(pow_img)) / (width * height);
    noise_pow = signal_power / SNR_linear;

    % Wiener Filter
    W = (pow_img .* conj(H_padding_fft)) ./ (pow_img .* abs(H_padding_fft).^2 + noise_pow);
    
    % Applying Wiener filter
    restored_img_fft = W .* img_fft;

    % Inverse Fourier Transform
    restored_img = ifft2(restored_img_fft);

    % Convert to real part to avoid imaginary data (due to numerical errors)
    restored_img = real(restored_img);
end
