clear all;clc;close all;

%% Basic Parameters
lambda = 0.2;
u = 0.2;
N_c = 10;
N_0 = 1;
h = [.1 + .1i, .2 + .8i, .01 + .2i, .1 + .9i, .3 + .1i, .1 + .7i, .09 + .02i, .1 + .8i, .4 + .8i, .1 + .3i];
abs_h_square = abs(h).^2;

%% Power allocation based on KKT Condition
P_n = 1./((lambda - u*abs_h_square) * log(2)) - N_0./abs_h_square;

% Setting elements of P_n less than 0 to 0
P_n(P_n < 0) = 0;

%% Plotting the optimal power allocations based on fixed lambda and u
figure(1);
carrierNoise = N_0 ./ abs_h_square;
carrierpower = P_n;
bar([carrierNoise; carrierpower].', 'stacked');
hold off; % Release the hold state
title(('Power allocation with Pd; \lambda = 0.2, \mu = 0.2'));
legend('noise to channel ratio', 'allocated power of each subchannel');
ylabel('Power');
xlabel('No. of Sub-channels');
saveas(gcf, 'Ex3_Step3.png', 'png');


%% Step4: increase Pd
max_abs_h_square = max(abs_h_square);
max_u = lambda / max_abs_h_square;
%generate 15 cases from u legal range
u_array = linspace(0, max_u, 8);
disp(u_array)

figure(2);
for index = 1:length(u_array)
    P_n = 1./((lambda - u_array(index) * abs_h_square) * log(2)) - N_0./abs_h_square;
    P_n(P_n < 0) = 0;
    subplot(3,4,index)
    carrierNoise = N_0 ./ abs_h_square;
    carrierpower = P_n;
    bar([carrierNoise; carrierpower].', 'stacked');
    title(['\lambda = 0.2, \mu = ', num2str(u_array(index))]);
    grid on;
    ylabel('Power');
    xlabel('No. of Sub-channels');
    if u_array(index)== 0
        thershold = 1./ (lambda* log(2));
        line(xlim, [thershold thershold], 'Color', 'g', 'LineStyle', '--','LineWidth', 1);
    end
end
sgtitle('power allocation with the increase of Pd');
saveas(gcf, 'Ex3_Step4.png', 'png');




