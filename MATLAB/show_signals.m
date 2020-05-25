clear all;
time='233'; % hours
patient='02';
seizure_number=1;

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');

load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(1, :);                           % get the first channel
N = length(y);                           % signal length

% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_begin_s = seizure_begin_s(seizure_begin_h==str2double(time));
seizure_end_h = ceil(seizure_end/3600);
seizure_end_s = ceil(mod(seizure_end, 3600));
seizure_end_s = seizure_end_s(seizure_end_h==str2double(time));

%% plot the signal in seconds
t1 = (0:N-1)/fs;                         % time vector
electrodes = size(EEG);
plotnum = 0;
f=figure(1);
for i=8%[8,9,37,50]%[8, 9, 37, 38, 39, 48, 49, 50]
    y = EEG(i, :);
    plotnum = plotnum+1;
    %figure(i)
    subplot(1,2,1);
    plot(t1, y, 'r');
    xlim([0 max(t1)])
    %ylim([-1.1*max(abs(y)) 1.1*max(abs(y))])
    ylim([-1500 1500])

    grid on
    xlabel('Time [s]')
    ylabel('Amplitude [\muV]')
    title('Train data');
    
    hold on
    y_desired = zeros(1, N);

    for j=1:numel(seizure_begin_s)
        y_desired(seizure_begin_s(j):seizure_end_s(j))=1;
    end
    stairs(y_desired*100, 'b');

end

time='230'; % hours
patient='02';
seizure_number=1;

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');

load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(1, :);                           % get the first channel
N = length(y);                           % signal length

% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_begin_s = seizure_begin_s(seizure_begin_h==str2double(time));
seizure_end_h = ceil(seizure_end/3600);
seizure_end_s = ceil(mod(seizure_end, 3600));
seizure_end_s = seizure_end_s(seizure_end_h==str2double(time));

%% plot the signal in seconds
t1 = (0:N-1)/fs;                         % time vector
electrodes = size(EEG);
plotnum = 0;
f=figure(1);
for i=8%[8,9,37,50]%[8, 9, 37, 38, 39, 48, 49, 50]
    y = EEG(i, :);
    plotnum = plotnum+1;
    %figure(i)
    subplot(1,2,2);
    plot(t1, y, 'r');
    xlim([0 max(t1)])
    %ylim([-1.1*max(abs(y)) 1.1*max(abs(y))])
    ylim([-1500 1500])
    grid on
    xlabel('Time [s]')
    ylabel('Amplitude [\muV]')
    title('Test data');
    
    hold on
    y_desired = zeros(1, N);

    for j=1:numel(seizure_begin_s)
        y_desired(seizure_begin_s(j):seizure_end_s(j))=1;
    end
    stairs(y_desired*100, 'b');

end
