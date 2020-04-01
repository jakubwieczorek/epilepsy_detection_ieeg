clear all;
time='233'; % hours
patient='02';
seizure_number=0; % different than -1 perform some operation on seizure

title_name =strcat('ID', patient, '\_', time, 'h');

load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(1, :);                           % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h = ceil(seizure_end/3600);

% here extract the seizure which is in the 'time' range for example
% 233 not 230, because 230 is for file 230...mat
if seizure_number ~= -1
    seizure_number=find(seizure_begin_h == str2double(time));
end
% only seizures from 'time' specific period so for example 233h
seizure_begin_s=ceil(mod(seizure_begin(seizure_number), 3600));
seizure_end_s  =ceil(mod(seizure_end(seizure_number),   3600));

% in samples (xxxxYYYYYYxxxxYYYYYxxxxYYxxxYxYYYYYYxYYYxxxxxx), where
% Y elements
ictal_begin=seizure_begin_s*fs; 
ictal_end  =seizure_end_s  *fs;
% X elemnets
interactal_begin=[0,           ictal_end];
interactal_end  =[ictal_begin, numel(y)];

number_of_histograms=(ictal_end-ictal_begin)/fs;