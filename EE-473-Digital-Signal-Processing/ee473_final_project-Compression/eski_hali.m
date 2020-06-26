function [r_symbol_sequence,g_symbol_sequence,b_symbol_sequence] = huffman_encoding(dct_cell,block_size,zik_zag_matrix)


r_symbol_sequence=[];
g_symbol_sequence=[];
b_symbol_sequence=[];

[k,l]=size(dct_cell);
%k=33;l=40;

for i=1:k
    for ii=1:l
        r_component=dct_cell{i,ii}(:,:,1);
        g_component=dct_cell{i,ii}(:,:,2);
        b_component=dct_cell{i,ii}(:,:,3);
        r_component_copy=r_component;
        g_component_copy=g_component;
        b_component_copy=b_component;
        
     
        for iii=1:(block_size*block_size)
            
            temp_r=r_component(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2));           
            temp_g=g_component(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2));            
            temp_b=b_component(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2));
            
            if sum(sum(r_component_copy))~=0           
                r_symbol_sequence=[r_symbol_sequence,temp_r];
            end
            if sum(sum(g_component_copy))~=0   
                g_symbol_sequence=[g_symbol_sequence,temp_g];
            end
            if sum(sum(b_component_copy))~=0   
                b_symbol_sequence=[b_symbol_sequence,temp_b];
            end
            r_component_copy(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2))=0;
            g_component_copy(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2))=0;
            b_component_copy(zik_zag_matrix(iii,1),zik_zag_matrix(iii,2))=0;

            
        end
        r_symbol_sequence=[r_symbol_sequence,123];
        g_symbol_sequence=[g_symbol_sequence,123];
        b_symbol_sequence=[b_symbol_sequence,123];
        
    end
end




end

