function I_noisy = fAWGN(I, SNR_dB)
    % Calculate the power of the transmitted signal
    signalPower = sum(I(:).^2) / numel(I);

    % Calculate the noise power based on the desired SNR
    SNR_linear = 10^(SNR_dB / 10);
    noisePower = signalPower / SNR_linear;

    % Generate Gaussian noise with the calculated noise power
    noise = sqrt(noisePower) * randn(size(I));
    I_noisy = I + noise;
