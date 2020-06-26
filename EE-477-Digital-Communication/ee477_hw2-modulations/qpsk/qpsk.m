clear all
warning off
%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%
energy_norm_coeff=1;
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
m_bit=1; n_bit=1;
M=2^(m_bit+n_bit);%symbol number
bits=tb4;
code_symbols=energy_norm_coeff*exp(1j*2*pi*[0:(M-1)]/M);
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
        noise=1/sqrt(2)*[randn(1, Nsy) + 1j*randn(1,Nsy)];
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
    sim_res=[errs nframes symbol_error_number]
  
end %end for (SNR points)
sim_res=[errs nframes symbol_error_number];
save QPSK_demo.mat sim_res
%% yukledikten sonra
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
symbol_error_theory=qfunc(sqrt(SNR)); %for Es/N
%%
figure();

%symbol error rate monte carlo for Es
semilogy(snr_db, symbol_error_number./nframes/Nsy, 'r-x','DisplayName','SER-SNR');
hold on;
%symbol error rate with q function for Es
semilogy(snr_db, 2*qfunc(sqrt(2*en)*sin(pi/4)), 'rs','DisplayName','SER-SNR theory');
hold on;

%symbol error rate for Eb
semilogy(snr_db-3, symbol_error_number./nframes/Nsy, 'r-o','DisplayName','SER-Eb/No');
hold on;
%symbol error rate with q function for Eb
semilogy(snr_db-3, 2*qfunc(sqrt(en)), 'rd','DisplayName','SER-Eb/No theory');
hold on;



%bit error rate monte carlo for Es
semilogy(snr_db, errs./nframes/number_of_bits, 'b-x','DisplayName','BER-SNR');
hold on;
%bit error rate with q function for Es
semilogy(snr_db, (3/4)*2*qfunc(sqrt(en)), 'bs','DisplayName','BER-SNR theory');
hold on;

%bit error rate for Eb
semilogy(snr_db-3, errs./nframes/number_of_bits, 'b-o','DisplayName','BER-Eb/No');
hold on;
%symbol error rate with q function for Eb
semilogy(snr_db-3, (3/4)*2*qfunc(sqrt(en)), 'bd','DisplayName','BER-Eb/No theory');
hold on;
xlabel('SNR')
ylabel('ERROR')
axis square
grid on
legend;




