clear;
clc;
d_1=0.1;
d_2=0.05;
d_min=0.05;
w_p=0.4*pi;
w_s=0.8*pi;
A=-20*log10(d_min); % find A
M=ceil((A-8)/(2.285*(w_s-w_p))); %round upper integer
my_beta=0.5842*(A-21)^(0.4)+(A-21)*0.07886; % because 21<A<50
n=0:1:M;
w_1=zeros(1,M+1);
for i=0:1:M
    temp=sqrt(1-(i-M/2)^2/(M/2)^2);
    w_1(i+1)=besselj(0,my_beta.*temp)/besselj(0,my_beta);   
end

h_1=0.5*sinc(0.5*(n-M/2)).*w_1;
figure();
stem(n,h_1);
xlabel('n'),ylabel('h_2[n]');title('Impulse Response of the System from bessel functions');
set(gca,'FontSize',13);
    

w_2=kaiser(M+1,my_beta)';
h_2=0.5*sinc(0.5*(n-M/2)).*w_2;
figure();
stem(n,h_1);
xlabel('n'),ylabel('h_1[n]');title('Impulse Response of the System from kaiser functions');
set(gca,'FontSize',13);



%%
[H,w_f]=freqz(h,1,4096);
freqz(h,1,4096);


figure();

subplot(4,1,1);plot(w_f/pi,abs(H));
xlabel('0 \leq w/\pi \leq 1'),ylabel('|H|');title('Magnitude Response of H');
set(gca,'FontSize',13);
subplot(4,1,2);plot(w_f/pi,angle(H));
xlabel('0 \leq w/\pi \leq 1'),ylabel('\angle H)');title('Phase of H');
set(gca,'FontSize',13);
subplot(4,1,3);plot(w_f/pi,abs(H));
axis([0 0.4 0.99 1.01]);xlabel('0 \leq w/\pi \leq 0.4'),ylabel('|H|');title('Magnitude Response of H (passband)');
set(gca,'FontSize',13);
subplot(4,1,4);plot(w_f/pi,abs(H));
axis([0.6 1 0 0.01]);xlabel('0.6 \leq w/\pi \leq 1'),ylabel('|H|');title('Magnitude of H (stopband)');
set(gca,'FontSize',13);
