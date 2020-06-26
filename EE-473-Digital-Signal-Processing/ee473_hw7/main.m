clear;close all;clc;
%% q2
[my_voice,sampling_freq] = audioread('ses_deneme_6_wo_noise.wav');
n=0:length(my_voice)-1;

% sound(my_voice,sampling_freq)

signal_energy=sum(my_voice.*my_voice);
noice_energy=signal_energy/20; % noise energy
sigma=sqrt(noice_energy/length(my_voice));

additive_noice=sigma*randn(length(my_voice),1); % awgn
noisy_voice=my_voice+additive_noice; % received

[H_voice_1,w]=freqz(my_voice,512);

figure();
subplot(2,1,1);plot(w/pi,abs(H_voice_1));
xlabel('w');ylabel('|H|');title('Magnitude Response of Voice');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_voice_1));
xlabel('w');ylabel('\angle H');title('Phase Response of Voice');
set(gca,'FontSize',13)
saveas(gcf,'xx_voice.eps','epsc')
%%


figure();
subplot(2,1,1);plot(n,my_voice);
xlabel('n');ylabel('magnitude');title('My Voice');
set(gca,'FontSize',13)
subplot(2,1,2);plot(n,noisy_voice);
xlabel('n');ylabel('magnitude');title('Noisy Voice');
set(gca,'FontSize',13)
saveas(gcf,'xx_1.eps','epsc')

% sound(noisy_voice,sampling_freq)

% % plotting part;
% subplot(2,1,1);plot(n,my_voice);
% xlabel('n');ylabel('magnitude');title('Original Voice');
% subplot(2,1,2);plot(n,noisy_voice);
% xlabel('n');ylabel('magnitude');title('Noisy Voice');
%% q3-impulse-invariance

f = 1500;
[b,a] = butter(10,2*pi*f,'s');
[bz,az] = impinvar(b,a,sampling_freq);
imp_result=filter(bz,az,noisy_voice);
[H_imp_result,w]=freqz(imp_result,512);
[H_imp,w]=freqz(bz,az,512);

figure();
subplot(2,1,1);plot(w/pi,abs(H_imp_result));
xlabel('w');ylabel('|H|');title('Magnitude Response of Impulse-Invariance Filtered Voice');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_imp_result));
xlabel('w');ylabel('\angle H');title('Phase Response of Impulse-Invariance Filtered Voice');
set(gca,'FontSize',13)
saveas(gcf,'xxx_impinv_result.eps','epsc')

figure();
subplot(2,1,1);plot(w/pi,abs(H_imp));
xlabel('w');ylabel('|H|');title('Magnitude Response of Impulse-Invariance Filter');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_imp));
xlabel('w');ylabel('\angle H');title('Phase Response of Impulse-Invariance Filter');
set(gca,'FontSize',13)
saveas(gcf,'xxx_impinv_filter.eps','epsc')
% sound(imp_result,sampling_freq)

%% q3-kaiser
[kaiser_result,kaiser_h]=kaiser_function(noisy_voice);
%sound(kaiser_result,sampling_freq);
[H_kaiser_result,w]=freqz(kaiser_result,512);
figure();
subplot(2,1,1);plot(w/pi,abs(H_kaiser_result));
xlabel('w');ylabel('|H|');title('Magnitude Response of Kaiser Filtered Voice');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_kaiser_result));
xlabel('w');ylabel('\angle H');title('Phase Response of Kaiser Filtered Voice');
set(gca,'FontSize',13)
saveas(gcf,'xxx_kaiser_result.eps','epsc')

[h_kaiser,wk]=freqz(kaiser_h,1,512);
figure();
subplot(2,1,1);plot(w/pi,abs(h_kaiser));
xlabel('w');ylabel('|H|');title('Magnitude Response of Kaiser Filter');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(h_kaiser));
xlabel('w');ylabel('\angle H');title('Phase Response of Kaiser Filter');
set(gca,'FontSize',13)
saveas(gcf,'xxx_kaiser_filter.eps','epsc')



%% q3-pml
h_pml= firpm(23,[0 0.2 0.4 1],[1 1 0 0],[1 5]);
pml_result=filter(h_pml,1,noisy_voice);
[H_pml_result,w]=freqz(pml_result,512);
[H_pml,w]=freqz(h_pml,1,512);

figure();
subplot(2,1,1);plot(w/pi,abs(H_pml_result));
xlabel('w');ylabel('|H|');title('Magnitude Response of Parks-McClellan Filtered Voice');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_pml_result));
xlabel('w');ylabel('\angle H');title('Phase Response of Parks-McClellan Filtered Voice');
set(gca,'FontSize',13)
saveas(gcf,'xxx_pmc_result.eps','epsc')

figure();
subplot(2,1,1);plot(w/pi,abs(H_pml));
xlabel('w');ylabel('|H|');title('Magnitude Response of Parks-McClellan Filter');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_pml));
xlabel('w');ylabel('\angle H');title('Phase Response of Parks-McClellan Filter');
set(gca,'FontSize',13)
saveas(gcf,'xxx_pmc_filter.eps','epsc')


%sound(pml_result,sampling_freq)

%% q3-bilinear
[b1,a1]=butter(10,0.15);
[H_bilinear,w1]=freqz(b1,a1,512);
binomial_result=filter(b1,a1,noisy_voice);
[H_bilinear_result,w1]=freqz(binomial_result,512);

figure();
subplot(2,1,1);plot(w/pi,abs(H_bilinear_result));
xlabel('w');ylabel('|H|');title('Magnitude Response of Bilinear Filtered Voice');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_bilinear_result));
xlabel('w');ylabel('\angle H');title('Phase Response of Bilinear Filtered Voice');
set(gca,'FontSize',13)
saveas(gcf,'xxx_bl_result.eps','epsc')

figure();
subplot(2,1,1);plot(w/pi,abs(H_bilinear));
xlabel('w');ylabel('|H|');title('Magnitude Response of Bilinear Filter');
set(gca,'FontSize',13)
subplot(2,1,2);plot(w/pi,angle(H_bilinear));
xlabel('w');ylabel('\angle H');title('Phase Response of Bilinear Filter');
set(gca,'FontSize',13)
saveas(gcf,'xxx_bl_filter.eps','epsc')

%sound(binomial_result,sampling_freq)


%%
% result=abs(fftshift(fft(noisy_voice)));
% 
% n_1=linspace(-pi,+pi,length(result));
% plot(n_1,result);


%plot(kaiser_result)
%sound(kaiser_result,sampling_freq)
%sound(noisy_voice,sampling_freq)



%%
imp_result=imp_inv(noisy_voice);
subplot(312),plot(imp_result);
sound(4*imp_result,sampling_freq)



