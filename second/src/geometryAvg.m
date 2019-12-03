function [] = geometryAvg()
img = imread('salt&pepper.jpg');
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
%imshow(add_edge)
[h,w] = size(add_edge);
%3 * 3的滤波器
m = 3;
n = 3;
res = add_edge;
for i=1:h-m+1
    for j=1:w-n+1
        sub = add_edge(i:i+m-1,j:j+n-1);
        s = prod(sub(:)); % 获得乘积
        res(i+(m-1)/2,j+(n-1)/2) = s^(1/(m*n));
    end
end
res = res(2:h-1,2:w-1);
%imshow(res);
%imwrite(res,"gaussian_geometry_avg.jpg");
gray = imread('gray.jpg');
subplot(1,3,1);
imshow(gray),title('原图像'); 

subplot(1,3,2);
imshow(img),title('椒盐噪声图像');

subplot(1,3,3);
imshow(res),title('几何均值滤波后图像');

end

