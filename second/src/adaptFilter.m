function [] =  adaptFilter()
%读取加入了均值为0， 方差为0.02的高斯噪声图
img = imread('gaussian.jpg');
img = mat2gray(img);
[height,width] = size(img);
%加一圈边缘
add_edge = zeros(height+2, width+2);
add_edge(2:1+height,2:1+width) = img;
%imshow(add_edge(2:1+height,2:1+width));

%加上边缘
add_edge(1,2:1+width) = img(1,1:width);
%加下边缘
add_edge(height+2,2:1+width) = img(height,1:width);
%加左边缘
add_edge(1:height+2,1) = add_edge(1:height+2,2);
%加右边缘
add_edge(1:height+2,width+2) = add_edge(1:height+2,width+1);
%imshow(add_edge);
%增加边缘后的图像长宽
[h,w] = size(add_edge);
m = 3;
n = 3;
res = add_edge;
for i=1:h-m+1
    for j=1:w-n+1
        sub = add_edge(i:i+m-1,j:j+n-1); %3 * 3子图
        sub = sub(:);  %转为向量
        s_noise = 0.02;     %噪声方差
        s_local = var(sub); % 获得中值
        if s_noise > s_local
            s_noise = s_local;     %当noise的方差大于局部的方差时，强制将比值设为1
        end
        ml = mean(sub);
        g = res(i+(m-1)/2,j+(n-1)/2);  %(x,y)
        res(i+(m-1)/2,j+(n-1)/2) = g - (s_noise/s_local)*(g - ml);   %设置中间像素点
    end
end
res = res(2:h-1,2:w-1);   %忽略之前增加的边界
gray = imread('gray.jpg');
subplot(2,2,1);
imshow(gray),title('原图像'); 

subplot(2,2,2);
imshow(res),title('自适应局部滤波后图像');

algorithmAvg = imread('gaussian_algorithm_avg.jpg');
subplot(2,2,3);
imshow(algorithmAvg),title('算数均值滤波后图像');

geometryAvg = imread('gaussian_geometry_avg.jpg');
subplot(2,2,4);
imshow(geometryAvg),title('几何均值滤波后图像');

%imwrite(res,"gaussian_adapt.jpg");
end
