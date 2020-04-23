function [histogram_values, lbp_values] = calculate_histogram(y, P)
% P is even like 8 or 6
% y is a part of the signal numel(y) > 2^P like 512
% histogram_values vector is shifted one right so number of zeros is on 
%                  first element, that is because in MATLAB no zeroth index
    P_2 = P/2;
    N =numel(y);
    % vector with content for example for P=3: [0 0 0 128 3 15 36 .. 0 0 0]
    lbp_values = zeros(1, N); 
    
    % amount of possible lbp values for example 2^8=256
    bins_number = 2^P;
    %bins_number = 2^(P+1); %aftre the change now!!!

    
    % in histogram_values on X axis 0 ... 256 and on Y number of occurences
    % for example lbp_value = 3 occured 6 times so on Y 6 on X 3
    histogram_values = zeros(1, bins_number);
    
    % for k=3 -> [1,2,4,0,8,16,32] aftre the change now!!!
    % for k=3 -> [1,2,4,0,16,32,64] 

    binomial_weights=zeros(1, P+1);
    for i=1:P_2 % first half
        binomial_weights(i)=2^(i-1);
    end
    % P+1 is a middle value -> thresholds in binomial_weights is 0
    for i=(P_2+2):(P+1) % second half
        binomial_weights(i)=2^(i-2); %aftre the change now!!!
%        binomial_weights(i)=2^(i-1); 

    end

    for i=P_2+1:N-P_2 % first P/2 and last P/2 not counted
        lbp_vector=y(i-P_2:i+P_2); % size P+1, so with threshold value

        for j=1:P+1 % loop through every element in a window
            if lbp_vector(j) >= y(i) % i element is 1 in binary vector
                lbp_values(i) = lbp_values(i) + binomial_weights(j);

            end
        end
        histogram_values(lbp_values(i)+1) = histogram_values(lbp_values(i)+1) + 1;
    end
    %  number of omitted elements are added to zero occurences
    histogram_values(1) = histogram_values(1) + P;
end

