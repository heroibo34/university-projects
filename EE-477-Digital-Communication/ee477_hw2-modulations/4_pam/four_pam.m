clear all
warning off
%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%
energy_norm_coeff=sqrt(1/5);
Infty=50;
number_of_bits=3000;
N=(number_of_bits);
max_nframe =2000;
ferlim=100;
snr_db=0:2:20;
%%%%% SYMBOL CONSTELLATION %%%%%%%%%

tb4=[0 0;0 1; 1 0; 1 1];
tb8=[zeros(4,1) tb4; ones(4,1) tb4];
tb16=[zeros(8,1) tb8; ones(8,1) tb8];
%%%%%%%%%%%%%CORRELATION MATRICES %%%%%%%%%%%%%%
%%%%%%%%%%%%%%ERROR MATRICES%%%%%%%%%%%%%%%%%%%%
errs=zeros(length(snr_db), 1);
symbol_error_number=zeros(length(snr_db), 1);
nframes=zeros(length(snr_db), 1);
ferrs=errs;
m_bit=2; n_bit=0;
M=2^(m_bit+n_bit);%symbol number
bits=tb4;
code_symbols=energy_norm_coeff*[-3,-1,1,3]*exp(1j*2*pi);
tot_bits=m_bit+n_bit;
Nsy=N/tot_bits;%number of symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for nEN = 1:length(snr_db) % SNR POINTS
    snr_p=snr_db(nEN);
    en = 10^(snr_p/10); % convert SNR from unit db to normal numbers
    sigma = 1/sqrt(en); % standard deviation of AWGN noise
    nframe = 0;
    while (nframe<max_nframe) && (ferrs(nEN)<ferlim)
        err_count=0;
        nframe = nframe + 1;
        info_bits=round(rand(1,number_of_bits));
        info_part=reshape(info_bits, tot_bits, Nsy);
        info_matrix=info_part';
        sym_vec=ones(Nsy, 1);
        for v=1:tot_bits
            sym_vec=sym_vec+info_matrix(:,v).*2^(m_bit+n_bit-v);
        end
        sym_seq=code_symbols(sym_vec);%gelen sinyali e uzerine cevirme
        %%%%%%%%%%%%%CHANNEL %%%%%%%%%%%%%%%%%%%%%
        noise=1/sqrt(2)*[randn(1, Nsy) + 1j*0];
        det_seq=zeros(1,N);
        rec_sig=sym_seq+sigma*noise;% received signal
        %%%%DETECTOR %%%%%%%%%%%%
       
        for k=1:Nsy
            min_metric=10^6; dm=zeros(1,M);
            for r=1:M
                x_r=code_symbols(r);
                dm(r)=norm(rec_sig(k)-x_r);
            end
            [rowmin, sym_ind]=min(dm);
            detected_symbol=sym_ind;
            err_symbol = length(find(sym_vec(k)~=detected_symbol'));
            symbol_error_number(nEN)=symbol_error_number(nEN)+err_symbol;
            
            detected_bits=[bits(sym_ind, :)];
            
            err = length(find(info_part(:,k)~=detected_bits'));
            errs(nEN)=errs(nEN)+err;
            
            err_count=err_count+err;
        end
        
        if err_count~=0
            ferrs(nEN)=ferrs(nEN)+1;
        end
    end % End of while loop
    nframes(nEN)=nframe;
    sim_res=[errs nframes symbol_error_number];
    
end %end for (SNR points)
sim_res=[errs nframes symbol_error_number];

save fourPAM_bit1.mat sim_res

%% yukledikten sonra initialize
energy_norm_coeff=1;
Infty=50;
number_of_bits=3000;
N=(number_of_bits);
max_nframe =2000;
ferlim=100;
snr_db=0:2:20;
m=2;
M=4;
Nsy=number_of_bits/m;


bit_errs=sim_res(:,1);
nframes=sim_res(:,2);
symbol_error_number=sim_res(:,3);

bit_error_rate=bit_errs./(nframes*N);
symbol_error_rate=symbol_error_number./nframes/Nsy;
en = 10.^(snr_db/10);


SNR = 10.^(snr_db/10);
BNR= SNR/m;
symbol_error_theory=2*(M-1)/M*qfunc(sqrt(6*SNR/(M^2-1))); %for Es/N

en = 10.^(snr_db/10);
%%
% figure();

%symbol error rate monte carlo for Es

semilogy(snr_db, bit_error_rate, 'r-x','DisplayName','BER-Eb uniform');
hold on;
%symbol error rate with q function for Es
semilogy(snr_db, symbol_error_theory*5/8, 'rs','DisplayName','BER-Eb theory uniform');
hold on;
xlabel('SNR')
ylabel('ERROR')
axis square
grid on
legend;
title('4pam')






