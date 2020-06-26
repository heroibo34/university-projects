%% Question-3
w=linspace(-2*pi,2*pi,1000);

H_ideal=~((abs(w)<(3*pi/2)) & (abs(w)>(pi/2)));
% H_ideal=double(H_ideal);
plot(w/pi,H_ideal)

name={'-2\Pi';'-1.5\Pi';'-\Pi';'-0.5\Pi';'0';'0.5\Pi';'\Pi';'1.5\Pi';'2\Pi'};
set(gca,'XTickLabel',name)

title('Frequency Response')
xlabel('frequency(w)')
ylabel('|H_{ideal}(e^{jw})|')
ylim([0 1.2])

%% part b
N=9;
k=0:(N-1);
w=2*pi*k/N;
H_m=~((w<(3*pi/2)) & (w>(pi/2)));
H_m=double(H_m);
stem(k,H_m);
xlabel('w=k*2\Pi/8 where x values represents k')
ylabel('|H|')
ylim([0 1.2])


%% part c
H_p=-w*(N-1)/2
%H_p=exp(-1i*w*(N-1)/2);


%% part d

F=zeros(N,N);

for m=1:N
    for n=1:N
        
        F(m,n)=exp(1i*w(m)*(n-1));
              
    end
end
 
H=H_m.*H_p;

h=F\H';
stem(real(h),'fill');
xlabel('n');
ylabel('amplitude of h[n]');
title('Impulse Response')
%% part e

plot(abs(fft(h,1000)))
x1=linspace(0,2*pi,1000);
figure, plot(x1,abs(fft(h,1000)),'r');
hold on
stem(w,Hm,'b'); axis([0 2*pi 0 1.5]);
title('Discrete Time Fourier Transform')
ylabel('values')
xlabel('w')


