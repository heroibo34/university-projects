function dist = chi_square_hist_distance(matrix_1,matrix_2)

hist1=imhist(matrix_1);
hist1(1)=0;
hist1(256)=0;
hist1=hist1./sum(hist1);

hist2=imhist(matrix_2);
hist2(1)=0;
hist2(256)=0;
hist2=hist2./sum(hist2);

dist=0;

for i=1:1:256
    temp1=(hist1(i)-hist2(i))^2;
    temp2=hist1(i)+hist2(i);
    if temp2~=0
        dist=dist+(temp1/temp2); 
    end
end

dist=sqrt(dist/2);

end

