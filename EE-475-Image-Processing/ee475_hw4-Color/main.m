matrix=zeros(512,512,3);
k=128;
a=32;
shift=a+k;
temp=255*ones(k,k,1);


imshow(matrix)

matrix(a:a+k-1,a:a+k-1,1)=temp;


matrix(a+shift:a+k-1+shift,a:a+k-1,1)=temp;
matrix(a+shift:a+k-1+shift,a:a+k-1,3)=temp;
imshow(matrix)


matrix(a:a+k-1,a+shift:a+k-1+shift,2)=temp;


matrix(a:a+k-1,a+2*shift:a+k-1+2*shift,3)=temp;



matrix(a+shift:a+k-1+shift,a+2*shift:a+k-1+2*shift,1)=temp;
matrix(a+shift:a+k-1+shift,a+2*shift:a+k-1+2*shift,2)=temp;


matrix(a+2*shift:a+k-1+2*shift,a+1*shift:a+k-1+1*shift,1)=temp;
matrix(a+2*shift:a+k-1+2*shift,a+1*shift:a+k-1+1*shift,2)=temp;
matrix(a+2*shift:a+k-1+2*shift,a+1*shift:a+k-1+1*shift,3)=temp;







matrix(a+shift:a+k-1+shift,a+shift:a+k-1+shift,2)=temp;
matrix(a+shift:a+k-1+shift,a+shift:a+k-1+shift,3)=temp;
imshow(matrix)
imwrite(matrix,'xxx_image1.png')
%%
matrix_hsv=uint8(rgb2hsv(matrix).*255);

hue=matrix_hsv(:,:,1);
saturation=matrix_hsv(:,:,2);
matrix_double=double(matrix);
intensity=matrix_double(:,:,1)+matrix_double(:,:,2)+matrix_double(:,:,3);
intensity=intensity/3;
figure();
%imshow(hue)
imshow(saturation)
%imshow(intensity,[])








