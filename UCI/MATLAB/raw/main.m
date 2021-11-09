% creates raw.csv matrix, rescaled with the last column as 0, 1.

clear all

[x, y] = parse_csv('../dataset/data/data.csv');

for i=1:numel(y)
    if y(i)~=1
        y(i)=0;
    end
end

fs = width(x);
sec = height(y);

max_value = max(max(x));
writematrix([rescale(x, 'InputMax', max_value*4/5), y], 'raw.csv')
