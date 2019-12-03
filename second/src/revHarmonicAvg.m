function [] = revHarmonicAvg()
img = imread('salt&pepper.jpg');
img = mat2gray(img);
[height,width] = size(img);
%¼ÓÒ»È¦±ßÔµ
add_edge = zeros(height+2, width+2);
add_edge(2:1+height,2:1+width) = img;
%imshow(add_edge(2:1+height,2:1+width));

%¼ÓÉÏ±ßÔµ
add_edge(1,2:1+width) = img(1,1:width);
%¼ÓÏÂ±ßÔµ
add_edge(height+2,2:1+width) = img(height,1:width);
%¼Ó×ó±ßÔµ
add_edge(1:height+2,1) = add_edge(1:height+2,2);
%¼ÓÓÒ±ßÔµ
add_edge(1:height+2,width+2) = add_edge(1:height+2,width+1);
%imwrite(add_edge,"add_edge.jpg");
%imshow(add_edge)
[h,w] = size(add_edge);
%3 * 3µÄÂË²¨Æ÷
m = 3;
n = 3;
Q = 1.5;
res = add_edge;
for i=1:h-m+1
    for j=1:w-n+1
        sub = add_edge(i:i+m-1,j:j+n-1);
        s1 =  sum(sum(sub.^(Q+1))); 
        s2 =  sum(sum(sub.^Q));
        res(i+(m-1)/2,j+(n-1)/2) = s1 / s2;
    end
end
res = res(2:h-1,2:w-1);
%imshow(res);
%imwrite(res,"salt&pepper_rev_harmonic_avg_Q=1.5.jpg");

gray = imread('gray.jpg');
subplot(1,3,1);
imshow(gray),title('Ô­Í¼Ïñ'); 

subplot(1,3,2);
imshow(img),title('½·ÑÎÔëÉùÍ¼Ïñ');

subplot(1,3,3);
imshow(res),title('ÄæĞ³²¨¾ùÖµÂË²¨ºóÍ¼Ïñ£¨Q=-1.5£©');
end

