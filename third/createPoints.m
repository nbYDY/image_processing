function [xset,yset] = createPoints(point_size, outlier_size)
%生成高斯分布点
x = normrnd(0,0.1,1,point_size);
y = x;
%生成outlier
outlierX = min(x)+rand(1,outlier_size)*(max(x)-min(x));  %生成x定义域内的outlier
x = [x, outlierX];
outlierY = min(y)+rand(1,outlier_size)*(max(y)-min(y));  %生成y值域内的outlier
y = [y, outlierY];
xset = x;
yset = y;
end

