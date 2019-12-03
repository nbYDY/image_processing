function [] =  middleFilter()
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
%imwrite(add_edge,"add_edge.jpg");
%imshow(add_edge);
[h,w] = size(add_edge);
%3 * 3的滤波器
m = 3;
n = 3;
res = add_edge;
for i=1:h-m+1
    for j=1:w-n+1
        sub = add_edge(i:i+m-1,j:j+n-1); %3 * 3子图
        sub = sub(:);  %转为向量
        s_max = max(sub); % 获得中值
        s_min = min(sub);
        res(i+(m-1)/2,j+(n-1)/2) = (s_max + s_min) / 2;   %设置中间像素点
    end
end
res = res(2:h-1,2:w-1);   %忽略之前增加的边界

gray = imread('gray.jpg');
subplot(1,3,1);
imshow(gray),title('原图像'); 

subplot(1,3,2);
imshow(img),title('高斯噪声图像');

subplot(1,3,3);
imshow(res),title('中点滤波后图像');

%imwrite(res,"salt&pepper_middle.jpg");
end
