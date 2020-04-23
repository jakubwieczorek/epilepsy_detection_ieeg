clearvars

time='230'; % hours
patient='02';
lbp_length=4;
electrode_number=1;
second_factor = 1;
seizure_number = 1;

exp_name =strcat('ID', patient, '_', time, 'h');

load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(electrode_number, :);                           % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h = ceil(seizure_end/3600);
seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_end_s = ceil(mod(seizure_end, 3600));
ictal_begin=seizure_begin_s*fs; 
ictal_end  =seizure_end_s  *fs;
number_of_histograms_ictal=(ictal_end-ictal_begin)/fs;

for i=0:number_of_histograms_ictal(seizure_number)*second_factor
    window = y(ictal_begin(seizure_number) + i*512/second_factor + 1 : ...
        ictal_begin(seizure_number) + i*512/second_factor + 512/second_factor);

    [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
    lbp_values_group(i+1,:) = lbp_values;
    histogram_values_group(i+1,:) = histogram_values;
end
y_desired = ones(1, number_of_histograms_ictal(seizure_number)+1)';
writematrix([rescale(histogram_values_group, 'InputMax', 245), y_desired], 'ictal.csv')
max(histogram_values_group)
figure(1)
bar(histogram_values_group', 'hist')
xlabel('LBP value')
ylabel('Number of occurences')
xlim([0 2^lbp_length + 1])
title('ictal')
colorbar

clear histogram_values_group lbp_values_group

for i=0:number_of_histograms_ictal(seizure_number)*second_factor
    window = y(i*512/second_factor + 1 : i*512/second_factor + 512/second_factor);

    [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
    lbp_values_group(i+1,:) = lbp_values;
    histogram_values_group(i+1,:) = histogram_values;
end
y_desired = zeros(1, number_of_histograms_ictal(seizure_number)+1)';
writematrix([rescale(histogram_values_group, 'InputMax', 245), y_desired], 'interictal.csv')
max(histogram_values_group)
figure(2)
bar(histogram_values_group', 'hist')
xlabel('LBP value')
ylabel('Number of occurences')
xlim([0 2^lbp_length + 1])
title('interictal')
colorbar

clear histogram_values_group lbp_values_group

%% test data preparation -- whole set
for i=0:N/fs-1
    window = y(i*512/second_factor + 1 : i*512/second_factor + 512/second_factor);

    [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
    lbp_values_group(i+1,:) = lbp_values;
    histogram_values_group(i+1,:) = histogram_values;
end
writematrix(rescale(histogram_values_group, 'InputMax', 245), 'test.csv')

%disp('conclusion: histograms gathered from LBP patterns during ictal and intercital periods in raw data are impossible to distinguish');