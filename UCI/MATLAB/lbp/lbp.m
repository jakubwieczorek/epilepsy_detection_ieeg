clear all

[x, y] = parse_csv('../../../uci-epileptic-seizure-recognition/data/data.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

fs = width(x);
sec = height(y);

% lbp_length = 4;
lbp_length = 6;

for i=1:sec
    [histogram_values, lbp_values]=calculate_histogram(x(i,:), lbp_length);
    
    lbp_values_group(i,:) = lbp_values;
    histogram_values_group(i,:) = histogram_values;
end

max_value = max(max(histogram_values_group));
% writematrix([rescale(histogram_values_group, 'InputMax', max_value/2), y], 'data_lbp_4.csv')
writematrix([rescale(histogram_values_group, 'InputMax', max_value/2), y], 'data_lbp_6.csv')
