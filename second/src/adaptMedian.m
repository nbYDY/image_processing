function [] =  adaptMedian()

%读取加入了均值为0， 方差为0.02的高斯噪声图
img = imread('gaussian.jpg');
img = mat2gray(img);
[height,width] = size(img);
%加max圈边缘
smax = 3;
add_edge = zeros(height+2 * smax, width+2 * smax);
add_edge(smax+1:smax+height,smax+1:smax+width) = img;    %原图像
%imshow(add_edge(2:1+height,2:1+width));

%加上边缘
add_edge(1:smax,smax+1:smax+width) = img(1:smax,1:width);
%加下边缘
add_edge(height+smax+1:height+2*smax,smax+1:smax+width) = img(height-smax+1:height,1:width);
%加左边缘
add_edge(1:height+2*smax,1:smax) = add_edge(1:height+2*smax,smax+1:2*smax);
%加右边缘
add_edge(1:height+2*smax,width+smax+1:width+2*smax) = add_edge(1:height+2*smax,width+1:width+smax);
%imshow(add_edge);

res = add_edge;
for i=smax+1:height+smax
    for j=smax+1:width+smax
        r=1;              %初始向外扩张1像素，即滤波窗口初始大小为3
        while r <= smax    %当滤波窗口小于等于7时
% A层
            sub=add_edge(i-r:i+r,j-r:j+r);     %取得滤波核大小的子图像
            sub=sub(:);           %转换为一维向量
            Imin=min(sub);         %最小灰度值
            Imax=max(sub);         %最大灰度值
            Imed=median(sub);      %灰度中值
            if Imin<Imed && Imed<Imax       
               break;   %转到B层
            else
                r=r+1;              %扩大窗口尺寸
            end          
        end
        
% B层     
        if Imin < add_edge(i,j) && add_edge(i,j) < Imax         %如果当前这个像素不是噪声，像素值不变
            res(i,j)=add_edge(i,j);
        else                                        %使用邻域中值
            res(i,j)=Imed;
        end
    end
end
res = res(smax+1:smax+height,smax+1:width+smax);   %忽略之前增加的边界
gray = imread('gray.jpg');
subplot(1,3,1);
imshow(gray),title('原图像'); 

subplot(1,3,2);
imshow(img),title('高斯噪声图像');

subplot(1,3,3);
imshow(res),title('自适应中值滤波后图像');

%imwrite(res,"salt&pepper_adapt_median.jpg");
end
