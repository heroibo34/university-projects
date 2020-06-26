h1=[0.04 -0.06 0.07 -0.21 -0.5 0.72 0.36 0.21 0.06];
h2=[0.41 0.815 0.41];
h3=[0.227 0.460 0.688 0.460 0.227];
h_struct={h1,h2,h3};
snr_db=[0 2 4 6 8 10 15 20 30 50 80 100];
tab=[9 15];
for i=1:6    
    if i>3
        tap=tab(2);
    else
        tap=tab(1);
    end
    if i>3
        temp=i-3;
    else
        temp=i;
    end   
    h=h_struct{temp};
    coeff_v{i}=mmse_function(h,tap,snr_db); 
end

%%
num_tap=[9 15];

en=10.^(snr_db/10);
num_of_bit=10^4;
noise=randn(1,num_of_bit);
error_matrix=zeros(length(coeff_v),length(snr_db));

for nEN=1:length(snr_db)    
    for i=1:6 % for 6 different cases
         number_of_loop=300;
         for n=1:number_of_loop
             x=randn(1,num_of_bit); %random sending signal
             x(x>0)=1;
             x(x<1)=-1;
             temp_1=conv(x,h_struct{mod(i-1,3)+1},'same'); 
             rec_sig=temp_1+noise/sqrt(en(nEN)); % received signal
             
             z=sign(conv(rec_sig,coeff_v{i}(nEN,:),'same')); % decoded signal;
             
             number_of_error=0;
             error=length(find(z~=x));
             error_matrix(i,nEN)=error_matrix(i,nEN)+error;
             
         end
      
    end
end
error_rate_matrix=error_matrix./number_of_loop./num_of_bit;
error_rate_matrix_2=error_rate_matrix;
save error_rate_matrix_2.mat error_rate_matrix_2
%%
load error_rate_matrix_2.mat
snr_db=[0 2 4 6 8 10 15 20 30 50 80 100];
last_error_rate_matrix_2=error_rate_matrix_2';
figure();
semilogy(snr_db,last_error_rate_matrix_2(:,1),'-x','DisplayName','9-tab & f1');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,2),'-x','DisplayName','9-tab & f2');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,3),'-x','DisplayName','9-tab & f3');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,4),'-x','DisplayName','15-tab & f1');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,5),'-x','DisplayName','15-tab & f2');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,6),'-x','DisplayName','15-tab & f3');hold on;
grid on;
legend;
xlabel('snr(db)');ylabel('bit error rate');title('Zero Forcing Equalizer')
set(gca,'FontSize',13);









