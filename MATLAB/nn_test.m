T = readtable('../neural_network/raw/3_hidden/512_400_200_40_1/result.csv');
A = table2array(T);
A_size = size(A);

figure(1)
stairs((1:3600), A(:, 1), 'r');
grid on
xlabel('Time, s')
ylabel('Probability')
title('result')
hold on 
stairs((1:3600), A(:, 2), '--b');
legend('predicted', 'expected')
hold off;