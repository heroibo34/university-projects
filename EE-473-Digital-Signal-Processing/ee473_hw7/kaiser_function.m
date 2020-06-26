function [result,h] = kaiser_function(noisy_voice)
%%

d_p=0.01;
d_s=0.05;
delta=min(d_p,d_s);
w_p=0.2*pi;
w_s=0.3*pi;
w_c=(w_p+w_s)/2;
delta_w=abs(w_s-w_p);
A=-20*log10(delta);
M=ceil((A-8)/(2.285*delta_w));
my_beta=0.5842*(A-21)^(0.4)+(A-21)*0.07886;
w=kaiser(M+1,my_beta)';
n=0:1:M;
h=fir1(M,0.25,'low',w);
%h=0.5*sinc(0.5*(n-M/2)).*w;
result=conv(noisy_voice,h);


% plot(fftshift(abs(fft(h))))



end

