clearvars -except keepVariables histogram_values_group_ictal histogram_values_group_both histogram_values_group_interictal counter
time='233'; % hours
patient='02';
% 0 is the first one: histogram number for particular seizure
% every raw in number_of_histograms represents amount of histograms
% which can be computed for that raw, that is a seizure. For example
% number_of_histograms = [6;10;10;10;9;11;10;8]
% to compute an histogram in 5th second in seizure 2:
% histogram_number=5; 
% seizure_number=2;

histogram_number=1; % to increase by on every launch 
seizure_number=1;   % can be constant
histogram_group_pop_up=false; % first run must be false

histogram_number_interictal=1; % to increase by on every launch 
interictal_number=1;   % can be constant
lbp_length = 6;

exp_name =strcat('ID', patient, '_', time, 'h');

load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(1, :);                           % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h   = ceil(seizure_end/  3600);

% here extract the seizure which is in the 'time' range for example
% 233 not 230, because 230 is for file 230...mat
number_of_seizures=find(seizure_begin_h == str2double(time));

% only seizures from 'time' specific periods so for example 233h
seizure_begin_s=ceil(mod(seizure_begin(number_of_seizures), 3600));
seizure_end_s  =ceil(mod(seizure_end(  number_of_seizures), 3600));

% in samples (xxxxYYYYYYxxxxYYYYYxxxxYYxxxYxYYYYYYxYYYxxxxxx), where
% Y elements
ictal_begin=seizure_begin_s*fs; 
ictal_end  =seizure_end_s  *fs;
% X elemnets
interactal_begin=[1,           ictal_end']';
interactal_end  =[ictal_begin', numel(y)]';

number_of_histograms_ictal=(ictal_end-ictal_begin)/fs
number_of_histograms_intericatl=(interactal_end-interactal_begin)/fs

%% histograms

% 1 second of a seizure
histogram_number=histogram_number-1;
y_ictal = y(ictal_begin(seizure_number) +  histogram_number   *fs : ...
            ictal_begin(seizure_number) + (histogram_number+1)*fs);
[histogram_values, lbp_values]=calculate_histogram(y_ictal, lbp_length);

% 1 second of an interictal period
histogram_number_interictal=histogram_number_interictal-1;
y_interictal = y(interactal_begin(interictal_number) +  histogram_number_interictal   *fs : ...
                 interactal_begin(interictal_number) + (histogram_number_interictal+1)*fs);
[histogram_values_interictal, lbp_values_interictal]=calculate_histogram(y_interictal, lbp_length);

if histogram_group_pop_up == true 
    counter=counter+1;
else
    counter=1;
    clearvars histogram_values_group_ictal histogram_values_group_interictal histogram_values_group_both
end

histogram_values_group_ictal(counter, :)     =histogram_values;
histogram_values_group_interictal(counter, :)=histogram_values_interictal;
histogram_values_group_both(2*counter-1, :)  =histogram_values;
histogram_values_group_both(2*counter, :)    =histogram_values_interictal;


% figure(1)
% hold on
% bar(histogram_values)
% xlabel('LBP value')
% ylabel('Number of occurences')
% title('bar')
% legend()
% hold off

figure(2)
bar(histogram_values_group_ictal')
xlabel('LBP value')
ylabel('Number of occurences')
title('inctal')
legend()

% figure(3)
% hold on
% histogram(lbp_values, 2^lbp_length);
% xlabel('LBP value')
% ylabel('Number of occurences')
% title('histogram')
% hold off

figure(4)
bar(histogram_values_group_interictal')
xlabel('LBP value')
ylabel('Number of occurences')
title('interictal')
legend()

figure(5)
bar(histogram_values_group_both')
xlabel('LBP value')
ylabel('Number of occurences')
title('both')
legend()

% so we have N/fs histograms and one histogram is generated every second