%% part a
[b,a] = ellip(4,.2,40,[.41 .47]);
M=max(abs([b a]));
N=16;
b16=quant(b,N,M);
a16=quant(a,N,M);
[H16,w16] = freqz(b16,a16,4096);
subplot(2,1,1);plot(w/pi,20*log10(abs(H16)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response of H-16bit quantized');
axis([0 1 -80 10]);
subplot(2,1,2);plot(w/pi,20*log10(abs(H16)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response of H-16bit quantized');
axis([.41 .47 -4 2]);
temp=[b16-b a16-a];
max(abs(temp))
%% part b
dpzplot(b16,a16);
title('Pole-Zero for H-16bit quantized');
%% part c
N=12;
b12=quant(b,N,M);
a12=quant(a,N,M);
[H12,w12] = freqz(b12,a12,4096);
subplot(2,1,1);plot(w/pi,20*log10(abs(H12)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response of H-12bit quantized');
axis([0 1 -80 10]);

subplot(2,1,2);plot(w/pi,20*log10(abs(H12)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response of H-12bit quantized');
axis([.41 .47 -2 5]);
%%
dpzplot(b12,a12);
title('Pole-Zero for H-12bit quantized');
%% part e
h=filter(b12,a12,[1 zeros(1,4095)]);
plot(h);
xlabel('n');ylabel('h[n]');title('Impulse Response(by plot)');







