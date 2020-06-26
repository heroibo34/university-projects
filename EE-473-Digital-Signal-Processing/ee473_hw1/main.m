%%
%question 2

m_1=0;
m_2=4;
w=linspace(-2*pi,2*pi,10^4); %frequency
coeff = 1/(m_1+m_2+1);
%H is the frequency response of the system
H=coeff*(sin(w*(m_1+m_2+1)/2)./sin(w/2)).*exp(-1i*w*(m_2-m_1)/2); 

figure(1);
plot(w/pi,abs(H))
xlabel('w (*pi)');
ylabel('|H|');
title('Magnitude Response of the System')

phase=angle(H); %phase of the frequency response
figure(2);
plot(w/pi,phase);
xlabel('w (*pi)');
ylabel('phase of H');
title('Phase Response of the System')



%%
%question-3

a=[1 -1.8*cos(pi/16) 0.81]; %coeff y
b=[1 1/2]; %% coeff x
n=0:100; 
[h, x] = dimpulse(b,a,length(n));
plot(x);
h=[zeros(10,1);h];
n=-10:100;
stem(n,h);
title('Impulse response of the difference equation');
xlabel('n');
ylabel('h[n]');


%%
%question-3b

coef_b = [1 1/2];
coef_a = [1 -1.8*cos(pi/16) 0.81];
[r,p,k] = residuez(coef_b,coef_a);

abs_p1 = abs(p(1));
imag_p1 = imag(p(1));

abs_p2 = abs(p(2));
imag_p2 = imag(p(2));


%%
%question3c

n = 0:100;
h = (0.5-3.9375i)*((0.9).^n).*(exp(0.1756i*n))+(0.5+3.9375i)*((0.9).^n).*(exp(-0.1756i.*n));
x = exp(1i.*n*pi/3);


coeff_b = [1 -1.8*cos(pi/16) 0.81];
coeff_a = [1 1/2];
y = filter(coeff_a,coeff_b,x);
mag_y = abs(y);
phase_y = angle(y);
figure();
stem(n,mag_y)  
ylabel('abs(y[n])');
figure(3)
stem(n,phase_y)
ylabel('phase y[n]')

%% 
%Part E

w = -pi:0.1:pi;

Hss = (1+(1/2)*(exp(-1i*w)))./(1-1.8*cos(pi/16)*exp(-1i*w)+0.81*exp(-2*1i*w));

plot(w,abs(Hss))
title('Magnitude of H');
ylabel('abs(Hss(w))');
xlabel('w');

figure(2)
plot(w,angle(Hss))

title('Phase of H');
ylabel('Phase Hss(w)');
xlabel('w');

%% 
%Part F


n = 0:100;

x = exp(1i.*n*pi/3);
w = pi/3;
coeff_b = [1 -1.8*cos(pi/16) 0.81];
coeff_a = [1 1/2];
y = filter(coeff_a,coeff_b,x);

Hss = (1+(1/2)*(exp(-1i*w)))./(1-1.8*cos(pi/16)*exp(-1i.*w)+0.81*exp(-2*1i*w));

yss = exp(1i*(pi/3).*n)*Hss;
y_trans = y-yss;

stem(n,abs(y_trans))
title('Magnitude of Transient');
ylabel('|ytr[n]|');
xlabel('n');

figure(2)
stem(angle(y_trans))
title('Phase of Transient');
ylabel('<ytr[n]');
xlabel('n');



