% plots 512 histograms on two figures -- one for ictal
% second for interictal. Generates test and training data for neural
% network 
clearvars

time='233'; % hours
patient='02';
lbp_length=6;
electrode_number=8;
second_factor = 1;

exp_name =strcat('ID', patient, '_', time, 'h');

load(strcat('../../../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../../../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

N = length(EEG(electrode_number, :));                           % signal length
t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_begin_s = seizure_begin_s(seizure_begin_h==str2double(time));
seizure_end_h = ceil(seizure_end/3600);
seizure_end_s = ceil(mod(seizure_end, 3600));
seizure_end_s = seizure_end_s(seizure_end_h==str2double(time));
ictal_begin=seizure_begin_s*fs; 
ictal_end  =seizure_end_s  *fs;
number_of_histograms_ictal=(ictal_end-ictal_begin)/fs;

figure(1)
%% plot 512 histograms of ictal period on the same figure
electrodes_num = numel(EEG(:,1));
histogram_values_group_electrodes = zeros(number_of_histograms_ictal+1, 2^lbp_length);
for electrode=1:electrodes_num
    y = EEG(electrode, :);
    for i=0:number_of_histograms_ictal*second_factor
        window = y(ictal_begin + i*512/second_factor + 1 : ...
            ictal_begin + i*512/second_factor + 512/second_factor);

        [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
        lbp_values_group(i+1,:) = lbp_values;
        histogram_values_group(i+1,:) = histogram_values;
    end
    histogram_values_group_electrodes = histogram_values_group_electrodes + histogram_values_group;
end
histogram_values_group_electrodes = histogram_values_group_electrodes/electrodes_num;

y_desired = ones(1, number_of_histograms_ictal+1)';
%writematrix([rescale(histogram_values_group, 'InputMax', 245), y_desired], 'ictal.csv')
max(histogram_values_group_electrodes)
subplot(1,2,1);
bar(histogram_values_group_electrodes', 'hist')
xlabel('LBP value')
ylabel('Number of occurrences')
xlim([0 2^lbp_length + 1])
ylim([0 300])
title('ictal')
colorbar

histogram_values_group_electrodes1 = histogram_values_group_electrodes;
clear histogram_values_group lbp_values_group histogram_values_group_electrodes

%% plot 512 histograms of interictal period on the same figure
electrodes_num = numel(EEG(:,1));
histogram_values_group_electrodes = zeros(number_of_histograms_ictal+1, 2^lbp_length);
for electrode=1:electrodes_num
    y = EEG(electrode, :);
    for i=0:number_of_histograms_ictal*second_factor
        window = y(i*512/second_factor + 1 : i*512/second_factor + 512/second_factor);

        [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
        lbp_values_group(i+1,:) = lbp_values;
        histogram_values_group(i+1,:) = histogram_values;
    end
    histogram_values_group_electrodes = histogram_values_group_electrodes + histogram_values_group;
end
histogram_values_group_electrodes = histogram_values_group_electrodes/electrodes_num;

y_desired = zeros(1, number_of_histograms_ictal+1)';
%writematrix([rescale(histogram_values_group, 'InputMax', 245), y_desired], 'interictal.csv')
max(histogram_values_group_electrodes)
subplot(1,2,2);
bar(histogram_values_group_electrodes', 'hist')
xlabel('LBP value')
ylabel('Number of occurrences')
xlim([0 2^lbp_length + 1])
ylim([0 300])
title('interictal')
colorbar

histogram_values_group_electrodes2 = histogram_values_group_electrodes;


clear histogram_values_group lbp_values_group

%% difference
histogram_values_group_electrodes3 = histogram_values_group_electrodes2-histogram_values_group_electrodes1;
figure(2)
bar(histogram_values_group_electrodes3', 'hist')
xlabel('LBP value')
ylabel('Number of occurrences')
xlim([0 2^lbp_length + 1])
ylim([0 300])
title('difference')
colorbar


%% test data preparation -- whole set
%  y_desired is 1 where there is seizure, 0 otherwise
%  histogram_values_group contains histograms calculated from lbp
%  patterns where widow (bin) is 512 samples
y_desired = zeros(1, N/fs);

for i=numel(seizure_begin_s)
    y_desired(seizure_begin_s(i):seizure_end_s(i))=1;    
end

electrodes_num = numel(EEG(:,1));
histogram_values_group_electrodes = zeros(3600, 2^lbp_length);
for electrode=1:electrodes_num
    y = EEG(electrode, :);
    for i=0:N/fs-1
        window = y(i*512/second_factor + 1 : i*512/second_factor + 512/second_factor);

        [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
        lbp_values_group(i+1,:) = lbp_values;
        histogram_values_group(i+1,:) = histogram_values;
    end
    histogram_values_group_electrodes = histogram_values_group_electrodes + histogram_values_group;
end
histogram_values_group_electrodes = histogram_values_group_electrodes/electrodes_num;

% 300 for test and train data in order to rescale both datasets in the same
% way
writematrix([rescale(histogram_values_group_electrodes, 'InputMax', 280), y_desired'], 'train_data.csv')

%% check if y_desired is in the good place
t1 = (0:N-1)/fs;                         % time vector

figure(3)
plot(t1, y, 'r');
xlim([0 max(t1)])
ylim([-1.1*max(abs(y)) 1.1*max(abs(y))])
grid on
xlabel('Time, s')
ylabel('Amplitude, mV')
title('Signal');
hold on
stairs((1:3600),y_desired*1000, 'b');
hold off