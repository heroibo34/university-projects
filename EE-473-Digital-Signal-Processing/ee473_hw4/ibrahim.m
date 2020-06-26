w=linspace(-2*pi,2*pi,10^6);
H_1=exp(-1i*w*3);

figure();
subplot(2,1,1);plot(w/pi,round(abs(H_1)));
xlabel('w (\cdot\pi)');ylabel('|H_1|');title('Magnitude of H_1')
subplot(2,1,2);plot(w/pi,angle(H_1));
xlabel('w (\cdot\pi)');ylabel('\angle H_1');title('Phase of H_1')




%%
H_2=((-3/4)+exp(1i*w))./(1-3/4*(exp(1i*w)));


figure();
subplot(2,1,1);plot(w/pi,round(abs(H_2)));
xlabel('w (\cdot\pi)');ylabel('|H_2|');title('Magnitude of H_2')
subplot(2,1,2);plot(w/pi,angle(H_2));
xlabel('w (\cdot\pi)');ylabel('\angle H_2');title('Phase of H_2')

%%
figure();
subplot(2,1,1);plot(w/pi,angle(H_1));
xlabel('w (\cdot\pi)');ylabel('\angle H_1');title('Phase of H_1')
subplot(2,1,2);plot(w/pi,angle(H_2));
xlabel('w (\cdot\pi)');ylabel('\angle H_2');title('Phase of H_2')




%% 3


n=linspace(0,50,51);
x_n=(3/4).^n;
stem(n,x_n);
xlabel('n');ylabel('x[n]');title('Graph x[n]');


%%
y_1=filter([0,0,0,1],[1],x_n);
stem(n,y_1,'DisplayName','y_1[n]');
hold on;

y_2=filter([-3/4,1],[1,-3/4],x_n);
stem(n,y_2,'DisplayName','y_2[n]');
xlabel('n');ylabel('magnitude');title('Graph for y_1[n],y_2[n]');

legend;

%%

X=fft(x_n,1024);
Y1=fft(y_1,1024);
Y2=fft(y_2,1024);
subplot(2,3,1);plot(abs(X));
xlabel('w');ylabel('|X|');title('Magnitude of X');
subplot(2,3,2);plot(abs(Y1));
xlabel('w');ylabel('|Y_1|');title('Magnitude of Y_1');
subplot(2,3,3);plot(abs(Y2));
xlabel('w');ylabel('|Y_2|');title('Magnitude of Y_2');
subplot(2,3,4);plot(angle(X));
xlabel('w');ylabel('\angle X');title('Phase of X');
subplot(2,3,5);plot(angle(Y1));
xlabel('w');ylabel('\angle Y_1');title('Phase of Y_1');
subplot(2,3,6);plot(angle(Y2));
xlabel('w');ylabel('\angle Y_2');title('Phase of Y_2');
%%
y_22=filter([-3/4,1],[1,-3/4],y_2);
Y_22=fft(y_22,1024);

subplot(2,1,1);plot(abs(X));
xlabel('w');ylabel('|X|');title('Magnitude of X');
subplot(2,1,2);plot(abs(Y_22));
xlabel('w');ylabel('|Y_{22}|');title('Magnitude of Y_{22}');











