clear all;clc;close all;

% Basic Parameters
nT = 2; % Number of transmit antennas
nR = nT; % Number of receive antennas
SNR_dB_range= 0:5:35; % SNR in dB
step = 5;% SNR Iteration Step
M = 4; % QPSK modulation, so M=4
num_bits = 1e6;% Number of sended bits
H_rounds = 1; % Number of random matrices H for each SNR
bit_symbol = log2(M); % bit per symbol
num_symbols = num_bits/ bit_symbol;% Number of sended symbols
AVG_BER_ZF = zeros(1,length(SNR_dB_range));%ZF detection Bit Error Rate
AVG_BER_ML = zeros(1,length(SNR_dB_range));%ML detection Bit Error Rate
AVG_BER_MMSE = zeros(1,length(SNR_dB_range));%MMSE detection Bit Error Rate
Tx_msg = randi([0, M-1], 1, num_symbols); % Generate random sended data

parfor SNR_loop= 1: 8% Multithreaded parallel computing
    SUM_BER_ML = 0;
    SUM_BER_ZF = 0;
    SUM_BER_MMSE = 0;
    SNR_dB = (SNR_loop-1)*5
    for H_loop = 1:H_rounds
        % Generate random Rayleigh fading channel matrix
        H = sqrt(1/2)*(randn(nR, nT) + 1i * randn(nR, nT));
 
        %QPSK modulation
        Rx = QPSK(M,num_symbols,SNR_dB,Tx_msg, H);
    
        % ML Detection
        ML_symbols = ML_Detection(Rx,M,H,num_symbols,nT);
        
        % ZF Detection
        ZF_symbols = ZF_Detection(Rx,SNR_dB,H,nT);
        
        % MMSE Detection
        MMSE_symbols = MMSE_Detection(Rx,SNR_dB,H,nT);
        
        % Demodulate using QAM demodulation
        ML_Rx_msg = qamdemod(reshape(ML_symbols, 1, []), M, 'gray', 'UnitAveragePower', true);
        ZF_Rx_msg = qamdemod(reshape(ZF_symbols, 1, []), M, 'gray', 'UnitAveragePower', true);
        MMSE_Rx_msg = qamdemod(reshape(MMSE_symbols, 1, []), M, 'gray', 'UnitAveragePower', true);
        
        % Calculate BER
        BER_ML= sum(Tx_msg ~= ML_Rx_msg) / num_symbols;
        SUM_BER_ML = SUM_BER_ML + BER_ML;

        BER_ZF= sum(Tx_msg ~= ZF_Rx_msg) / num_symbols;
        SUM_BER_ZF = SUM_BER_ZF + BER_ZF;
 
        BER_MMSE= sum(Tx_msg ~= MMSE_Rx_msg) / num_symbols;
        SUM_BER_MMSE = SUM_BER_MMSE + BER_MMSE;
    end
    % Statistical average the BER
    AVG_BER_ML(SNR_loop) = SUM_BER_ML/H_rounds;
    AVG_BER_ZF(SNR_loop) = SUM_BER_ZF/H_rounds;
    AVG_BER_MMSE(SNR_loop) = SUM_BER_MMSE/H_rounds;
end

%Plot
figure(1);
semilogy(SNR_dB_range, AVG_BER_ML);
hold on;
semilogy(SNR_dB_range, AVG_BER_ZF);
semilogy(SNR_dB_range,  AVG_BER_MMSE);
grid on;
axis([0,35,-inf,1]);
xlabel('SNR(dB)');
ylabel('Bit Error Rate');
legend('ML','ZF','MMSE');
