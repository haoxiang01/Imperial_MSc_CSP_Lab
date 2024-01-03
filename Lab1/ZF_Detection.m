function q_symbols = ZF_Detection(Rx,SNR_dB,H,nT)
    % Convert SNR from dB to linear scale
    SNR_linear = power(10,SNR_dB/10);
    % demodulation
    ZF_Rx = (sqrt(SNR_linear/ nT) * H)^-1 * Rx;
    % Initialize an array for quantized symbols
    q_symbols = zeros(2, size(ZF_Rx,2));
    % Quantize each component of ZF symbols
    for idx = 1:size(ZF_Rx,2)
        q_symbols(1, idx) = Quantization(ZF_Rx(1,idx));
        q_symbols(2, idx) = Quantization(ZF_Rx(2,idx));
    end
    q_symbols = sqrt(1/2)*q_symbols; %UnitAveragePower
end
    