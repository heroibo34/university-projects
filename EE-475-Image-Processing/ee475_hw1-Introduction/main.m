%%
%Generating image patterns
clear;clc;

pixel_number=512; % we create size(512,512) matrix
image_matrix = ones(pixel_number)*64;
center_pixel = round(pixel_number/2);

% i created a function name distance_to_center(i,ii,center_pixel) to
% calculate distance.


% generating the outer circle
for i=1:1:pixel_number
    for ii=1:1:pixel_number
        image_matrix(i,ii) = 64 + randi([-16 +16]);
        if distance_to_center(i,ii,center_pixel) <= 128
           image_matrix(i,ii) = 128 + randi([-42 +42]);
        end
        if distance_to_center(i,ii,center_pixel) <= 64 % generating the inner circle
           image_matrix(i,ii) = 192 + randi([-16 +16]);
        end
    end    
end

% saving the image and displaying it
figure(1);
imwrite(uint8(image_matrix),'generating_image.png');
imshow('generating_image.png')


% selection of inner circle, the grayscale values that grater than 175
selection_inner_matrix  = image_matrix > 175;
figure(2);
imwrite(uint8(selection_inner_matrix).*uint8(image_matrix),'selection_inner_circle.png');
imshow('selection_inner_circle.png');


%%
%IMAGE READ & WRITEs; HISTOGRAM PLOTs:


I = imread('peppers.png');

%question-2,part-a
r_I = I(:,:,1);
g_I = I(:,:,2);
b_I = I(:,:,3);

figure(3);
imwrite(r_I,'r_comp.png');
imshow('r_comp.png');
title('R component of the matrix I');

figure(4);
imwrite(g_I,'g_comp.png');
imshow('g_comp.png');
title('G component of the matrix I');

figure(5);
imwrite(b_I,'b_comp.png');
imshow('b_comp.png');
imshow(b_I)
title('B component of the matrix I');

%%
%question-2,part-b
[m, n, ~]=size(I);
image = zeros(m,n);

for i=1:1:m
    for ii=1:1:n
        if r_I(i,ii)>90 && g_I(i,ii)>10 && b_I(i,ii)<40
            image(i,ii)=1;
        end
    end  
end

figure(7);
imwrite(uint8(image.*255),'2_a.png')
imshow('2_a.png')
title('the places that R>90, G>10, B<40');

%%

%question-2,part-c

%new_image_matrix = (r_I+g_I+b_I)./3;
new_image_matrix = (r_I./3+g_I./3+b_I./3);
imwrite(new_image_matrix, 'gray.bmp')
figure(8);
imshow('gray.bmp');
title('(R./3 + G./3 + B./3)'); % i prefer this format because R+G+B may exceeds

%question-2,part-d
%%
figure(9);
new_image_matrix=imread('gray.bmp');
imhist(new_image_matrix)
xlabel('grayscale values,0 to 255'); %burasi duzeltilecek
ylabel('number of repetitions');
xlim([0 260]);
ylim([0 7000]);
% 85 is the definite peak. Because the types ofR,G,B components are unit8,
% sum of R,G,B can be max 255. 255/3=85. Due to majority of the pixels are
% 85, there is a absolute peak. Histogram does not occupy the whole
% gray-level range. the range of histogram is (0,85)



%%
%question-2,part-e
new_image_matrix=imread('gray.bmp');
imwrite(new_image_matrix./2,'2eimage.png')
figure(10);
imshow('2eimage.png');
figure(11);
imhist(new_image_matrix./2);
xlim([0 260]);
ylim([0 14000]);



imwrite(new_image_matrix+64,'2eimage2.png')
figure(12);
imshow('2eimage2.png');
figure(13);
imhist(new_image_matrix+64);
xlim([0 260]);
ylim([0 7000]);
% adding 64 to each grayscale values makes image more white, and shifts its
% histogram 64 pixel right. There is no values that exceeds 255, it is
% because x->x/2+64, and x/2+64<255 when x<255.
%%
%PIXELS VARIETIES
% Q-3 part-a
matrix = imread('Cetus_NGC1052Galaxy.jpg');
[m, n, ~]=size(matrix);
mm=zeros(m,n);

max_1=max(max(matrix(:,:,1)));
max_2=max(max(matrix(:,:,1)));
max_3=max(max(matrix(:,:,1)));


closest_coordinates=[];
% I will use the matrix closest_coordinates to store the coordinates of the
% closest points.

for i=1:1:m
    for ii=1:1:n
        if matrix(i,ii,1)==max_1 && matrix(i,ii,2)==max_2 && matrix(i,ii,3)==max_3
            mm(i, ii)=1;
            closest_coordinates=[closest_coordinates; i, ii];
            
        end
    end
end

imwrite(uint8(mm.*255),'light.png')

imshow('light.png')
% there are 85 coordinates that emits the light most
%%
% Q-3 part-b

office_matrix = imread('Office.png');
office_matrix=rgb2gray(office_matrix);

[m,n,~]=size(office_matrix);

closest_coordinates=[];  %store the coordinates of the closest points.
farthest_coordinates=[]; %store the coordinates of the farthest points.


max_value = max(max(office_matrix)); % finds more white
min_value = min(min(office_matrix)); % finds more black

for i=1:1:m
    for ii=1:1:n
        if office_matrix(i,ii,1)==min_value 
            farthest_coordinates=[farthest_coordinates; i, ii];            
        end
        if office_matrix(i,ii,1)==max_value 
            closest_coordinates=[closest_coordinates; i, ii];
            
        end
    end
end



%%
% Q-3 part-c
%for skull

skull_matrix = imread('SKULL_head24.tif');
[m, n]=size(skull_matrix);

max_pixel=max(max(skull_matrix));
min_pixel=min(min(skull_matrix));
most_transparent_coordinates = []; % to store the coordinates of the more white 
most_densest_coordinates = []; % to store the coordinates of the more black 

for i=1:m
    for ii=1:n
        if skull_matrix(i,ii)==max_pixel
            most_transparent_coordinates=[most_transparent_coordinates; i ii];
        end
        if skull_matrix(i,ii)==min_pixel
            most_densest_coordinates=[most_densest_coordinates; i ii];
        end
    end
end

%%
%for breast

breast_matrix = imread('Breast_density.jpg');
breast_matrix=rgb2gray(breast_matrix);
[k, l]=size(breast_matrix);
max_pixel=max(max(breast_matrix));
min_pixel=20;

most_transparent_coordinates_breast = [];
most_densest_coordinates_breast = [];

for i=1:k
    for ii=1:l
        if breast_matrix(i,ii)==max_pixel
            most_transparent_coordinates_breast=[most_transparent_coordinates_breast; i ii];
        end
        if breast_matrix(i,ii)==min_pixel
            most_densest_coordinates_breast=[most_densest_coordinates_breast; i ii];
        end
    end
end

%%
%3-d
termal_matrix=imread('Thermal_pedestrian_00005.bmp');
[m, n]=size(termal_matrix);

new_matrix=termal_matrix>130;
imshow(uint8(new_matrix)*255)


%%
% Q-3 part-e
first_matrix = imread('taxi36.pgm');
second_matrix = imread('taxi38.pgm');
third_matrix = imread('taxi40.pgm');
[m, n]=size(first_matrix);

diff1_2 = double(second_matrix)-double(first_matrix);
diff1_2=uint8(abs(diff1_2));
imwrite(diff1_2,'diff1_2.png') %finds the difference between 'taxi36.pgm' and 'taxi38.pgm'
diff2_3 = double(third_matrix)-double(second_matrix);
diff2_3 = uint8(abs(diff2_3));
imwrite(diff2_3,'diff2_3.png') % difference between 'taxi38.pgm' and 'taxi40.pgm'
diff1_3 = double(third_matrix)-double(second_matrix);
diff1_3 = uint8(abs(diff1_3));
imwrite(diff1_3,'diff1_3.png') % difference between 'taxi36.pgm' and 'taxi40.pgm'
imshow(diff2_3)
%%
temp1_2=max(max(diff1_2));
temp2_3=max(max(diff2_3));
temp1_3=max(max(diff1_3));

new_matrix_1 = diff1_2 > temp1_2/2; % to binarize
new_matrix_2 = diff2_3 > temp2_3/2;
new_matrix_3 = diff1_3 > temp1_3/2;

figure();
imshow(uint8(new_matrix_1)*255);
figure();
imshow(uint8(new_matrix_2)*255);
figure();
imshow(uint8(new_matrix_3)*255);
%%






