function [] =  adaptMedian()

%��ȡ�����˾�ֵΪ0�� ����Ϊ0.02�ĸ�˹����ͼ
img = imread('gaussian.jpg');
img = mat2gray(img);
[height,width] = size(img);
%��maxȦ��Ե
smax = 3;
add_edge = zeros(height+2 * smax, width+2 * smax);
add_edge(smax+1:smax+height,smax+1:smax+width) = img;    %ԭͼ��
%imshow(add_edge(2:1+height,2:1+width));

%���ϱ�Ե
add_edge(1:smax,smax+1:smax+width) = img(1:smax,1:width);
%���±�Ե
add_edge(height+smax+1:height+2*smax,smax+1:smax+width) = img(height-smax+1:height,1:width);
%�����Ե
add_edge(1:height+2*smax,1:smax) = add_edge(1:height+2*smax,smax+1:2*smax);
%���ұ�Ե
add_edge(1:height+2*smax,width+smax+1:width+2*smax) = add_edge(1:height+2*smax,width+1:width+smax);
%imshow(add_edge);

res = add_edge;
for i=smax+1:height+smax
    for j=smax+1:width+smax
        r=1;              %��ʼ��������1���أ����˲����ڳ�ʼ��СΪ3
        while r <= smax    %���˲�����С�ڵ���7ʱ
% A��
            sub=add_edge(i-r:i+r,j-r:j+r);     %ȡ���˲��˴�С����ͼ��
            sub=sub(:);           %ת��Ϊһά����
            Imin=min(sub);         %��С�Ҷ�ֵ
            Imax=max(sub);         %���Ҷ�ֵ
            Imed=median(sub);      %�Ҷ���ֵ
            if Imin<Imed && Imed<Imax       
               break;   %ת��B��
            else
                r=r+1;              %���󴰿ڳߴ�
            end          
        end
        
% B��     
        if Imin < add_edge(i,j) && add_edge(i,j) < Imax         %�����ǰ������ز�������������ֵ����
            res(i,j)=add_edge(i,j);
        else                                        %ʹ��������ֵ
            res(i,j)=Imed;
        end
    end
end
res = res(smax+1:smax+height,smax+1:width+smax);   %����֮ǰ���ӵı߽�
gray = imread('gray.jpg');
subplot(1,3,1);
imshow(gray),title('ԭͼ��'); 

subplot(1,3,2);
imshow(img),title('��˹����ͼ��');

subplot(1,3,3);
imshow(res),title('����Ӧ��ֵ�˲���ͼ��');

%imwrite(res,"salt&pepper_adapt_median.jpg");
end
