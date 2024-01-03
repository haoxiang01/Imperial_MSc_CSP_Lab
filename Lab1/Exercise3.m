clear all;clc;close all;
profile on;
% Basic Parameters
nT = 2; % Number of transmit antennas
nR = nT; % Number of receive antennas
SNR_dB_range= 0:5:35; % SNR in dB
step = 5;% SNR Iteration Step
M = 4; % QPSK modulation, so M=4
num_bits = 1e6;% Number of sended bits
H_rounds = 1000; % Number of random matrices H for each SNR
bit_symbol = log2(M); % bit per symbol
num_symbols = num_bits/ bit_symbol;% Number of sended symbols
AVG_BER_ML = zeros(1,length(SNR_dB_range));%ML detection Bit Error Rate
AVG_BER_Alam = zeros(1,length(SNR_dB_range));%Alamouti code Bit Error Rate
Tx_msg = randi([0, M-1], 1, num_symbols); % Generate random sended data

parfor SNR_loop= 1: 8 % Multithreaded parallel computing
    SUM_BER_ML = 0;
    SUM_BER_Alam = 0;
    SNR_dB = (SNR_loop-1)*5;
    %disp(['SNR_dB:', num2str(SNR_dB)]);
    %SNR_dB = 30;
    for H_loop = 1:H_rounds
        % Generate random Rayleigh fading channel matrix
        H = sqrt(1/2)*(randn(nR, nT) + 1i * randn(nR, nT));
 
        %QPSK modulation
        Rx = QPSK(M,num_symbols,SNR_dB,Tx_msg, H);
        Rx_Alam = QPSK_Alam(M,num_symbols,SNR_dB,Tx_msg, H);

        % ML Detection
        ML_symbols = ML_Detection(Rx,M,H,num_symbols,nT);
        ML_symbols_Alam = ML_Detection_Alam(Rx_Alam,M,H,num_symbols,nT);

        % Demodulate using QAM demodulation
        ML_Rx_msg = qamdemod(reshape(ML_symbols, 1, []), M, 'gray', 'UnitAveragePower', true);
        Alam_Rx_msg = qamdemod(reshape(ML_symbols_Alam, 1, []), M, 'gray', 'UnitAveragePower', true);
        
        % Calculate BER
        BER_ML= sum(Tx_msg ~= ML_Rx_msg) / num_symbols;
        SUM_BER_ML = SUM_BER_ML + BER_ML;
        BER_Alam= sum(Tx_msg ~= Alam_Rx_msg) / num_symbols;
        SUM_BER_Alam = SUM_BER_Alam + BER_Alam;
%         disp(['BER ML:', num2str(SUM_BER_ML)]);
%         disp(['BER Alam:', num2str(SUM_BER_Alam)]);

    end
    % Statistical average the BER
    AVG_BER_ML(SNR_loop) = SUM_BER_ML/H_rounds;
    AVG_BER_Alam(SNR_loop) = SUM_BER_Alam/H_rounds;
end

%Plot
figure(1);
semilogy(SNR_dB_range, AVG_BER_Alam);
hold on;
semilogy(SNR_dB_range, AVG_BER_ML);
grid on;
axis([0,35,-inf,1]);
xlabel('SNR(dB)');
ylabel('Bit Error Rate');
legend('ML With Alamouti','ML');

profile off;
