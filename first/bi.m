function [new_image] = bi(origin,factor)
    img = imread(origin);
    
    %得到原图像的高宽和通道数
    [height, width, channel] = size(img);
    
    %设置新的长宽为之前的factor倍
    new_height = round(height * factor);
    new_width = round(width * factor);
    
    new_image = zeros(new_height, new_width,channel);
    scale_matrix = [factor, 0 ,0 ; 0 ,factor, 0; 0, 0, 1];
    
    for i = 1 : new_height
        for j = 1 : new_width
            %获得原图的坐标点
            old_pixel = [i,j,1]/scale_matrix;
            
            du = old_pixel(2) - floor(old_pixel(2));
            dv = old_pixel(1) - floor(old_pixel(1));
            %处理边界条件
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
            
            %上下左右四个点
            left_up=[floor(old_pixel(1)),floor(old_pixel(2))];
            left_down=[ceil(old_pixel(1)),floor(old_pixel(2))];
            right_up=[floor(old_pixel(1)),ceil(old_pixel(2))];
            right_down=[ceil(old_pixel(1)),ceil(old_pixel(2))];
            
            %两次插值计算新图像中的每个Pixel
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