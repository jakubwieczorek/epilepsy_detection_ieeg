load('FPE')

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