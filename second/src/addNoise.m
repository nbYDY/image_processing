function [] =  addNoise(img_name)
img = imread(img_name);
img = im2double(img);
img = rgb2gray(img);
subplot(1,3,1);
imshow(img),title('Ô­Í¼Ïñ'); 
%imwrite(img, 'gray.jpg');
%Ìí¼Ó½·ÑÎÔëÉù 
noise_picture = double(imnoise(img,'salt & pepper',0.02));
subplot(1,3,2);
imshow(noise_picture),title('½·ÑÎÔëÉùÍ¼Ïñ'); 
%imshow(noise_picture)
%imwrite(noise_picture,'salt&pepper.jpg');
%Ìí¼Ó¸ßË¹ÔëÉù
noise_picture = double(imnoise(img,'gaussian',0,0.02));

subplot(1,3,3);
imshow(noise_picture),title('¸ßË¹ÔëÉùÍ¼Ïñ');
%imshow(noise_picture)
%imwrite(noise_picture,'gaussian.jpg');