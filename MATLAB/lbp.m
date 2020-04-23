clear all;
time='233'; % hours
patient='02';
seizure_number=-1; % different than -1 perform some operation on seizure

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');

load(strcat('../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(1, :);                           % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

% seizure_begin_* and end_* are vectors with all seizures for the patient
seizure_begin_h = ceil(seizure_begin/3600);
seizure_end_h = ceil(seizure_end/3600);

seizure_begin_s = ceil(mod(seizure_begin, 3600));
seizure_end_s = ceil(mod(seizure_end, 3600));

% here extract seizure the seizure which is in the 'time' range for example
% 233 not 230, because 230 is for file 230...may
% if some operation on the seizure later on
if seizure_number ~= -1
    seizure_number=find(seizure_begin_h == str2double(time));
end

%% LBP
samples=fs/2; 
k=4;
k=floor(k/2);
lbp_values = zeros(1, samples); % 512 samples so 
bins_number=2^(2*k);
histogram_values=zeros(1, bins_number); % 256 potentialy different lbp values, 
% because 2^8 possibilities _ _ _ _ _ _ _ _. This is y axis for stairs, on X axis 
% 0 ... 256 for example zero occured 3 time than y(0)=3, x=0 itd. 
binomial_weights=zeros(1, 2*k+1);

for i=1:k
    binomial_weights(i)=2^(i-1);
end
for i=(k+2):(2*k+1)
    binomial_weights(i)=2^(i-2);
end
% for k=3 -> [1,2,4,0,8,16,32]

%for i=1+k:2*k+1:N-k
index = 1;
for i=1+k:samples-k
    index = index + 1;
    lbp_window_vector=y(i-k:i+k); % size 2*k+1
    
    for j=1:2*k+1 % loop through every element in a window
        if lbp_window_vector(j) >= y(i) % i element is 1 in binary vector
            lbp_values(index) = lbp_values(index) + binomial_weights(j);
            
        end
    end
    histogram_values(lbp_values(index)+1) = histogram_values(lbp_values(index)+1) + 1;
end

figure(6)
bar((0:bins_number-1), histogram_values)
title('bar')
figure(7)
histogram(lbp_values, bins_number);
title('histogram') %difference in zeros number, because histograms takes 
% as zeros also first k+1 and last N-k-1 values, so for 3 it takes 4+4
% zeros more what gives 34 + 8 = 42 zeros.

% so we have N/fs histograms and one histogram is generated every second

