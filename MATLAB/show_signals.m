clear all;
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

seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h = ceil(seizure_end/3600);

seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_end_s = ceil(mod(seizure_end, 3600));

if seizure_number ~= -1
    seizure_number=find(seizure_begin_h == str2double(time));
end
%% plot the signal
% figure(1)
% plot(y, 'r');
% xlim([0 N])
% ylim([-1.1*max(abs(y)) 1.1*max(abs(y))])
% grid on
% xlabel('Samples')
% ylabel('Amplitude, \muV')
% title(title_name);
% 
% if seizure_number ~= -1
%     hold on
%     plot(seizure_begin_s(seizure_number)*fs,y(seizure_begin_s(seizure_number)*fs),'b*');
%     plot(seizure_end_s(seizure_number)*fs,y(seizure_end_s(seizure_number)*fs),'c*');
% end

%% plot the signal in seconds
t1 = (0:N-1)/fs;                         % time vector
electrodes = size(EEG);
for i=[8, 9, 37, 38, 39, 48, 49, 50]
    y = EEG(i, :);
    
    figure(i)
    plot(t1, y, 'r');
    xlim([0 max(t1)])
    ylim([-1.1*max(abs(y)) 1.1*max(abs(y))])
    grid on
    xlabel('Time, s')
    ylabel('Amplitude, mV')
    title(title_name);

    if seizure_number ~= -1
        hold on
        plot(seizure_begin_s(seizure_number),y(seizure_begin_s(seizure_number)),'b*');
        plot(seizure_end_s(seizure_number),y(seizure_end_s(seizure_number)),'c*');
    end
end
% 18, 08: i=[8, 9, 37, 38, 39, 48, 49, 50]