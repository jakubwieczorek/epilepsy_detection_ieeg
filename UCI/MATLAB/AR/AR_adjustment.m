% Calculates AR coefficient from the range between 1 and 50 for every EEG
% signal, saves for every experiment MSE, FitPercent, FPE and gets
% the mean of those measures of 11500 eegs for each ar length, that is 1,
% 2, 3, ..., 50. Finally plots means of MSE, FitPercent, FPE over the
% amount of coefficients (1, ..., 50)

clear all

[x, y] = parse_csv('../../dataset/data/data.csv');


results = {};
a_size = 50;

% amount of experiments (a_size)/ amount of EEG signals
MSE = zeros(numel(y), a_size);
FitPercent = zeros(numel(y), a_size);
FPE = zeros(numel(y), a_size);

for i=1:a_size
    for j=1:numel(y)
        results{i} = ar(iddata(double(x(j,:))'), i);
        FitPercent(j,i) = results{i}.Report.Fit.FitPercent;
        MSE(j,i) = results{i}.Report.Fit.MSE;
        FPE(j,i) = results{i}.Report.Fit.FPE;
    end
    fprintf("%d out of %d\n", i, a_size)
end

figure(1)
subplot(1,3,1);
plot(FitPercent(10,:));
title('FitPercent')

subplot(1,3,2);
plot(MSE(10,:));
title('MSE')

subplot(1,3,3);
plot(FPE(10,:));
title('FPE')

figure(2)
subplot(1,3,1);
%plot(mean(FitPercent(1:20,:)));
plot(mean(FitPercent));
title('Mean FitPercent')

subplot(1,3,2);
%plot(mean(MSE(1:20,:)));
plot(mean(MSE));
title('Mean MSE')

subplot(1,3,3);
%plot(mean(FPE(1:20,:)));
plot(mean(FPE));
title('Mean FPE')

save('MSE')
save('FitPercent')
save('FPE')