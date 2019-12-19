function [] = leastSquareMethod()
%生成高斯分布点
point_size = 200;  %生成点的个数
outlier_size = 20;
[x,y] = createPoints(point_size, outlier_size);
scatter(x,y); hold on;
point_size = point_size + outlier_size;
%最小二乘法系数
x2=sum(x.^2);       % 求Σ(xi^2)
x1=sum(x);          % 求Σ(xi)
x1y1=sum(x.*y);     % 求Σ(xi*yi)
y1=sum(y);          % 求Σ(yi)

a=(point_size * x1y1 - x1*y1)/(point_size*x2 - x1*x1);      %解出直线斜率b=(y1-a*x1)/n
b=(y1 - a*x1)/ point_size;                      %解出直线截距

new_y = a*x+b;
plot(x,new_y,'r');
title(['最小二乘法拟合出的直线为: y = ',num2str(a),'x + ',num2str(b)]);
end

