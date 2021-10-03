% plots first 12 eeg signals on the seperate figures
% first one is for raw
% next ones are for entropy with window 20, 30, 40

clear all

addpath('..');

[x, y] = parse_csv('../../dataset/data/data.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

figure(1)
for i=1:12
    subplot(3,4,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    grid on
end

[x, y] = parse_csv('entropy_20.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

figure(2)
for i=1:12
    subplot(3,4,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    grid on
end

[x, y] = parse_csv('entropy_30.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

figure(3)
for i=1:12
    subplot(3,4,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    grid on
end

[x, y] = parse_csv('entropy_40.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

figure(4)
for i=1:12
    subplot(3,4,i);
    plot(x(i,:), 'r');
    title(num2str(y(i)));
    grid on
end