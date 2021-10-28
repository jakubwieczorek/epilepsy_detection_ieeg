% preprocesses raw data, creates csv file with matrix of 11500 rows,
% representing ar coefficients for each eeg. The last column 0, 1.

clear all

addpath('..')

[x, y] = parse_csv('../../dataset/data/data.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

a_size = numel(y);
ar_len = 11;
coeff = zeros(height(x), ar_len);

for j=1:a_size
    result = ar(iddata(double(x(j,:))'), ar_len);
    coeff(j,:) = result.Report.Parameters.ParVector;
    fprintf("%d out of %d\n", j, a_size)
end

max_value = max(max(coeff));
writematrix([rescale(coeff, 'InputMax', max_value*4/5), y], ...
     strcat('AR_', num2str(ar_len), '.csv'))
