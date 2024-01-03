function Rx= QPSK_Alam(M,num_symbols,SNR_dB,Tx_msg, H)
    % Perform QPSK modulation using gray code
    Tx= qammod(Tx_msg, M, 'gray','UnitAveragePower', true);
    
    % Alamouti encoding
    Tx_Alam = reshape(Tx, 2, []);
    Tx_Alam = [Tx_Alam; [-conj(Tx_Alam(2,:)); conj(Tx_Alam(1,:))]];
    
    % Convert the encoded symbols back to a single column for transmission
    Tx_Alam = reshape(Tx_Alam, [], 1);

    % Noise Matrix
    SNR_power= 10^(-SNR_dB/10);% SNR 
    noise = sqrt(SNR_power/2) * ((randn(2, num_symbols) + 1i*randn(2, num_symbols)));
    
    % Receive Matrix (Y = HX + N)
    Rx = H * reshape(Tx_Alam, 2, []) + noise;