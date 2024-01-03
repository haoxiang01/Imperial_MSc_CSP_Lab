clear all;clc;close all;

% Basic Parameters
SNR_dB = 0:1:30; % SNR in dB
SNR_linear= power(10,SNR_dB/ 10);% SNR in linear scale
N = 5:1:10; % Number of input and output antennas at the MIMO system
num_simulations = 10000; % Number of Monte Carlo simulations
C_ergodic = zeros(length(N), length(SNR_dB));% Predefine Shannon capacity matrix
    

% for each defined SNR
for SNR_index = 1:length(SNR_dB)
    SNR = SNR_linear(SNR_index); 

    % for each number of antennas at the MIMO system
    for N_index = 1:length(N)

        % define nR (number of receive antennas) = nT (number of transmit
        % antennas) in MIMO system
        nT = N(N_index);
        nR = nT;

        sum_capacity = 0;% Predefine Sum the capacity over all Monte Carlo simulations
        % Monte Carlo simulation
        for sim_loop = 1:num_simulations
            % Generate random Rayleigh fading channel matrix
            H = sqrt(1/2)*(randn(nR, nT) + 1i * randn(nR, nT));
            % Calculate instantaneous channel capacity in this simulation
            C_H = log2(det(eye(nR) + SNR/nT * (H' * H)));
            % Sum the capacity over all simulations
            sum_capacity = sum_capacity + C_H;
        end

        % Statistical average the capacity over all simulations
        C_ergodic(N_index, SNR_index) = sum_capacity / num_simulations;
    end
end

% Plot
figure(1);
plot(SNR_dB, C_ergodic);
xlabel('SNR (dB)');
ylabel('Capacity (bps/Hz)');
legend('nR=nT=5', 'nR=nT=6', 'nR=nT=7', 'nR=nT=8', 'nR=nT=9', 'nR=nT=10');
grid on;
saveas(gcf, '.\Exercise1.png');
