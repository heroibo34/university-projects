function median_matrix = median_filter(matrix,dim,salt_pepper)
%%
matrix_noised=imnoise(matrix,'salt & pepper',salt_pepper);
% imshow(uint8(matrix_noised),'InitialMagnification', 'fit');
matrix_noised=double(matrix_noised);
[a,b]=size(matrix);



extended_matrix=zeros(a+12,b+12);
extended_matrix(7:(a+6),7:(b+6))=matrix_noised(1:a,1:b);

extended_matrix(6,:)=extended_matrix(8,:); 
extended_matrix(5,:)=extended_matrix(9,:);
extended_matrix(4,:)=extended_matrix(10,:);
extended_matrix(3,:)=extended_matrix(11,:); 
extended_matrix(2,:)=extended_matrix(12,:);
extended_matrix(1,:)=extended_matrix(13,:);
extended_matrix((a+7),:)=extended_matrix((a+6),:);
extended_matrix((a+8),:)=extended_matrix((a+5),:);
extended_matrix((a+9),:)=extended_matrix((a+4),:);
extended_matrix((a+10),:)=extended_matrix((a+3),:);
extended_matrix((a+11),:)=extended_matrix((a+2),:);
extended_matrix((a+12),:)=extended_matrix((a+1),:);

extended_matrix(:,6)=extended_matrix(:,7);
extended_matrix(:,5)=extended_matrix(:,8);
extended_matrix(:,4)=extended_matrix(:,9);
extended_matrix(:,3)=extended_matrix(:,10);
extended_matrix(:,2)=extended_matrix(:,11);
extended_matrix(:,1)=extended_matrix(:,12);
extended_matrix(:,(a+7))=extended_matrix(:,(a+6));
extended_matrix(:,(a+8))=extended_matrix(:,(a+5));
extended_matrix(:,(a+9))=extended_matrix(:,(a+4));
extended_matrix(:,(a+10))=extended_matrix(:,(a+3));
extended_matrix(:,(a+11))=extended_matrix(:,(a+2));
extended_matrix(:,(a+12))=extended_matrix(:,(a+1));

median_matrix=zeros(a,b);

for i=1:1:a
    for ii=1:1:b
        temp_matrix=extended_matrix((i+6-(dim-1)/2):(i+6+(dim-1)/2),(ii+6-(dim-1)/2):(ii+6+(dim-1)/2)); 
        temp=sort(temp_matrix(:));
        median_matrix(i,ii)=temp((dim*dim+1)/2);
        
     
    end
end
% figure();
% imshow(uint8(median_matrix),'InitialMagnification', 'fit');
end

