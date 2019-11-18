function [new_image] = bi(origin,factor)
    img = imread(origin);
    
    %�õ�ԭͼ��ĸ߿��ͨ����
    [height, width, channel] = size(img);
    
    %�����µĳ���Ϊ֮ǰ��factor��
    new_height = round(height * factor);
    new_width = round(width * factor);
    
    new_image = zeros(new_height, new_width,channel);
    scale_matrix = [factor, 0 ,0 ; 0 ,factor, 0; 0, 0, 1];
    
    for i = 1 : new_height
        for j = 1 : new_width
            %���ԭͼ�������
            old_pixel = [i,j,1]/scale_matrix;
            
            du = old_pixel(2) - floor(old_pixel(2));
            dv = old_pixel(1) - floor(old_pixel(1));
            %����߽�����
            if old_pixel(1) < 1
               old_pixel(1) = 1;
            end
            if old_pixel(1) > height
               old_pixel(1) = height;
            end
            
            if old_pixel(2) < 1
               old_pixel(2) = 1;
            end
            if old_pixel(2) > width
               old_pixel(2) = width;
            end
            
            %���������ĸ���
            left_up=[floor(old_pixel(1)),floor(old_pixel(2))];
            left_down=[ceil(old_pixel(1)),floor(old_pixel(2))];
            right_up=[floor(old_pixel(1)),ceil(old_pixel(2))];
            right_down=[ceil(old_pixel(1)),ceil(old_pixel(2))];
            
            %���β�ֵ������ͼ���е�ÿ��Pixel
            new_img(i,j,:) = (1-du)*(1-dv)* img(left_up(1),left_up(2),:) ...
                + du * (1-dv)*img(right_up(1),right_up(2),:) ...
                + (1-du)*dv*img(left_down(1),left_down(2),:) ...
                + du*dv * img(right_down(1),right_down(2),:);
        end
    end
    imwrite(new_img,'result.png');
  
 % imshow(img);
  
 %  imshow(new_img);
 
end