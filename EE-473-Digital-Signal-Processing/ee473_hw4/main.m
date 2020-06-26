w=linspace(-2*pi,2*pi,10^6);
H_1=exp(-1i*w*3);

figure();
plot(abs(H_1))

figure();
plot(angle(H_1))
%%
H_2=((-3/4)+exp(1i*w))./(1-3/4*(exp(1i*w)));


figure();
plot(abs(H_2))
figure();
plot(angle(H_2))

%%

n=linspace(0,50,51);
x_n=(3/4).^n;
stem(n,x_n)

y_1=filter([0,0,0,1],[1],x_n);
stem(n,y_1)

y_2=filter([-3/4,1],[1,-3/4],x_n);
stem(n,y_2)

%%

X=fft(x_n,1024);
Y1=fft(y_1,1024);
Y2=fft(y_2,1024);
subplot(2,3,1);plot(abs(X));
subplot(2,3,2);plot(abs(Y1));
subplot(2,3,3);plot(abs(Y2));
subplot(2,3,4);plot(angle(X));
subplot(2,3,5);plot(angle(Y1));
subplot(2,3,6);plot(angle(Y2));
%%
y_22=filter([-3/4,1],[1,-3/4],y_2);
Y_22=fft(y_22,1024);

plot(abs(Y_22))












