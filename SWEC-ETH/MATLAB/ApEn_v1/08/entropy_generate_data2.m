clearvars 

time='18'; % hours
patient='08';
electrode_number=1;

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

electrodes_num = 1; %numel(EEG(:,1));

iEEG_ApEn = zeros(1, N, electrodes_num);

for electrode=1:electrodes_num
    y = EEG(electrode, :);
    iEEG_ApEn_electrode = zeros(1, N);

    for i= 1: N-fs
        window = y(i: i+fs);
        sd1 = std(window);
        iEEG_ApEn_electrode(i) = ApEn(m, 0.05*sd1, window, tau);
        fprintf("%d out of %d\n", i, N-fs)
    end
    iEEG_ApEn(:, :, electrode) = iEEG_ApEn_electrode;
    fprintf("%d out of %d\n", electrode, electrodes_num)
end

save('iEEG_ApEn.mat', 'iEEG_ApEn')

%% y_desired
y_desired = zeros(1, N/fs);

for i=1:numel(seizure_begin_s)
    y_desired(seizure_begin_s(i):seizure_end_s(i))=1;    
end

y_desired_2 = zeros(1, N);
for i=1:3600
    y_desired_2((i-1)*fs+1: i*fs)=y_desired(i);   
end

%% plot
figure(str2num(time))
plot(iEEG_ApEn(:, :, 1), 'r')
xlim([0 numel(iEEG_ApEn(:, :, 1))])
ylim([-1.1*min(iEEG_ApEn(:, :, 1)) 1.1*max(abs(iEEG_ApEn(:, :, 1)))])
grid on
hold on
stairs(y_desired_2, 'b')
hold off

%% train data preparation -- whole set

dir_name = strcat('data', time);
mkdir(dir_name);

dataset = zeros(N/fs, fs, electrodes_num);
for electrode=1:electrodes_num
    y = EEG(electrode, :);
    dataset_electrode = zeros(N/fs, fs);

    idx=1;
    for i=1: fs: N-fs
        dataset_electrode(idx,:) = iEEG_ApEn(1, i: i+fs-1, electrode);
        idx=idx+1;
    end

    dataset(:, :, electrode) = dataset_electrode;
end

for electrode=1:electrodes_num
    file_name = strcat('data_', int2str(electrode), '.csv');
    writematrix([rescale(dataset(:, :, electrode), 'InputMax', 0.48), y_desired'], file_name)
    movefile(file_name, dir_name);
end
