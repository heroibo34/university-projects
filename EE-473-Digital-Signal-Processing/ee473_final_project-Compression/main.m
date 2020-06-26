clear;close all;clc;

quantizer_matrix=[16 11 10 16 24 40 51 61;
                  12 12 14 19 26 58 60 55;
                  14 13 16 24 40 57 69 56;
                  14 17 22 29 51 87 80 62;
                  18 22 37 56 68 109 103 77;
                  24 35 55 64 81 104 113 92;
                  49 64 78 87 103 121 120 101;
                  72 92 95 98 112 100 103 99];
              
            

%%

% matrix=double(imread('beach.jpg'));
matrix=double(imread('MARBLES.bmp'));

%imshow(uint8(matrix))
[k,l,m]=size(matrix);

%%

block_size=8; % 8x8 blocks

num_of_row_block=double(int16(k/block_size-0.5));
num_of_column_block=double(int16(l/block_size-0.5));

image_cell=cell(num_of_row_block,num_of_column_block);
dct_cell=cell(num_of_row_block,num_of_column_block);
tic;
% blocklar halinde dct alma
for i=1:num_of_row_block   
    for ii=1:num_of_column_block          
        image_cell{i,ii}=matrix((i-1)*block_size+1:i*block_size,(ii-1)*block_size+1:ii*block_size,:);
        dct_cell{i,ii}=dct_for_rgb(image_cell{i,ii},block_size,quantizer_matrix); % quantalama
  
    end
end
toc

% finds zig-zag sequence 
zik_zag_matrix=zik_zak_function(block_size);

%%
[bit_r,bit_g,bit_b]=huffman_encoding(dct_cell,block_size,zik_zag_matrix);

%%
total_num_of_bit=max(size(bit_r))+max(size(bit_g))+max(size(bit_b));
k*l*m/1024
total_num_of_bit/1024/8
(k*l*m*8)/total_num_of_bit



%%
tic;
reversed_image_cell=cell(num_of_row_block,num_of_column_block);
% idct
for i=1:num_of_row_block   
    for ii=1:num_of_column_block          
        image_cell{i,ii}=matrix((i-1)*block_size+1:i*block_size,(ii-1)*block_size+1:ii*block_size,:);
        reversed_image_cell{i,ii}=idct_for_rgb(dct_cell{i,ii},block_size,quantizer_matrix);
  
    end
end
toc
%%
[k_1,l_1]=size(reversed_image_cell);
decoded_image_1=[];
decoded_image_2=[];
decoded_image_3=[];
tic;

% from blocks ----> image
for i=1:k_1
    temp_1=[];
    temp_2=[];
    temp_3=[];
    for ii=1:l_1
        x=block_size;
   
        allah=zeros(block_size,block_size,3);
        rrr=reversed_image_cell{i,ii}(1:x,1:x,1);
        ggg=reversed_image_cell{i,ii}(1:x,1:x,2);
        bbb=reversed_image_cell{i,ii}(1:x,1:x,3);
        temp_1=[temp_1, rrr]; 
        temp_2=[temp_2, ggg]; 
        temp_3=[temp_3, bbb]; 
  
    end  
    decoded_image_1=[decoded_image_1;temp_1];
    decoded_image_2=[decoded_image_2;temp_2];
    decoded_image_3=[decoded_image_3;temp_3];

end
toc
decoded_image=zeros(k_1*block_size,l_1*block_size);
decoded_image(:,:,1)=decoded_image_1;
decoded_image(:,:,2)=decoded_image_2;
decoded_image(:,:,3)=decoded_image_3;

figure, imshow(uint8(decoded_image_1))
%%
figure, imshow(uint8(decoded_image))
figure, imshow(uint8(matrix))
%%
subplot(2,1,1);imshow(uint8(matrix), 'InitialMagnification', 'fit');title('original image');
subplot(2,1,2);imshow(uint8(decoded_image), 'InitialMagnification', 'fit');title('decoded image');



