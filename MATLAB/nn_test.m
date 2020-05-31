% T =  readtable(strcat('../neural_network/fir/2_hidden/512_400_40_1/1000_epochs/train_result.csv'));
% T2 = readtable(strcat('../neural_network/fir/2_hidden/512_400_40_1/1000_epochs/test_result.csv'));
% 
% A = table2array(T);
% A_size = size(A);
% 
% subplot(1,2,1);
% stairs((1:3600), A(:, 1), 'r');
% grid on
% xlabel('Time [s]')
% ylabel('Probability')
% xlim([0 3600])
% ylim([0 1.01])
% hold on
% stairs((1:3600), A(:, 2), '--b');
% legend('predicted', 'expected')
% hold off;
% 
% A = table2array(T2);
% A_size = size(A);
% 
% subplot(1,2,2);
% stairs((1:3600), A(:, 1), 'r');
% grid on
% xlabel('Time [s]')
% ylabel('Probability')
% xlim([0 3600])
% ylim([0 1.01])
% hold on 
% stairs((1:3600), A(:, 2), '--b');
% legend('predicted', 'expected')
% hold off;

n=2;
subplotnum = 1;
for i = [10, 30]
    T =  readtable(strcat('../neural_network/fir/4_hidden/512_400_300_200_50_1/',string(i),'000_epochs/train_result.csv'));
    T2 = readtable(strcat('../neural_network/fir/4_hidden/512_400_300_200_50_1/',string(i),'000_epochs/test_result.csv'));
    
    A = table2array(T);
    A_size = size(A);

    subplot(n,2,2*subplotnum-1);
    stairs((1:3600), A(:, 1), 'r');
    grid on
    xlabel('Time [s]')
    ylabel('Probability')
    xlim([0 3600])
    ylim([0 1.01])
    hold on
    stairs((1:3600), A(:, 2), '--b');
    legend('predicted', 'expected')
    hold off;
    
    A = table2array(T2);
    A_size = size(A);

    subplot(n,2,2*subplotnum);
    stairs((1:3600), A(:, 1), 'r');
    grid on
    xlabel('Time [s]')
    ylabel('Probability')
    xlim([0 3600])
    ylim([0 1.01])
    hold on 
    stairs((1:3600), A(:, 2), '--b');
    legend('predicted', 'expected')
    hold off;
    
    subplotnum = subplotnum + 1;
end
