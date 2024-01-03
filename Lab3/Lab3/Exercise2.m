clear all;clc;close all;

%% Basic Parameters
lambda = 0.28;
N_c = 10;
N_0 = 1;
h = [.1 + .1i, .2 + .8i, .01 + .2i, .1 + .9i, .3 + .1i, .1 + .7i, .09 + .02i, .1 + .8i, .4 + .8i, .1 + .3i];
abs_h_square = abs(h).^2;

%% Power allocation based on KKT Condition
P_n = 1/(lambda * log(2)) - N_0./abs_h_square;

% Setting elements of P_n less than 0 to 0
P_n(P_n < 0) = 0;

%% Plotting the optimal power allocations
carrierNoise = N_0 ./ abs_h_square;
carrierpower = P_n;
bar([carrierNoise; carrierpower].', 'stacked');

% Add a baseline
thershold = 1./ (lambda* log(2));
line(xlim, [thershold thershold], 'Color', 'g', 'LineStyle', '--','LineWidth', 1);
hold off; % Release the hold state
title('Water Filling Solution Using KKT');
legend('noise to channel ratio', 'allocated power of each subchannel','thershold');
ylabel('Power');
xlabel('No. of Sub-channels');
saveas(gcf, 'Ex2.png', 'png');
