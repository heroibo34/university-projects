function answer = covariance_funct(matrix_noised,mean_noised,med_result_matrix,mean_med_result)

[a,b]=size(matrix_noised);
answer=0;
for i=1:a
    for ii=1:b      
        answer=(matrix_noised(i,ii)-mean_noised)*(med_result_matrix(i,ii)-mean_med_result)/(a*b); 
    end
end


end

