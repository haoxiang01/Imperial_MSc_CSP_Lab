function Rx= QPSK(M,num_symbols,SNR_dB,Tx_msg, H)
    % Perform QPSK modulation using gray code
    Tx= qammod(Tx_msg, M, 'gray','UnitAveragePower', true);
    
    % Reshape symbols into 2xN matrix for 2x2 MIMO
    Tx = reshape(Tx, 2, []);
    
    % Noise Matrix
    SNR_power= 10^(-SNR_dB/10);% SNR 
    noise = sqrt(SNR_power/2) * ((randn(2, num_symbols/2) + 1i*randn(2, num_symbols/2)));
    
    % Receive Matrix (Y = HX + N)
    Rx = H* Tx + noise;


% SNR_linear= power(10,SNR_dB/10);
% noise = sqrt(1/2) * (randn(2, num_symbols/2) + 1i*randn(2, num_symbols/2));
% 
% Rx =  sqrt(SNR_linear/ 2) *H * Tx + noise;
