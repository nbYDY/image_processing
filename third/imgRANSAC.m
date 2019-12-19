function [] = imgRANSAC()
f=imread('test.jpg');
T=20;%阈值
[m,n]=size(f);
T = 1;  %阈值
index = 1;
%Roberts算子一阶导数求边缘点
f_r=zeros(m,n);
for i=2:m-1
    for j=2:n-1
        f_r(i,j)=abs(f(i+1,j+1)-f(i,j))+abs(f(i,j+1)-f(i+1,j));
        if f_r(i,j)<T
            f_r(i,j)=0;
        else
            f_r(i,j)=255;   
            x(index)=i;
            y(index)=j;
            index = index + 1;
        end
    end
end

imshow('test.jpg');hold on;



data = [x' y']';
number = size(x,2);  %所有点的个数

%RANSAC
sigma = 1;   %阈值
pretotal=0;     %符合拟合模型的数据的个数
n = 100;    %迭代次数

for i=1:n   
    % 随机选择两个点
    idx = randperm(number,2);
    sample = data(:,idx);
    
    %两组采样点
    x = sample(1,:);
    y = sample(2,:);

    k = (y(1)-y(2))/(x(1)-x(2));      %计算直线斜率
    b = y(1) - k*x(1);  %计算直线的截距
    line = [k -1 b];

    mask = abs(line*[data; ones(1,size(data,2))]);    %每个数据到拟合直线的距离
    total = sum(mask < sigma);              %计算数据距离直线小于一定阈值sigma的数据的个数

    if total > pretotal            %找到符合拟合直线数据最多的拟合直线
        pretotal = total;
        bestline = line;          %找到最好的拟合直线
    end
end
%显示符合最佳拟合的数据
mask=abs(bestline*[data; ones(1,size(data,2))])<sigma;    
k=1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = data(1,i);
        k=k+1;
    end
end

%%% 绘制最佳匹配曲线
bestA = -bestline(1)/bestline(2);
bestB = -bestline(3)/bestline(2);
xAxis = min(inliers(1,:)):0.01:max(inliers(1,:)); 
yAxis = bestA*xAxis + bestB;
plot(xAxis,yAxis,'r');

end