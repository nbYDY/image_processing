function[xset,yset] = getEdgePoint(iname)
img = imread(iname);
f = rgb2gray(img);
[m,n] = size(gray);
T = 20;  %��ֵ
index = 1;
f_r=zeros(m,n);
xset = zeros(m*n);
yset = zeros(m*n);
%Roberts����һ�׵������Ե��
for i=2:m-1
    for j=2:n-1
        f_r(i,j)=abs(f(i+1,j+1)-f(i,j))+abs(f(i,j+1)-f(i+1,j));
        if f_r(i,j)<T
            f_r(i,j)=0;
        else
            f_r(i,j)=255;
            xset(index)=i;
            yset(index)=j;
            index = index + 1;
        end
    end
end
end