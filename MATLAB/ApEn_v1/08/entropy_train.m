
clearvars

time='233'; % hours
patient='02';
electrode_number=8;

exp_name =strcat('ID', patient, '_', time, 'h');

load(strcat('../../../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../../../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(electrode_number, :);            % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

%% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_begin_s = seizure_begin_s(seizure_begin_h==str2double(time));
seizure_end_h = ceil(seizure_end/3600);
seizure_end_s = ceil(mod(seizure_end, 3600));
seizure_end_s = seizure_end_s(seizure_end_h==str2double(time));


%% entropy calculation
m = 2;      % embedded dimension
tau = 1;    % time delay for downsampling

iEEG_ApEn = zeros(1, 3600);
idx = 1;
sf=8; % second_factor fs divisor

for i= 1: fs/sf: N-fs/sf+1
    window = y(i: i+fs/sf-1);
    sd1 = std(window);
    iEEG_ApEn(idx) = ApEn(m, sd1, window, tau);
    idx = idx + 1;
end

%% y_desired

y_desired = zeros(1, N/fs);

for i=1:numel(seizure_begin_s)
    y_desired(seizure_begin_s(i):seizure_end_s(i))=1;   
end

y_desired_2 = zeros(1, 3600*sf);
for i=1:3600
    y_desired_2((i-1)*sf+1: i*sf)=y_desired(i);   
end

%% plot

figure(str2num(time))
plot(iEEG_ApEn, 'r')
xlim([0 numel(iEEG_ApEn)])
ylim([-1.1*min(iEEG_ApEn) 1.1*max(abs(iEEG_ApEn))])
grid on
hold on
stairs(y_desired_2, 'b')
hold off

%% test data preparation -- whole set

dataset = zeros(N/fs, sf);

idx=1;
for i=1: sf: numel(iEEG_ApEn)-sf
    dataset(idx,:) = iEEG_ApEn(i: i+sf-1);
    idx=idx+1;
end

writematrix([rescale(dataset, 'InputMax', 0.48), y_desired'], 'train_data.csv')
