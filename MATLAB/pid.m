%%
% pid regulator not used for the paper. Most likely will be exploited
% for the second version, because of derivative potential
%%
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
t1 = (0:N-1)/fs;                         % time vector

seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h = ceil(seizure_end/3600);

seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_end_s = ceil(mod(seizure_end, 3600));

if seizure_number ~= -1
    seizure_number=find(seizure_begin_h == str2double(time));
end
%% PID

for j=[8]
    y = EEG(j, :);

    figure(j)

    e=y;
    Kp=1;
    Ti=0.1;
    Td=1;

    u=zeros(1, N);
    e_1=0;
    ui_1=0;
    Ts=1/fs;
    for i=1:N
        up = 0; %Kp*e(i);
        ui= ui_1 + Kp/Ti * Ts*(e(i)+e_1)/2;
        ud= Kp*Td * (e(i)-e_1)/Ts;

        u(i) = up + ui + ud;

        ui_1=ui;
        e_1=e(i);
    end

    plot(t1, u, 'r')
    xlim([0 max(t1)])
    ylim([-1.1*max(u) 1.1*max(u)])
    grid on
    xlabel('Time, s')
    ylabel('u')
    title(title_name);

    if seizure_number ~= -1
        hold on
        plot(seizure_begin_s(seizure_number),u(seizure_begin_s(seizure_number)),'b*');
        plot(seizure_end_s(seizure_number),u(seizure_end_s(seizure_number)),'c*');
    end 
end

