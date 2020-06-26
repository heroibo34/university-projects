%%
%question-2
matrix=imread('lumbercamp.jpg');
matrix_equalized=hist_equalization(matrix);
imwrite(matrix_equalized,'lumbercamp_equalized.jpg')
J=histeq(matrix);
imwrite(J,'lumbercamp_histeq.jpg')

J=adapthisteq(matrix);
imwrite(J,'lumbercamp_adapthisteq.jpg')

matrix_moon=imread('moon.png');
matrix_moon_equalized=hist_equalization(matrix_moon);
imwrite(uint8(matrix_moon_equalized),'moon_equalized.png')

J=histeq(matrix_moon);
imwrite(J,'moon_histeq.png')

J=adapthisteq(matrix_moon);
imwrite(J,'moon_adapthisteq.jpg')



%%
%question-3

matrix_1=rgb2gray(imread('subject1_photo2.jpg'));
matrix_2=rgb2gray(imread('subject1_photo1.jpg'));
matrix_3=rgb2gray(imread('subject1_photo3.jpg'));
matrix_4=rgb2gray(imread('subject2_photo1.jpg'));

figure();
matrix_match_1=histogram_match(matrix_1,matrix_1); %map image2 to image1
figure();
matrix_match_2=histogram_match(matrix_1,matrix_2); %map image2 to image1
figure();
matrix_match_3=histogram_match(matrix_1,matrix_3); %map image3 to image1
figure();
matrix_match_4=histogram_match(matrix_1,matrix_4); %map image4 to image1


matrix_eq_1=hist_equalization(matrix_1);
matrix_eq_2=hist_equalization(matrix_2);
matrix_eq_3=hist_equalization(matrix_3);
matrix_eq_4=hist_equalization(matrix_4);


%%
%distance before equalization for chi square
dist_1=zeros(4,4); %for normal image

dist_1(1,1)=chi_square_hist_distance(matrix_1,matrix_1);
dist_1(1,2)=chi_square_hist_distance(matrix_1,matrix_2);
dist_1(1,3)=chi_square_hist_distance(matrix_1,matrix_3);
dist_1(1,4)=chi_square_hist_distance(matrix_1,matrix_4);

dist_1(2,1)=chi_square_hist_distance(matrix_2,matrix_1);
dist_1(2,2)=chi_square_hist_distance(matrix_2,matrix_2);
dist_1(2,3)=chi_square_hist_distance(matrix_2,matrix_3);
dist_1(2,4)=chi_square_hist_distance(matrix_2,matrix_4);

dist_1(3,1)=chi_square_hist_distance(matrix_3,matrix_1);
dist_1(3,2)=chi_square_hist_distance(matrix_3,matrix_2);
dist_1(3,3)=chi_square_hist_distance(matrix_3,matrix_3);
dist_1(3,4)=chi_square_hist_distance(matrix_3,matrix_4);

dist_1(4,1)=chi_square_hist_distance(matrix_4,matrix_1);
dist_1(4,2)=chi_square_hist_distance(matrix_4,matrix_2);
dist_1(4,3)=chi_square_hist_distance(matrix_4,matrix_3);
dist_1(4,4)=chi_square_hist_distance(matrix_4,matrix_4);

disp(dist_1);

%%

dist_2=zeros(4,4); %for normal image

dist_2(1,1)=chi_square_hist_distance(matrix_eq_1,matrix_eq_1);
dist_2(1,2)=chi_square_hist_distance(matrix_eq_1,matrix_eq_2);
dist_2(1,3)=chi_square_hist_distance(matrix_eq_1,matrix_eq_3);
dist_2(1,4)=chi_square_hist_distance(matrix_eq_1,matrix_eq_4);

dist_2(2,1)=chi_square_hist_distance(matrix_eq_2,matrix_eq_1);
dist_2(2,2)=chi_square_hist_distance(matrix_eq_2,matrix_eq_2);
dist_2(2,3)=chi_square_hist_distance(matrix_eq_2,matrix_eq_3);
dist_2(2,4)=chi_square_hist_distance(matrix_eq_2,matrix_eq_4);

dist_2(3,1)=chi_square_hist_distance(matrix_eq_3,matrix_eq_1);
dist_2(3,2)=chi_square_hist_distance(matrix_eq_3,matrix_eq_2);
dist_2(3,3)=chi_square_hist_distance(matrix_eq_3,matrix_eq_3);
dist_2(3,4)=chi_square_hist_distance(matrix_eq_3,matrix_eq_4);

dist_2(4,1)=chi_square_hist_distance(matrix_eq_4,matrix_eq_1);
dist_2(4,2)=chi_square_hist_distance(matrix_eq_4,matrix_eq_2);
dist_2(4,3)=chi_square_hist_distance(matrix_eq_4,matrix_eq_3);
dist_2(4,4)=chi_square_hist_distance(matrix_eq_4,matrix_eq_4);

disp(dist_2);

%%

dist_3=zeros(4,4); %for normal image

dist_3(1,1)=chi_square_hist_distance(matrix_match_1,matrix_match_1);
dist_3(1,2)=chi_square_hist_distance(matrix_match_1,matrix_match_2);
dist_3(1,3)=chi_square_hist_distance(matrix_match_1,matrix_match_3);
dist_3(1,4)=chi_square_hist_distance(matrix_match_1,matrix_match_4);

dist_3(2,1)=chi_square_hist_distance(matrix_match_2,matrix_match_1);
dist_3(2,2)=chi_square_hist_distance(matrix_match_2,matrix_match_2);
dist_3(2,3)=chi_square_hist_distance(matrix_match_2,matrix_match_3);
dist_3(2,4)=chi_square_hist_distance(matrix_match_2,matrix_match_4);

dist_3(3,1)=chi_square_hist_distance(matrix_match_3,matrix_match_1);
dist_3(3,2)=chi_square_hist_distance(matrix_match_3,matrix_match_2);
dist_3(3,3)=chi_square_hist_distance(matrix_match_3,matrix_match_3);
dist_3(3,4)=chi_square_hist_distance(matrix_match_3,matrix_match_4);

dist_3(4,1)=chi_square_hist_distance(matrix_match_4,matrix_match_1);
dist_3(4,2)=chi_square_hist_distance(matrix_match_4,matrix_match_2);
dist_3(4,3)=chi_square_hist_distance(matrix_match_4,matrix_match_3);
dist_3(4,4)=chi_square_hist_distance(matrix_match_4,matrix_match_4);

disp(dist_3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
%distance before equalization for chi square
dist_4=zeros(4,4); %for normal image

dist_4(1,1)=kullback_leibler_hist_distance(matrix_1,matrix_1);
dist_4(1,2)=kullback_leibler_hist_distance(matrix_1,matrix_2);
dist_4(1,3)=kullback_leibler_hist_distance(matrix_1,matrix_3);
dist_4(1,4)=kullback_leibler_hist_distance(matrix_1,matrix_4);

dist_4(2,1)=kullback_leibler_hist_distance(matrix_2,matrix_1);
dist_4(2,2)=kullback_leibler_hist_distance(matrix_2,matrix_2);
dist_4(2,3)=kullback_leibler_hist_distance(matrix_2,matrix_3);
dist_4(2,4)=kullback_leibler_hist_distance(matrix_2,matrix_4);

dist_4(3,1)=kullback_leibler_hist_distance(matrix_3,matrix_1);
dist_4(3,2)=kullback_leibler_hist_distance(matrix_3,matrix_2);
dist_4(3,3)=kullback_leibler_hist_distance(matrix_3,matrix_3);
dist_4(3,4)=kullback_leibler_hist_distance(matrix_3,matrix_4);

dist_4(4,1)=kullback_leibler_hist_distance(matrix_4,matrix_1);
dist_4(4,2)=kullback_leibler_hist_distance(matrix_4,matrix_2);
dist_4(4,3)=kullback_leibler_hist_distance(matrix_4,matrix_3);
dist_4(4,4)=kullback_leibler_hist_distance(matrix_4,matrix_4);

disp(dist_4);

%%

dist_5=zeros(4,4); %for normal image

dist_5(1,1)=kullback_leibler_hist_distance(matrix_eq_1,matrix_eq_1);
dist_5(1,2)=kullback_leibler_hist_distance(matrix_eq_1,matrix_eq_2);
dist_5(1,3)=kullback_leibler_hist_distance(matrix_eq_1,matrix_eq_3);
dist_5(1,4)=kullback_leibler_hist_distance(matrix_eq_1,matrix_eq_4);

dist_5(2,1)=kullback_leibler_hist_distance(matrix_eq_2,matrix_eq_1);
dist_5(2,2)=kullback_leibler_hist_distance(matrix_eq_2,matrix_eq_2);
dist_5(2,3)=kullback_leibler_hist_distance(matrix_eq_2,matrix_eq_3);
dist_5(2,4)=kullback_leibler_hist_distance(matrix_eq_2,matrix_eq_4);

dist_5(3,1)=kullback_leibler_hist_distance(matrix_eq_3,matrix_eq_1);
dist_5(3,2)=kullback_leibler_hist_distance(matrix_eq_3,matrix_eq_2);
dist_5(3,3)=kullback_leibler_hist_distance(matrix_eq_3,matrix_eq_3);
dist_5(3,4)=kullback_leibler_hist_distance(matrix_eq_3,matrix_eq_4);

dist_5(4,1)=kullback_leibler_hist_distance(matrix_eq_4,matrix_eq_1);
dist_5(4,2)=kullback_leibler_hist_distance(matrix_eq_4,matrix_eq_2);
dist_5(4,3)=kullback_leibler_hist_distance(matrix_eq_4,matrix_eq_3);
dist_5(4,4)=kullback_leibler_hist_distance(matrix_eq_4,matrix_eq_4);

disp(dist_5);

%%

dist_6=zeros(4,4); %for normal image

dist_6(1,1)=kullback_leibler_hist_distance(matrix_match_1,matrix_match_1);
dist_6(1,2)=kullback_leibler_hist_distance(matrix_match_1,matrix_match_2);
dist_6(1,3)=kullback_leibler_hist_distance(matrix_match_1,matrix_match_3);
dist_6(1,4)=kullback_leibler_hist_distance(matrix_match_1,matrix_match_4);

dist_6(2,1)=kullback_leibler_hist_distance(matrix_match_2,matrix_match_1);
dist_6(2,2)=kullback_leibler_hist_distance(matrix_match_2,matrix_match_2);
dist_6(2,3)=kullback_leibler_hist_distance(matrix_match_2,matrix_match_3);
dist_6(2,4)=kullback_leibler_hist_distance(matrix_match_2,matrix_match_4);

dist_6(3,1)=kullback_leibler_hist_distance(matrix_match_3,matrix_match_1);
dist_6(3,2)=kullback_leibler_hist_distance(matrix_match_3,matrix_match_2);
dist_6(3,3)=kullback_leibler_hist_distance(matrix_match_3,matrix_match_3);
dist_6(3,4)=kullback_leibler_hist_distance(matrix_match_3,matrix_match_4);

dist_6(4,1)=kullback_leibler_hist_distance(matrix_match_4,matrix_match_1);
dist_6(4,2)=kullback_leibler_hist_distance(matrix_match_4,matrix_match_2);
dist_6(4,3)=kullback_leibler_hist_distance(matrix_match_4,matrix_match_3);
dist_6(4,4)=kullback_leibler_hist_distance(matrix_match_4,matrix_match_4);

disp(dist_6);



%%


figure();
subplot(2,2,1),imshow(matrix_1);
title('original A');
subplot(2,2,2),imshow(matrix_2);
title('original B');
subplot(2,2,3),imshow(matrix_3);
title('original C');
subplot(2,2,4),imshow(matrix_4);
title('original D');

figure();
subplot(2,2,1),imshow(matrix_eq_1);
title('equalized A');
subplot(2,2,2),imshow(matrix_eq_2);
title('equalized B');
subplot(2,2,3),imshow(matrix_eq_3);
title('equalized C');
subplot(2,2,4),imshow(hist_equalization(matrix_eq_4));
title('equalized D');

%%

figure();
subplot(2,2,1),imshow(matrix_match_1);
title('matched A');
subplot(2,2,2),imshow(matrix_match_2);
title('matched B');
subplot(2,2,3),imshow(matrix_match_3);
title('matched C');
subplot(2,2,4),imshow(matrix_match_4);
title('matched D');

%%
%question-4a

kugu=imread('kugu.jpg');

kugu_r=kugu(:,:,1);
kugu_g=kugu(:,:,2);
kugu_b=kugu(:,:,3);

r_eq=hist_equalization(kugu_r);
g_eq=hist_equalization(kugu_g);
b_eq=hist_equalization(kugu_b);

new_kugu(:,:,1)=r_eq;
new_kugu(:,:,2)=g_eq;
new_kugu(:,:,3)=b_eq;

imwrite(uint8(new_kugu),'kugu_equalized.png')
imshow(uint8(new_kugu));


%%

beach=imread('beach.jpg');

beach_r=beach(:,:,1);
beach_g=beach(:,:,2);
beach_b=beach(:,:,3);

r_eq=hist_equalization(beach_r);
g_eq=hist_equalization(beach_g);
b_eq=hist_equalization(beach_b);

new_beach(:,:,1)=r_eq;
new_beach(:,:,2)=g_eq;
new_beach(:,:,3)=b_eq;

imwrite(new_beach,'beach_equalized.png')
imshow(new_beach);
%%
%question-4b
kugu=imread('kugu.jpg');
kugu_hsv=rgb2hsv(kugu);

kugu_hsv(:,:,3)=double(hist_equalization(uint8(kugu_hsv(:,:,3)*255)))/255;

kugu_rgb_1=hsv2rgb(kugu_hsv);
figure();

imwrite(kugu_rgb_1,'kugu_hsv_v.png')

imshow(kugu_rgb_1);

%%
%question-4b
beach=imread('beach.jpg');
beach_hsv=rgb2hsv(beach);

beach_hsv(:,:,3)=double(hist_equalization(uint8(beach_hsv(:,:,3)*255)))/255;

beach_rgb_1=hsv2rgb(beach_hsv);
figure();
imwrite(beach_rgb_1,'beach_hsv_v.png')
imshow(beach_rgb_1)

%%
%question-4c
kugu=imread('kugu.jpg');
kugu_hsv=rgb2hsv(kugu);

kugu_hsv(:,:,2)=double(hist_equalization(uint8(kugu_hsv(:,:,2)*255)))/255;

kugu_rgb_1=hsv2rgb(kugu_hsv);
figure();
imwrite(kugu_rgb_1,'kugu_hsv_s.png');
imshow(kugu_rgb_1)

%%
%question-4c
beach=imread('beach.jpg');
beach_hsv=rgb2hsv(beach);

beach_hsv(:,:,2)=double(hist_equalization(uint8(beach_hsv(:,:,2)*255)))/255;

beach_rgb_1=hsv2rgb(beach_hsv);
figure();
imwrite(beach_rgb_1,'beach_hsv_s.png')
imshow(beach_rgb_1)

%%


