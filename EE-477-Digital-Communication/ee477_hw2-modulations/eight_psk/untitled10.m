%% yukledikten sonra
energy_norm_coeff=1;
Infty=50;
number_of_bits=3000;
N=(number_of_bits);
max_nframe =2000;
ferlim=100;
snr_db=0:2:20;
m=3;
M=8;
Nsy=number_of_bits/m;
bit_errs=sim_res(:,1);
nframes=sim_res(:,2);
symbol_error_number=sim_res_sy(:,1);

bit_error_rate=bit_errs./(nframes*N);
symbol_error_rate=symbol_error_number./nframes/Nsy;
en = 10.^(snr_db/10);


SNR = 10.^(snr_db/10);
BNR= SNR/m;
symbol_error_theory=2*qfunc(sqrt(2*SNR).*sin(pi/M)); %for Es/N