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

figure(2)
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
%% plot the signal energy
P=y.^2;

figure(3)
plot(t1, y.^2, 'r')
xlim([0 max(t1)])
ylim([-1.1*max(P) 1.1*max(P)])
grid on
xlabel('Time, s')
ylabel('Energy, \muJ')
title('Energy');

if seizure_number ~= -1
    hold on
    plot(seizure_begin_s(seizure_number),P(seizure_begin_s(seizure_number)),'b*');
    plot(seizure_end_s(seizure_number),P(seizure_end_s(seizure_number)),'c*');
end

%% plot mean -> SOI
figure(4)
k=fs; % mean of 512 samples -> every second

% SOI - mean on each sample
Pmean = zeros(1, N);                  
for i = 1: N-k 
    Pmean(i) = mean(P(i: k+i));  % from 1 to k+1 mean, 2 to k+2 mean
end

plot(t1, Pmean, 'r')
xlim([0 max(t1)])
ylim([-1.1*max(Pmean) 1.1*max(Pmean)])
grid on
xlabel('Time, s')
ylabel('Power, \muW (SOI)')
title('SOI');

if seizure_number ~= -1
    hold on
    plot(seizure_begin_s(seizure_number),Pmean(seizure_begin_s(seizure_number)),'b*');
    plot(seizure_end_s(seizure_number),Pmean(seizure_end_s(seizure_number)),'c*');
end

hold on
[up, lo] = envelope(Pmean, 20000, 'peak');
plot(t1, up); 

%% PID
figure(5)

e=y;
Kp=15;
Ti=1000000;
Td=1;

u=zeros(1, N);
e_1=0;
ui_1=0;
Ts=1/fs;
for i=1:N
    up = Kp*e(i);
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
title('PID');

if seizure_number ~= -1
    hold on
    plot(seizure_begin_s(seizure_number),u(seizure_begin_s(seizure_number)),'b*');
    plot(seizure_end_s(seizure_number),u(seizure_end_s(seizure_number)),'c*');
end

%% plot mean -> SOI downsample
figure(6)
kd=ceil(fs/512); % mean of 512 samples -> every second

t = downsample(t1, kd);
Nd = ceil(N / kd);
% SOI - mean on each sample
Pmeand = zeros(1, Nd);                  
for i = 1: Nd-1
    Pmeand(i) = mean(P((i-1)*kd+1: i*kd));  % from 1 to k mean, k+1 to 2k mean
end

plot(t, Pmeand, 'r')
xlim([0 max(t)])
ylim([-1.1*max(Pmeand) 1.1*max(Pmeand)])
grid on
xlabel('Time, s')
ylabel('Power, mean \muW downsample')
title('SOI downample');

if seizure_number ~= -1
    hold on
    plot(seizure_begin_s(seizure_number),Pmeand(seizure_begin_s(seizure_number)),'b*');
    plot(seizure_end_s(seizure_number),Pmeand(seizure_end_s(seizure_number)),'c*');
end

hold on
[up, lo] = envelope(Pmeand, 2000, 'peak');
plot(t, up); 

