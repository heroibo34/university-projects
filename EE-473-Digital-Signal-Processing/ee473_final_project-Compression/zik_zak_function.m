function matrix = zik_zak_function(block_size)

block_size=8;
matrix_upper=[];
for i=2:block_size+1
    for j=1:i-1
        if mod(i,2)==1
            matrix_upper=[matrix_upper;j i-j];
        else
            matrix_upper=[matrix_upper;i-j j];
        end
    end
    
end


lower_part=(block_size+1)-matrix_upper(1:end-block_size,:);
lower_triangle=lower_part(end:-1:1,:);
matrix=[matrix_upper;lower_triangle];

end

