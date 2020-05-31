%%
% postprocess nn prediction and plot two predictions
% in two raws repeatedly to zoom a second one and check delays
%%

figure(1)

n=2;
subplot_num = 1;
for experiment = [15, 20, 15, 20]
    T2 = readtable(strcat('../neural_network/raw/3_hidden/512_400_250_30_1/',string(experiment),'000_epochs/test_result.csv'));
    prediction = table2array(T2);

    postprocessed=zeros(size(prediction));
    i=1;
    while i<=3600
        if prediction(i,1) >= 0.5
            for j=1:10
                if prediction(i+j,1) >= 0.5
                    postprocessed(i:i+j,1)=1;
                    break;
                end
            end
            i=i+j;
        else
            i=i+1;
        end
    end

    subplot(2,2,subplot_num)
    stairs((1:3600), postprocessed(:, 1), 'r');
    grid on
    xlabel('Time [s]')
    ylabel('Probability')
    xlim([0 3600])
    ylim([0 1.01])
    hold on 
    stairs((1:3600), prediction(:, 2), '--b');
    legend('predicted', 'expected')
    hold off;
    
    subplot_num=subplot_num+1;
end
