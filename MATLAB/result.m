T = readtable('../neural_network/result.txt');
A = table2array(T);
A_size = size(A);

figure(1)
plot(A(:, 17), 'r');
xlim([0 A_size(1)])
ylim([0 1])
grid on
xlabel('Time, s')
ylabel('Probability')
title('result');