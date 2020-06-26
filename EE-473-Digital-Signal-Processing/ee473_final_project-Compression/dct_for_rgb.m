function new_res = dct_for_rgb(image,block_size,quantizer_matrix)
res=zeros(block_size,block_size,3);
res(:,:,1)=dct2(image(:,:,1))./quantizer_matrix;
res(:,:,2)=dct2(image(:,:,2))./quantizer_matrix;
res(:,:,3)=dct2(image(:,:,3))./quantizer_matrix;
res=round(res);
x=8;
new_res=zeros(block_size,block_size);

for i=1:block_size
    for ii=1:block_size
        new_res(1:x,1:x,1)=res(1:x,1:x,1);
        new_res(1:x,1:x,2)=res(1:x,1:x,2);
        new_res(1:x,1:x,3)=res(1:x,1:x,3);
       
    end
end




end

