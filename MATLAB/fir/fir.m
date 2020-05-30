clear all;
time='230'; % hours
patient='02';
electrode_number=8;

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');
load(strcat('../../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(electrode_number, :);                           % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector

seizure_begin_h = ceil(seizure_begin/3600);
seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_begin_s = seizure_begin_s(seizure_begin_h==str2double(time));
seizure_end_h = ceil(seizure_end/3600);
seizure_end_s = ceil(mod(seizure_end, 3600));
seizure_end_s = seizure_end_s(seizure_end_h==str2double(time));

%% fir filter
figure(1)

k=fs;
m=1;

Pmean = zeros(1, N);                  
for i = k:m:N 
    Pmean(i) = mean(y(i-k+1: i));
end

y_desired = zeros(1, N/fs);

for i=numel(seizure_begin_s)
    y_desired(seizure_begin_s(i):seizure_end_s(i))=1;    
end

plot(t1, Pmean, 'r')
xlim([0 max(t1)])
ylim([1.1*min(Pmean) 1.1*max(Pmean)])
grid on
xlabel('Time, s')
ylabel('Power, \muW (SOI)')
title('FIR');
hold on 
stairs((1:3600),y_desired*100, 'b');

index=1;
factor=1;
dataset = zeros(N/fs*factor, fs);
for i=1: fs/factor: N-fs/factor+1 % move every quarter of the second
    dataset(index,:) = Pmean(i: i+fs-1); % half of the second samples
    index=index+1;
end
writematrix([rescale(dataset, 'InputMax', 100), y_desired'], 'test_data.csv')
