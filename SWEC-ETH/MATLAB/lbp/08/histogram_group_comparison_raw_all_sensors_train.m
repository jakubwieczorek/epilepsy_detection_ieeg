% plots 512 histograms on two figures -- one for ictal
% second for interictal. Generates test and training data for neural
% network 
clearvars

time='122'; % hours
patient='08';
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


%% test data preparation -- whole set
%  y_desired is 1 where there is seizure, 0 otherwise
%  histogram_values_group contains histograms calculated from lbp
%  patterns where widow (bin) is 512 samples
y_desired = zeros(1, N/fs);

for i=1:numel(seizure_begin_s)
    y_desired(seizure_begin_s(i):seizure_end_s(i))=1;    
end

electrodes_num = numel(EEG(:,1));
histogram_values_group_electrodes = zeros(3600, 2^lbp_length, electrodes_num);
for electrode=1:electrodes_num
    y = EEG(electrode, :);
    for i=0:N/fs-1
        window = y(i*512/second_factor + 1 : i*512/second_factor + 512/second_factor);

        [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
        lbp_values_group(i+1,:) = lbp_values;
        histogram_values_group(i+1,:) = histogram_values;
    end
    histogram_values_group_electrodes(:, :, electrode) = histogram_values_group;
end

% 300 for test and train data in order to rescale both datasets in the same
% way
dir_name = strcat('train_data', time);
mkdir(dir_name);
for electrode=1:electrodes_num
    file_name = strcat('train_data', int2str(electrode), '.csv');
    writematrix([rescale(histogram_values_group_electrodes(:, :, electrode), 'InputMax', 280), y_desired'], file_name);
    movefile(file_name, dir_name);
end

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