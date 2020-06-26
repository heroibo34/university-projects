load error_rate_matrix_1.mat
load error_rate_matrix_2.mat
snr_db=[0 2 4 6 8 10 15 20 30 50 80 100];
last_error_rate_matrix_1=error_rate_matrix_1';
last_error_rate_matrix_2=error_rate_matrix_2';
figure();

semilogy(snr_db,last_error_rate_matrix_1(:,1),'-xr','DisplayName','9-tab & ZFE');hold on;
semilogy(snr_db,last_error_rate_matrix_1(:,4),'-or','DisplayName','15-tab & ZFE');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,1),'-xb','DisplayName','9-tab & MMSE');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,4),'-ob','DisplayName','15-tab & MMSE');hold on;
xlabel('snr(db)');ylabel('bit error rate');
set(gca,'FontSize',14);
grid on;
legend;
axis square


%%
figure();
semilogy(snr_db,last_error_rate_matrix_1(:,2),'-xr','DisplayName','9-tab & ZFE');hold on;
semilogy(snr_db,last_error_rate_matrix_1(:,5),'-or','DisplayName','15-tab & ZFE');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,2),'-xb','DisplayName','9-tab & MMSE');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,5),'-ob','DisplayName','15-tab & MMSE');hold on;
xlabel('snr(db)');ylabel('bit error rate');title('for channel 2');
set(gca,'FontSize',14);
grid on;
legend;
axis square

%%
figure();
semilogy(snr_db,last_error_rate_matrix_1(:,3),'-xr','DisplayName','9-tab & ZFE');hold on;
semilogy(snr_db,last_error_rate_matrix_1(:,6),'-or','DisplayName','15-tab & ZFE');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,3),'-xb','DisplayName','9-tab & MMSE');hold on;
semilogy(snr_db,last_error_rate_matrix_2(:,6),'-ob','DisplayName','15-tab & MMSE');hold on;
xlabel('snr(db)');ylabel('bit error rate');
set(gca,'FontSize',14);
grid on;
legend;
axis square




%%

