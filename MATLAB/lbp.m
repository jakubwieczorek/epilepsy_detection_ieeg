clear all;
time='233'; % hours
patient='02';
seizure_number=-1;

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');

load(strcat('ID', patient, '/', exp_name, '.mat'));
load(strcat('ID', patient, '/ID', patient, '_info.mat'));

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

%% LBP
figure(6)
k=6;
k=floor(k/2);
lbp_values = zeros(1, N);

for i=1+k:N-k
    lbp_vector=y(i-k:i+k);
    
    for j=1:2*k
        if j~=i
            if lbp_vector(j) >= y(i)
                lbp_values(i) = lbp_values(i) + 2^j;
            end
        end
    end        
end

histogram(lbp_values)
xlabel('Time, s')
ylabel('LBP')
title(title_name);
