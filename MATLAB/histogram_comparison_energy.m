clearvars

time='233'; % hours
patient='02';
lbp_length=6;
electrode_number=1;
second_factor = 1;

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

%energy
y=y.^2;

for i=0:number_of_histograms_ictal(2)*second_factor
    window = y(ictal_begin(2) + i*512/second_factor + 1 : ...
        ictal_begin(2) + i*512/second_factor + 512/second_factor);

    [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
    lbp_values_group(i+1,:) = lbp_values;
    histogram_values_group(i+1,:) = histogram_values;
end

figure(1)
bar(histogram_values_group', 'hist')
xlabel('LBP value')
ylabel('Number of occurences')
xlim([0 2^lbp_length + 1])
title('ictal')
colorbar

clear histogram_values_group lbp_values_group

for i=0:number_of_histograms_ictal(2)*second_factor
    window = y(i*512/second_factor + 1 : i*512/second_factor + 512/second_factor);

    [histogram_values, lbp_values]=calculate_histogram(window, lbp_length);
    lbp_values_group(i+1,:) = lbp_values;
    histogram_values_group(i+1,:) = histogram_values;
end

figure(2)
bar(histogram_values_group', 'hist')
xlabel('LBP value')
ylabel('Number of occurences')
xlim([0 2^lbp_length + 1])
title('interictal')
colorbar

disp('conclusion: histograms gathered from LBP patterns during ictal and intercital periods in raw data are impossible to distinguish'); 