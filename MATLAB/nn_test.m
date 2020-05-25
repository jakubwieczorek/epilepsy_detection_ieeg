T =  readtable('../neural_network/lbp/3_hidden/64_64_64_64_1/100_epochs/train_result.csv');
T2 = readtable('../neural_network/lbp/3_hidden/64_64_64_64_1/100_epochs/test_result.csv');

A = table2array(T);
A_size = size(A);

subplot(1,2,1);
stairs((1:3600), A(:, 1), 'r');
grid on
xlabel('Time [s]')
ylabel('Probability')
xlim([0 3600])
ylim([0 1.01])
title('NN adjustment')
hold on
stairs((1:3600), A(:, 2), '--b');
legend('predicted', 'expected')
hold off;

A = table2array(T2);
A_size = size(A);

subplot(1,2,2);
stairs((1:3600), A(:, 1), 'r');
grid on
xlabel('Time [s]')
ylabel('Probability')
xlim([0 3600])
ylim([0 1.01])
title('Test')
hold on 
stairs((1:3600), A(:, 2), '--b');
legend('predicted', 'expected')
hold off;