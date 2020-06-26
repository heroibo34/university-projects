clc;clear;

channel=[0.74 -0.514 0.37 0.216 0.062]; % channel
number_of_bits=10^3;
max_nframe =1000;
ferlim=100;
snr_db=0:2:50;

%% Erors
nframes=zeros(length(snr_db),1);
ferrs=zeros(length(snr_db),1);
error_fde1=zeros(length(snr_db),1);
error_fde3=zeros(length(snr_db),1);
error_fde5=zeros(length(snr_db),1);
error_fde10=zeros(length(snr_db),1);
error_zfe10=zeros(length(snr_db),1);
error_mmse10=zeros(length(snr_db),1);



H_channel=fft(channel,number_of_bits); % freq domain

%% ZFE and MMSE

H=[channel,repmat([zeros(1,10) channel],1,9)];
H=reshape(H,[],10)';
e=[1; zeros(13,1)];
v_zfe=inv(H*H')*H*e;




for nEN = 1:length(snr_db) % SNR POINTS
    nEN
    snr_db_temp=snr_db(nEN);
    en = 10^(snr_db_temp/10); % convert SNR from unit db to normal numbers
    sigma=sqrt(en);
    nframe = 0;
    %%%%%%%%%MMSE%%%%%%%%%%%%%%%%%%%
    w_mmse_10=inv(H*H'+eye(10)/en)*H*e;
    while (nframe<max_nframe) && (ferrs(nEN)<ferlim)
        nframe=nframe+1;
        
        sends=2*round(rand(1,number_of_bits))-1;
        
        rec_s=conv(sends,channel);
        rec_s=rec_s(1:number_of_bits);
        y=awgn(rec_s,snr_db_temp,'measured');% channel+noise
        
        x_1=[sends(end) sends]; %1 cyclic prefix
        rec_s_1=conv(x_1,channel);
        rec_s_1=rec_s_1(1:1001);
        rec_1=awgn(rec_s_1,snr_db_temp,'measured');% channel+noise
        
        x_3=[sends(end-2:end) sends]; %3 cyclic prefix
        rec_s_3=conv(x_3,channel);
        rec_s_3=rec_s_3(1:1003);
        rec_3=awgn(rec_s_3,snr_db_temp,'measured');% channel+noise
        
        x_5=[sends(end-4:end) sends]; %5 cyclic prefix
        rec_s_5=conv(x_5,channel);
        rec_s_5=rec_s_5(1:1005);
        rec_5=awgn(rec_s_5,snr_db_temp,'measured');% channel+noise
        
        x_10=[sends(end-9:end) sends]; %10 cyclic prefix
        rec_s_10=conv(x_10,channel);
        rec_s_10=rec_s_10(1:1010);
        rec_10=awgn(rec_s_10,snr_db_temp,'measured');% channel+noise


        %%Fde detection
       
        Y1=fft(rec_1(2:end),number_of_bits);
        Y1_eq=(Y1-1/(2*en))./H_channel;
        y1_eq=ifft(Y1_eq);
        detected_bits_fde_1=sign(y1_eq);
        
        Y3=fft(rec_3(4:end),number_of_bits);
        Y3_eq=(Y3-1/(2*en))./H_channel;
        y3_eq=ifft(Y3_eq);
        detected_bits_fde_3=sign(y3_eq);
        
        Y5=fft(rec_5(6:end),number_of_bits);
        Y5_eq=(Y5-1/(2*en))./H_channel;
        y5_eq=ifft(Y5_eq);
        detected_bits_fde_5=sign(y5_eq);
        
        Y10=fft(rec_10(11:end),number_of_bits);
        Y10_eq=(Y10-1/(2*en))./H_channel;
        y10_eq=ifft(Y10_eq);
        detected_bits_fde_10=sign(y10_eq);
      

        
        %%ZFE-MMSE-detection
        z_zfe10=conv(y,v_zfe');
        z_zfe10=z_zfe10(1:number_of_bits);
        z_mmse10=conv(y,w_mmse_10');
        z_mmse10=z_mmse10(1:number_of_bits);
        detected_bits_zfe10=sign(z_zfe10);
        detected_bits_mmse10=sign(z_mmse10);
        
        
        %%errors
        err_count_zfe10=number_of_bits-sum(sends==detected_bits_zfe10);
        error_zfe10(nEN)=error_zfe10(nEN)+err_count_zfe10;
        
        err_count_mmse10=number_of_bits-sum(sends==detected_bits_mmse10);
        error_mmse10(nEN)=error_mmse10(nEN)+err_count_mmse10;
        
        err_count_fde1=number_of_bits-sum(sends==detected_bits_fde_1);
        error_fde1(nEN)=error_fde1(nEN)+err_count_fde1;
        
        err_count_fde3=number_of_bits-sum(sends==detected_bits_fde_3);
        error_fde3(nEN)=error_fde3(nEN)+err_count_fde3;
        
        err_count_fde5=number_of_bits-sum(sends==detected_bits_fde_5);
        error_fde5(nEN)=error_fde5(nEN)+err_count_fde5;
        
        err_count_fde10=number_of_bits-sum(sends==detected_bits_fde_10);
        error_fde10(nEN)=error_fde10(nEN)+err_count_fde10;
       
        if err_count_mmse10~=0
            ferrs(nEN)=ferrs(nEN)+1;
        end
    end 
    nframes(nEN)=nframe;
end 
%%
last_error_matrix=[error_mmse10,error_fde1,error_fde3,error_fde5,error_fde10,nframes];
save last_error_matrix.mat last_error_matrix

%% plots
snr_db=0:2:50;
number_of_bits=10^3;
load last_error_matrix.mat
error_mmse10=last_error_matrix(:,1);
error_fde1=last_error_matrix(:,2);
error_fde3=last_error_matrix(:,3);
error_fde5=last_error_matrix(:,4);
error_fde10=last_error_matrix(:,5);
nframes=last_error_matrix(:,6);


figure();
semilogy(snr_db(1:21), error_mmse10(1:21)./nframes(1:21)/number_of_bits, 'k-x','DisplayName','MMSE');hold on;
semilogy(snr_db(1:21), error_fde1(1:21)./nframes(1:21)/number_of_bits, 'b-x','DisplayName','FDE-1');
semilogy(snr_db(1:21), error_fde3(1:21)./nframes(1:21)/number_of_bits, 'g-x','DisplayName','FDE-3');
semilogy(snr_db(1:21), error_fde5(1:21)./nframes(1:21)/number_of_bits, 'm-x','DisplayName','FDE-5');
semilogy(snr_db(1:21), error_fde10(1:21)./nframes(1:21)/number_of_bits, 'r-x','DisplayName','FDE-10');
legend;
xlabel('snr (db)');ylabel('error');title('BER');
axis square;grid on;
set(gca,'FontSize',14)
saveas(gcf,'q2.eps','epsc')


