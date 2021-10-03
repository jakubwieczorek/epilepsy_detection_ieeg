T =  readtable(strcat('../../../uci/train_result.csv'));

A = table2array(T);
A_size = size(A);

stairs((1:A_size(1)), A(:, 1), 'r');
grid on
xlabel('Experiment No')
ylabel('Probability')
xlim([0 A_size(1)])
ylim([0 1.01])
hold on
stairs((1:A_size(1)), A(:, 2), '--b');
legend('predicted', 'expected')
hold off;