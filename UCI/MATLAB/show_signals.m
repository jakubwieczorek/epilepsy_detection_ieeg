[x, y] = parse_csv('../dataset/data/data.csv');

subplot(5,1,1) % 4
plot(x(1,:))
ylabel('\muV')

subplot(5,1,2) % 1
plot(x(2,:))
ylabel('\muV')

subplot(5,1,3) % 5
plot(x(3,:))
ylabel('\muV')

subplot(5,1,4) % 2
plot(x(8,:))
ylabel('\muV')

subplot(5,1,5) % 3
plot(x(13,:))
ylabel('\muV')
xlabel('T_s')