function [x, y] = parse_csv(path)

    T = readtable(path);
    T_size = size(T);
    T = T(:, 2:T_size(2)); % skip first column, first row is already skiped
    A = table2array(T);
    
    x = A(:, 1:T_size(2)-2);
    y = A(:, T_size(2)-1); % last column is output, 1 is seizure
%     https://data.world/uci/epileptic-seizure-recognition/workspace
end