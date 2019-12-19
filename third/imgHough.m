function[] = imgHough()
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
point_size = size(x,2);
data = [x;y];

%霍夫变换过程

n_max=100;%霍夫空间的纵轴最大值  
h=zeros(315,2*n_max);  
theta_i=1; 
sigma=70;%拟合阈值 
for theta = 0:0.1:pi
    p=[-sin(theta),cos(theta)];  
    d=p*data;  
    for i=1:point_size  
        %对霍夫空间中的d值进行缩放  
        h(theta_i,round(d(i)/10+n_max))=h(theta_i,round(d(i)/10+n_max))+1;  
    end  
    theta_i=theta_i+1;  
end
[theta_x,p]=find(h>sigma);%查找投票数大于sigma的位置
line_size=size(theta_x);%符合直线条数
r=(p-n_max)*10;%还原距离R 
x_line = min(data(:)):0.01:max(data(:)); 
for i=1:40:line_size  
    %斜率不存在的情况
    if(abs(cos(theta_x(i)))<0.01)  
        x=r(i);y=-1:1;  
        plot(x,y,'r');  
    else  %斜率存在的情况
        y=tan(theta_x(i))*x_line+r(i)/cos(theta_x(i));
        plot(x_line,y,'r');  
    end  
end  
end