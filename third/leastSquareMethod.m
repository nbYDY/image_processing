function [] = leastSquareMethod()
%���ɸ�˹�ֲ���
point_size = 200;  %���ɵ�ĸ���
outlier_size = 20;
[x,y] = createPoints(point_size, outlier_size);
scatter(x,y); hold on;
point_size = point_size + outlier_size;
%��С���˷�ϵ��
x2=sum(x.^2);       % ��(xi^2)
x1=sum(x);          % ��(xi)
x1y1=sum(x.*y);     % ��(xi*yi)
y1=sum(y);          % ��(yi)

a=(point_size * x1y1 - x1*y1)/(point_size*x2 - x1*x1);      %���ֱ��б��b=(y1-a*x1)/n
b=(y1 - a*x1)/ point_size;                      %���ֱ�߽ؾ�

new_y = a*x+b;
plot(x,new_y,'r');
title(['��С���˷���ϳ���ֱ��Ϊ: y = ',num2str(a),'x + ',num2str(b)]);
end

