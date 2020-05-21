%% single histogram figure of bar and histogram function to comparise
%  without calculate histogram function use
clear all;
time='233'; % hours
patient='02';

exp_name =strcat('ID', patient, '_', time, 'h');
title_name =strcat('ID', patient, '\_', time, 'h');

load(strcat('../../data/ID', patient, '/', exp_name, '.mat'));
load(strcat('../../data/ID', patient, '/ID', patient, '_info.mat'));

fs=double(fs);

y = EEG(1, :);                           % get the first channel
N = length(y);                           % signal length
t1 = (0:N-1)/fs;                         % time vector usually 3600 seconds

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

figure(1)
bar((0:bins_number-1), histogram_values)
title('bar')
figure(2)
histogram(lbp_values, bins_number);
title('histogram') %difference in zeros number, because histograms takes 
% as zeros also first k+1 and last N-k-1 values, so for 3 it takes 4+4
% zeros more what gives 34 + 8 = 42 zeros.

