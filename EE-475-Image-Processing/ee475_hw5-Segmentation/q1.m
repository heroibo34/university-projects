clc;clear;
N=90; %number of segment
%my_matrix=imread('gazete.bmp');
my_matrix=imread('PCB.BMP');
%my_matrix=imread('12003.jpg');
%my_matrix=rgb2gray(my_matrix);
my_matrix=double(my_matrix);
[m,n]=size(my_matrix);
%% initializing
%controller=0; % means we will look [gray] difference
controller=1; % means we will look [x y gray] difference

x_cordinate=randi([1 m],1,N);
y_cordinate=randi([1 n],1,N);
Coordinates=[x_cordinate' y_cordinate'];
my_mean_1=zeros(1,N);
for i=1:N
    my_mean_1(i)=my_matrix(x_cordinate(i),y_cordinate(i));
end
M=[Coordinates my_mean_1']; % mean points and its values
classified_pixels{N}=[];
%%
temp=zeros(1,N);
my_mean_2=zeros(1,N);

while norm(my_mean_1-my_mean_2)>3
    norm(my_mean_1-my_mean_2)
    my_mean_2=my_mean_1;

    classified_pixels{N}=[];
    
    for i=1:m  
        for j=1:n
            
            for k=1:N
                if controller==0 % only gray
                    temp(k)=norm(my_matrix(i,j)-M(k,3));
                else % [x y gray]
                    temp(k)=norm([i j my_matrix(i,j)]-M(k,:));
                end
                
                
            end
            
            [~,indice]=min(temp);
            classified_pixels{indice}=[classified_pixels{indice};i j my_matrix(i,j)];              
        end 
    end   
    for i=1:N     
        M(i,1)=mean(classified_pixels{i}(:,1));
        M(i,2)=mean(classified_pixels{i}(:,2));
        my_mean_1(i)=mean(classified_pixels{i}(:,3));
        M(i,3)=my_mean_1(i);
    end   
end
%% segmented kismi bastirma

%%
result_matrix=zeros(m,n);
result_matrix_2=zeros(m,n);

for i=1:N
    temp_1=classified_pixels{i};
    for ii=1:length(temp_1)
        result_matrix(temp_1(ii,1),temp_1(ii,2))=my_mean_1(i);  
        result_matrix_2(temp_1(ii,1),temp_1(ii,2))=i; 
    end
end
%figure();
imshow(uint8(result_matrix))
figure();
imshow(uint8(result_matrix_2),[])
% for i=1:length(segmented(:,1))
%     segmented_matrix(segmented(i,1),segmented(i,2))=segmented(i,3);
% end

% classified_pixels={[],[],[],[],[],[],[]};

