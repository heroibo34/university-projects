function dist = kullback_leibler_hist_distance(matrix_1,matrix_2)

hist1=imhist(matrix_1);
hist1(1)=1;
hist1(256)=1;
hist1(hist1==0)=1;
    
hist1=hist1./sum(hist1);

hist2=imhist(matrix_2);
hist2(1)=1;
hist2(256)=1;
hist2(hist2==0)=1;
hist2=hist2./sum(hist2);

dist=0;




for i=1:1:256
        
    temp1=hist1(i)-hist2(i);
    temp2=log2(hist1(i))-log2(hist2(i));
    temp=temp1*temp2;
    dist=dist+temp;     

    
end
dist=dist/2;


end

