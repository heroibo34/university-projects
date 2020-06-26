clc;clear;
M=23;

[b,p_err] = firpm(M,[0 0.4 0.6 1],[1 1 0 0],[1 5]);
[H,w_f] = freqz(b,1,1000);

figure();subplot(4,1,1);plot(w_f/pi,abs(H));title('Magnitude Response of H');
xlabel('0 \leq w/\pi \leq 1'),ylabel('|H|');
set(gca,'FontSize',13);
subplot(4,1,2);plot(w_f/pi,angle(H));title('Phase Response of H');
xlabel('0 \leq w/\pi \leq 1'),ylabel('\angle H');
set(gca,'FontSize',13);
subplot(4,1,3);plot(w_f/pi,abs(H));title('Magnitude Response of H in passband')
axis([0 0.4 0.95 1.05]);xlabel('0 \leq w/\pi \leq 0.4'),ylabel('|H|');
set(gca,'FontSize',13);
subplot(4,1,4);plot(w_f/pi,abs(H));title('Magnitude Response of H in stopband')
axis([0.6 1 0 0.01]);xlabel('0.6 \leq w/\pi \leq 1'),ylabel('|H|');
set(gca,'FontSize',13);

figure();
freqz(b,1,1000);