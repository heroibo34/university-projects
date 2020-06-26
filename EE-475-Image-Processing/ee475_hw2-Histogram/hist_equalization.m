function matrix_equalized = hist_equalization(matrix)

hist_info=imhist(matrix);
hist_info(1)=0;
hist_info(256)=0;
map_func=uint8(255*cumsum(hist_info)/sum(hist_info)+0.5);
matrix_equalized=map_func(matrix(:,:)+1);

end

