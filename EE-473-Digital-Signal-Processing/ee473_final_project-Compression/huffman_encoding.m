function [r_bit_sequence,g_bit_sequence,b_bit_sequence] = huffman_encoding(dct_cell,block_size,zik_zag_matrix)


r_symbol_sequence=[];
g_symbol_sequence=[];
b_symbol_sequence=[];

r_bit_sequence=[];
g_bit_sequence=[];
b_bit_sequence=[];


[k,l]=size(dct_cell);
%k=33;l=40;

for i=1:k
    for ii=1:l
        r_component=dct_cell{i,ii}(:,:,1);
        g_component=dct_cell{i,ii}(:,:,2);
        b_component=dct_cell{i,ii}(:,:,3);

        r_for_huffman=[];
        g_for_huffman=[];
        b_for_huffman=[];
     
        for iii=1:(block_size*block_size)
            
            temp_r=r_component(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2));           
            temp_g=g_component(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2));            
            temp_b=b_component(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2));
            
            r_for_huffman=[r_for_huffman,temp_r];
            g_for_huffman=[g_for_huffman,temp_g];
            b_for_huffman=[b_for_huffman,temp_b];
         
         
            r_symbol_sequence=[r_symbol_sequence,temp_r];
            g_symbol_sequence=[g_symbol_sequence,temp_g];
            b_symbol_sequence=[b_symbol_sequence,temp_b];

            
        end
        
        r_bit_sequence=[r_bit_sequence,huffman_ac(r_for_huffman)];
        g_bit_sequence=[g_bit_sequence,huffman_ac(g_for_huffman)];
        b_bit_sequence=[b_bit_sequence,huffman_ac(b_for_huffman)];
        
        
    end
end




end

