clc;clear;
[Y,fs]=audioread('ses_deneme_6_wo_noise.wav');
N=length(Y);
Y_energy=sum(Y.*Y);
noise_energy=Y_energy/20;
noise=sqrt(noise_energy/N)*randn(N,1);
Y_noisy=Y+noise;
figure
subplot(212), plot(Y_noisy);title('Sound without Noise')
subplot(211),plot(Y);title('Sound with Noise')
%%
f = 1500;
[b,a] = butter(10,2*pi*f,'s');
[bz,az] = impinvar(b,a,fs);
Y_filtered_imp=filter(bz,az,Y_noisy);
[H_imp,w]=freqz(Y_filtered_imp,4096);
figure, subplot(211), plot(w/pi,abs(H_imp));
subplot(212), plot(w/pi,angle(H_imp));
sound(Y_filtered_imp,fs)
%%
Y_filtered_kaiser=Kaiser_func(Y_noisy);
%subplot(313),plot(Y_filtered_kaiser);
sound(Y_filtered_kaiser,fs)
[H,w]=freqz(Y_filtered_kaiser,4096);
figure, subplot(211), plot(w/pi,abs(H_imp));
subplot(212), plot(w/pi,angle(H_imp));
sound(Y_filtered_imp,fs)
%%
h_pm= firpm(23,[0 0.2 0.4 1],[1 1 0 0],[1 5]);

Y_filtered_PML=filter(h_pm,1,Y_noisy);
figure
subplot(311),plot(Y_filtered_PML);
sound(Y_filtered_PML,fs)


%%
[b_b,a_b]=butter(10,0.15);
[H_bm,w]=freqz(b_b,a_b,4096);
Y_filtered_binomial=filter(b_b,a_b,Y_noisy);
subplot(313),plot(Y_filtered_binomial)
sound(Y_filtered_binomial,fs)
figure,plot(w/pi,abs(H_bm))
%%
% freqz(Y)
% figure
% freqz(Y_filtered_PML)