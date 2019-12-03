function [] =  adaptFilter()
%��ȡ�����˾�ֵΪ0�� ����Ϊ0.02�ĸ�˹����ͼ
img = imread('gaussian.jpg');
img = mat2gray(img);
[height,width] = size(img);
%��һȦ��Ե
add_edge = zeros(height+2, width+2);
add_edge(2:1+height,2:1+width) = img;
%imshow(add_edge(2:1+height,2:1+width));

%���ϱ�Ե
add_edge(1,2:1+width) = img(1,1:width);
%���±�Ե
add_edge(height+2,2:1+width) = img(height,1:width);
%�����Ե
add_edge(1:height+2,1) = add_edge(1:height+2,2);
%���ұ�Ե
add_edge(1:height+2,width+2) = add_edge(1:height+2,width+1);
%imshow(add_edge);
%���ӱ�Ե���ͼ�񳤿�
[h,w] = size(add_edge);
m = 3;
n = 3;
res = add_edge;
for i=1:h-m+1
    for j=1:w-n+1
        sub = add_edge(i:i+m-1,j:j+n-1); %3 * 3��ͼ
        sub = sub(:);  %תΪ����
        s_noise = 0.02;     %��������
        s_local = var(sub); % �����ֵ
        if s_noise > s_local
            s_noise = s_local;     %��noise�ķ�����ھֲ��ķ���ʱ��ǿ�ƽ���ֵ��Ϊ1
        end
        ml = mean(sub);
        g = res(i+(m-1)/2,j+(n-1)/2);  %(x,y)
        res(i+(m-1)/2,j+(n-1)/2) = g - (s_noise/s_local)*(g - ml);   %�����м����ص�
    end
end
res = res(2:h-1,2:w-1);   %����֮ǰ���ӵı߽�
gray = imread('gray.jpg');
subplot(2,2,1);
imshow(gray),title('ԭͼ��'); 

subplot(2,2,2);
imshow(res),title('����Ӧ�ֲ��˲���ͼ��');

algorithmAvg = imread('gaussian_algorithm_avg.jpg');
subplot(2,2,3);
imshow(algorithmAvg),title('������ֵ�˲���ͼ��');

geometryAvg = imread('gaussian_geometry_avg.jpg');
subplot(2,2,4);
imshow(geometryAvg),title('���ξ�ֵ�˲���ͼ��');

%imwrite(res,"gaussian_adapt.jpg");
end
