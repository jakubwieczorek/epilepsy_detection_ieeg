% plots first 12 eeg signals on the seperate figures
% first one is for raw
% next ones are for entropy with window 20, 30, 40

clear all

addpath('..');

%% raw
[x, y] = parse_csv('../../dataset/data/data.csv');
x_size = width(x);
max_value = max(max(x));
x = rescale(x, 'InputMax', max_value*4/5);
for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

figure(1)
for i=1:2 % i=1:12
    %subplot(3,4,i);
    subplot(1,2,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    xlim([0 x_size]);
    ylim([0 0.8]);

    grid on
end
%% 5
[x, y] = parse_csv('entropy_5.csv');
for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end
figure(5)
for i=1:2
    subplot(1,2,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    xlim([0 x_size]);
    ylim([0 0.8]);
    grid on
end

%% 15
[x, y] = parse_csv('entropy_15.csv');
for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end
figure(15)
for i=1:2
    subplot(1,2,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    xlim([0 x_size]);
    ylim([0 0.8]);
    grid on
end

%% 30
[x, y] = parse_csv('entropy_30.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

figure(30)
for i=1:2
    subplot(1,2,i);
    plot(x(i,:), 'r');
    xlim([0 x_size]);
    title(num2str(y(i)));
    xlim([0 x_size]);
    ylim([0 0.8]);
    grid on
end

%% 40
[x, y] = parse_csv('entropy_40.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

figure(40)
for i=1:2
    subplot(1,2,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    xlim([0 x_size]);
    ylim([0 0.8]);
    grid on
end