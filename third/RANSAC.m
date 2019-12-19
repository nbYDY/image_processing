function [] = RANSAC()
%���ɸ�˹�ֲ���
point_size = 200;  %���ɵ�ĸ���
outlier_size = 10;
[x,y] = createPoints(point_size, outlier_size);
scatter(x,y); hold on;

data = [x' y']';
number = point_size + outlier_size;   %���е�ĸ���

%RANSAC
sigma = 1;   %��ֵ
pretotal=0;     %�������ģ�͵����ݵĸ���
n = 100;    %��������

for i=1:n   
    % ���ѡ��������
    idx = randperm(number,2);
    sample = data(:,idx);
    
    %���������
    x = sample(1,:);
    y = sample(2,:);

    k = (y(1)-y(2))/(x(1)-x(2));      %����ֱ��б��
    b = y(1) - k*x(1);  %����ֱ�ߵĽؾ�
    line = [k -1 b];

    mask = abs(line*[data; ones(1,size(data,2))]);    %ÿ�����ݵ����ֱ�ߵľ���
    total = sum(mask < sigma);              %�������ݾ���ֱ��С��һ����ֵsigma�����ݵĸ���

    if total > pretotal            %�ҵ��������ֱ�������������ֱ��
        pretotal = total;
        bestline = line;          %�ҵ���õ����ֱ��
    end
end
%��ʾ���������ϵ�����
mask=abs(bestline*[data; ones(1,size(data,2))])<sigma;    
k=1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = data(1,i);
        k=k+1;
    end
end

%%% �������ƥ������
bestA = -bestline(1)/bestline(2);
bestB = -bestline(3)/bestline(2);
xAxis = min(inliers(1,:)):0.01:max(inliers(1,:)); 
yAxis = bestA*xAxis + bestB;
plot(xAxis,yAxis,'r');

title(['RANSAC��ϳ���ֱ��Ϊ: y = ',num2str(bestA),'x + ',num2str(bestB)]);
end

