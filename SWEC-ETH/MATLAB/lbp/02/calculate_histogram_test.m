%window = sin(-3.14:0.01:3.14);
window = rand(1,512);

lbp_length = 6;
[histogram_values, lbp_values]=calculate_histogram(window, lbp_length);

figure(1)
bar(histogram_values', 'hist')
xlabel('LBP value')
ylabel('Number of occurrences')
xlim([0 2^lbp_length + 1])
colorbar

figure(2)
histogram(lbp_values)
