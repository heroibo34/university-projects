function res = idct_for_rgb(image,block_size,quantizer_matrix)




res=zeros(block_size,block_size,3);
res(:,:,1)=idct2(image(:,:,1).*quantizer_matrix);
res(:,:,2)=idct2(image(:,:,2).*quantizer_matrix);
res(:,:,3)=idct2(image(:,:,3).*quantizer_matrix);


end

