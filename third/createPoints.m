function [xset,yset] = createPoints(point_size, outlier_size)
%���ɸ�˹�ֲ���
x = normrnd(0,0.1,1,point_size);
y = x;
%����outlier
outlierX = min(x)+rand(1,outlier_size)*(max(x)-min(x));  %����x�������ڵ�outlier
x = [x, outlierX];
outlierY = min(y)+rand(1,outlier_size)*(max(y)-min(y));  %����yֵ���ڵ�outlier
y = [y, outlierY];
xset = x;
yset = y;
end

