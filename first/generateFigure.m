function [img] = generateFigure(imgW, imgH)
img = zeros(imgH,imgW,3);
for i = 1:3
    img(:,:,i)= 255;
end
img(:,1,:)=0;

%记录0-2pi的各个坐标信息
x = 0: 2*pi/imgW: 2*pi; 
red = sin(x);
green = cos(x);
blue = x.^2;

% 把y映射到图片的高
red = (1-red)/2*(imgH / (4 * pi * pi) - 1)+1;
red = imgH - red;
red = round(red);
green = (1-green)/2*(imgH / (4 * pi * pi) - 1)+1;
green = imgH - green;
green = round(green);
maxb = max(blue);
minb = min(blue);
blue = (maxb - blue) / (maxb - minb) * (imgH -1) + 1;
blue = round(blue);
% 把x映射到图片的宽
x = 1 : imgW;
for i = 1: imgW
    %绘制每个像素点的颜色
    img(red(i),x(i),2) = 0;
    img(red(i),x(i),3) = 0;
    img(green(i),x(i),1) = 0;
    img(green(i),x(i),3) = 0;
    img(blue(i),x(i),1) = 0;
    img(blue(i),x(i),2) = 0;
end
imwrite(img,'function.png');
%imshow(img);
end
