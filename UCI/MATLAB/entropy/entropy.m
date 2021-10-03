function [] = entropy(window_length)

    %clear all

    [x, y] = parse_csv('../../dataset/data/data.csv');

    for i=1:numel(y)
        if y(i)~=1
            y(i)=0;
        end
    end

    fs = width(x);
    sec = height(y);

    m = 2;      % embedded dimension


    %window_lenght=20; % bigger, the resolution is bigger
    iEEG_ApEn = zeros(sec, fs-window_length);

    for i=1:sec
        for j=1:fs-window_length
            window = x(i, j: j+window_length);
            sd1 = std(window);
            iEEG_ApEn(i, j) = ApEn(m, sd1, window); % the smaller std, the resolution is smaller
        end
        fprintf("%d out of %d\n", i, sec)
    end

    max_value = max(max(iEEG_ApEn));
    writematrix([rescale(iEEG_ApEn, 'InputMax', max_value*4/5), y], ...
        strcat('entropy_', num2str(window_length), '.csv'))
    
end