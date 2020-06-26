clc;clear;
%controller=0; % means we will look [r g b] difference
controller=1; % means we will look [x y r g b] difference
N=5; %number of segment
%my_matrix=imread('gazete.bmp');
%my_matrix=imread('PCB.BMP');
my_matrix=imread('12003.jpg');
%my_matrix=rgb2gray(my_matrix);
my_matrix=double(my_matrix);
[m,n,~]=size(my_matrix);
%% initializing

x_cordinate=randi([1 m],1,N);
y_cordinate=randi([1 n],1,N);
Coordinates=[x_cordinate' y_cordinate'];
my_mean_1=zeros(N,3);
for i=1:N
    for j=1:3
        my_mean_1(i,j)=my_matrix(x_cordinate(i),y_cordinate(i),j);
    end
end
M=[Coordinates my_mean_1];
classified_pixels{N}=[];
%%
temp=zeros(1,N);
my_mean_2=zeros(N,3);

while abs(sum(sum((my_mean_1-my_mean_2))))>N
    abs(sum(sum((my_mean_1-my_mean_2))))
    my_mean_2=my_mean_1;

    classified_pixels{N}=[];
   
    for i=1:m  
        for j=1:n
            
            for k=1:N
                renkler(1)=my_matrix(i,j,1);
                renkler(2)=my_matrix(i,j,2);
                renkler(3)=my_matrix(i,j,3);
                if controller==0 % [r g b]
                    temp(k)=norm(renkler-M(k,3:5));
                else % [x y r g b]
                    temp(k)=norm([i j renkler]-M(k,1:5));
                end
                
                
            end
            
            [~,indice]=min(temp);
            classified_pixels{indice}=[classified_pixels{indice};i j my_matrix(i,j,1) my_matrix(i,j,2) my_matrix(i,j,3)];              
        end 
    end   
    for i=1:N     
        M(i,1)=mean(classified_pixels{i}(:,1));
        M(i,2)=mean(classified_pixels{i}(:,2));
        my_mean_1(i,1)=mean(classified_pixels{i}(:,3));
        my_mean_1(i,2)=mean(classified_pixels{i}(:,4));
        my_mean_1(i,3)=mean(classified_pixels{i}(:,5));
    end  
    M(i,3:5)=my_mean_1(i,:);
end
%% save classified_pixels

%save classified_pixels.mat classified_pixels



%% segment
result_matrix=zeros(m,n,3);
result_matrix_2=zeros(m,n,3);

for i=1:N
    temp_1=classified_pixels{i};
    for ii=1:length(temp_1(:,1))
        result_matrix(temp_1(ii,1),temp_1(ii,2),:)=my_mean_1(i,:);    
        result_matrix_2(temp_1(ii,1),temp_1(ii,2),:)=[i i i];
    end
end
figure();
imshow(uint8(result_matrix),[])
figure();
max_value=max(max(max(result_matrix_2)));
imshow(uint8(255*result_matrix_2/max_value))




% %% Hisgogram
% figure();
% subplot(2,3,1);imhist(my_matrix(:,:,1));title('R');
% subplot(2,3,2);imhist(my_matrix(:,:,2));title('G');
% subplot(2,3,3);imhist(my_matrix(:,:,3));title('B');
% 
% subplot(2,3,4);imhist(uint8(result_matrix(:,:,1)));title('R');
% subplot(2,3,5);imhist(uint8(result_matrix(:,:,2)));title('G');
% subplot(2,3,6);imhist(uint8(result_matrix(:,:,3)));title('B');



