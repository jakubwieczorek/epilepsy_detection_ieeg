clearvars;
time='230'; % hours
patient='02';
seizure_number=1;
lbp_length=4;
electrode_number=1;

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');

load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(electrode_number, :);                           % get the first channel
N = length(y);                           % signal length
y=y.^2;
seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h = ceil(seizure_end/3600);

seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_end_s = ceil(mod(seizure_end, 3600));

if seizure_number ~= -1
    seizure_number=find(seizure_begin_h == str2double(time));
end

%% plot the signal in seconds
t1 = (0:N-1)/fs;                         % time vector

figure(1)
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

%% histograms
bins= 2^lbp_length;
% window moves right by half a second
D_RAD=zeros(1,2*numel(y)/fs);

iteration = 1;
for i = 1 : fs/2 : numel(y)-fs/2-fs
    
    y_window1 = y(i: i+fs);
    y_window2 = y(i+fs/2: i+fs/2 + fs);
    [histogram_values1, lbp_values1]=calculate_histogram(y_window1, lbp_length);
    [histogram_values2, lbp_values2]=calculate_histogram(y_window2, lbp_length);

    D_KL_pq = 0;
    D_KL_qp = 0;

    for j =1: bins
        p = histogram_values1(j);
        q = histogram_values2(j);
        if p ~= 0 && q ~= 0
            D_KL_pq = D_KL_pq + p * (log(p) - log(q));
            D_KL_qp = D_KL_qp + q * (log(q) - log(p));
        end
    end
    
    D_RAD(iteration) = 1 / ((1/D_KL_pq) + (1/D_KL_qp));
    iteration = iteration + 1;
end
t_D_RAD = (0.5:0.5:3600);
figure(2)
plot(t_D_RAD, D_RAD, 'r');
xlim([0 max(t_D_RAD)])
grid on
xlabel('Time, s')
ylabel('RAD')
title(title_name);
if seizure_number ~= -1
    hold on
    plot(seizure_begin_s(seizure_number),D_RAD(seizure_begin_s(seizure_number)*2),'b*');
    plot(seizure_end_s(seizure_number),D_RAD(seizure_end_s(seizure_number)*2),'c*');
end

% % 1 second of a seizure
% histogram_number=histogram_number-1;
% y_ictal = y(ictal_begin(seizure_number) +  histogram_number   *fs : ...
%             ictal_begin(seizure_number) + (histogram_number+1)*fs);
% [histogram_values, lbp_values]=calculate_histogram(y_ictal, lbp_length);
% 
% % 1 second of an interictal period
% histogram_number_interictal=histogram_number_interictal-1;
% y_interictal = y(interactal_begin(interictal_number) +  histogram_number_interictal   *fs : ...
%                  interactal_begin(interictal_number) + (histogram_number_interictal+1)*fs);
% [histogram_values_interictal, lbp_values_interictal]=calculate_histogram(y_interictal, lbp_length);



% so we have N/fs histograms and one histogram is generated every second

%% learning data preparation
% 3 inputs in the NN
inputs_amount = 3;

D_RAD_rescaled = rescale(D_RAD);
x = zeros(inputs_amount, numel(D_RAD_rescaled)); 
y_desired = zeros(1, numel(D_RAD_rescaled));

for i=0:numel(D_RAD_rescaled)-3
    for j=1:inputs_amount
        x(j,i+1)=D_RAD_rescaled(i+j);
    end
end

for i=seizure_number'
    y_desired(seizure_begin_s(i)*2:seizure_end_s(i)*2)=1;% *2 because there are 7200 elements every 0.5s
end

t_D_RAD = (0.5:0.5:3600);
figure(3)
plot(t_D_RAD, rescale(D_RAD), 'r');
xlim([0 max(t_D_RAD)])
grid on
xlabel('Time, s')
ylabel('rescaled RAD')
title(title_name);
hold on 
plot(t_D_RAD, y_desired, 'b')

writematrix([x', y_desired'], 'dataset.csv')