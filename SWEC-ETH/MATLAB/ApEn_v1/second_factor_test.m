% x = (1:50);
% sf=4;
% fun = @(i) x((i-1)*sf+1: i*sf);
% fun(1)
% fun(2)
% fun(3)

y=(1:1843200);
fs=512;
sf=1;
fun2 = @(i) y(i: i+fs/sf-1);
%fun2(1)
fun2(1+fs/sf)
%fun2(1+fs/sf+fs/sf)
