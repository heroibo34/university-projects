clear;clc;
load nframes.mat
load bit_errs_zfe_10.mat
load bit_errs_mmse_10.mat
load error_matrix.mat
snr_db=0:5:50;
figure();
number_of_bits=4000;
semilogy(snr_db, bit_errs_zfe_10./nframes/number_of_bits, 'r-x','DisplayName','ZFE-10');hold on;
semilogy(snr_db, bit_errs_mmse_10./nframes/number_of_bits, 'b-x','DisplayName','MMSE-10');

snr_db=0:2:20;
hold on;semilogy(snr_db,error_matrix,'k-x','DisplayName','Viterbi');

legend;
title('BER')
xlabel('snr (db)'); ylabel('Error Rate');
set(gca,'FontSize',14)
axis square;grid on;
saveas(gcf,'q1.eps','epsc')
