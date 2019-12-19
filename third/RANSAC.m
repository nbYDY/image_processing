function [] = RANSAC()
%生成高斯分布点
point_size = 200;  %生成点的个数
outlier_size = 10;
[x,y] = createPoints(point_size, outlier_size);
scatter(x,y); hold on;

data = [x' y']';
number = point_size + outlier_size;   %所有点的个数

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

title(['RANSAC拟合出的直线为: y = ',num2str(bestA),'x + ',num2str(bestB)]);
end

