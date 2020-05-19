clearvars

time='233'; % hours
patient='02';
electrode_number=1;
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
seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_begin_s = seizure_begin_s(seizure_begin_h==str2double(time));
seizure_end_h = ceil(seizure_end/3600);
seizure_end_s = ceil(mod(seizure_end, 3600));
seizure_end_s = seizure_end_s(seizure_end_h==str2double(time));


y_desired = zeros(1, N);
this_seizure_begin = seizure_begin_s*fs;
this_seizure_end = seizure_end_s*fs;
for i=numel(this_seizure_begin)
    y_desired(this_seizure_begin(i):this_seizure_end(i))=1;
    
end

index=1;
factor=4;
dataset = zeros(N/fs*factor, fs/2);
dataset_y = zeros(1, N/fs*factor);
for i=1: fs/factor: N-fs/2 % move every quarter of the second
    dataset(index,:) = y(electrode_number, i: i+fs/2-1); % half of the second samples
    dataset_y(index) = y_desired(i);
    index=index+1;
end
writematrix([rescale(dataset), dataset_y'], 'dataset.csv')
