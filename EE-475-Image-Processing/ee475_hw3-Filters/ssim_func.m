function ssim_value = ssim_func(matrix_noised,med_result_matrix)

[a,b]=size(matrix_noised);

mean_noised=sum(sum(matrix_noised))/(a*b);
var_noised=var(matrix_noised(:));

mean_med_result=sum(sum(med_result_matrix))/(a*b);
var_median=var(med_result_matrix(:));

cov_noised_median=covariance_funct(matrix_noised,mean_noised,med_result_matrix,mean_med_result);

c_1=(0.01*255)^2;
c_2=(0.03*255)^2;


ssim_value=(2*mean_noised*mean_med_result+c_1)*(2*cov_noised_median+c_2);
ssim_value=ssim_value/((mean_noised^2+mean_med_result^2+c_1)*(var_noised+var_median+c_2));



end

