clear all;
time='18'; % hours
patient='08';
seizure_number=1;

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');
load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(1, :);                           % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector

seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h = ceil(seizure_end/3600);

seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_end_s = ceil(mod(seizure_end, 3600));

if seizure_number ~= -1
    seizure_number=find(seizure_begin_h == str2double(time));
end

%% fir filter
for j=[8, 9, 37, 38, 39, 48, 49, 50]
    figure(j)
    
    y=EEG(j,:);
    k=fs;
    Nmean = ceil(N / k);
    t1 = (0:N-1)/fs;                         % time vector

    Pmean = zeros(1, N);                  
    for i = 1: N-k 
        Pmean(i) = mean(y(i: k+i));  % from 1 to k+1 mean, 2 to k+2 mean
    end
    
%     t1 = (0:Nmean-1)/fs;                         % time vector
%     Pmean = zeros(1, Nmean);                  
%     for i = 1: Nmean-1
%         Pmean(i) = mean(y((i-1)*k+1: i*k));  % from 1 to k mean, k+1 to 2k mean
%     end

    plot(t1, Pmean, 'r')
    xlim([0 max(t1)])
    ylim([-1.1*max(Pmean) 1.1*max(Pmean)])
    grid on
    xlabel('Time, s')
    ylabel('Power, \muW (SOI)')
    title('FIR');

    if seizure_number ~= -1
        hold on
        plot(t1(seizure_begin_s(seizure_number)),0,'b*');
        plot(t1(seizure_end_s(seizure_number)),0,'c*');
        hold off
    end
% 
%     hold on
%     [up, lo] = envelope(Pmean, 20000, 'peak');
%     plot(t1, up); 
%     hold off
end

