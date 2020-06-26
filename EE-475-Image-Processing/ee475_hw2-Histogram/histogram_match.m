function result= histogram_match(matrix_1,matrix_2)

hist_matched = zeros(1,256);

hist1=imhist(matrix_1);
hist1(1)=[];
hist1(255)=[];
cdf1=cumsum(hist1)/sum(hist1);


hist2=imhist(matrix_2);
hist2(1)=[];
hist2(255)=[];
cdf2=cumsum(hist2)/sum(hist2);



for i=1:1:254
    [~, indice]=min(abs(cdf1-cdf2(i)));
    hist_matched(i)= indice;
    
end

hist_matched=[0, hist_matched, 255];
result = uint8(hist_matched(matrix_2+1));
imshow(result);

subplot(2,3,1),imshow(matrix_1);
title('reference image');
subplot(2,3,2),imshow(matrix_2);
title('other image');
subplot(2,3,3),imshow(uint8(result));
title('matched image');
subplot(2,3,4),imhist(matrix_1);
title('histogram of reference image');
subplot(2,3,5),imhist(matrix_2);
title('histogram of other image');
subplot(2,3,6),imhist(uint8(result));
title('histogram of matched image');


end

