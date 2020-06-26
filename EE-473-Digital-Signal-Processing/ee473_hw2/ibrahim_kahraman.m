%% Q2
cont_omega=[0, pi/2,pi,3*pi/2,2*pi];
disc_omega=[0, pi/2,pi,3*pi/2,2*pi];
t=linspace(0,50,10000);
n=linspace(0,26,25);
figure();

for i=1:5
    
    subplot(5,1,i);
    y=cos(cont_omega(i)*t);
    plot(t,y);
    xlabel('t');
    ylabel('cos(Ωt)')
    
    
end


figure();
for i=1:5
    
    subplot(5,1,i);
    y=cos(disc_omega(i)*n);
    stem(n,y);
end

%% Q3

voice_signal=load('lineup.mat');
signal_y=voice_signal.y;
sound(signal_y(1:1:3*end/5))

n=0:1:1010;
alfa=0.5;
impulse_1=[1, zeros(1,999), alfa, zeros(1,10)];
plot(n,impulse_1,'linewidth',2);
xlabel('n');
ylabel('h[n]');
grid on;

%% 3-e

diract_delta=[1, zeros(1,100000)];

coeff_output=[1,zeros(1,999), alfa];
coeff_input=[1];

out=filter(coeff_input,coeff_output,signal_y);
h_1=filter(coeff_output,coeff_input,diract_delta);


h_2=filter(coeff_input,coeff_output,diract_delta);

temp=conv(h_1,h_2);
plot(temp)
disp(sum(temp))
%%
sound(z);

figure();
subplot(2,1,1);
plot(y);title('signal with echo-y[n]');
xlabel('n');
ylabel('value');
subplot(2,1,2);
plot(z);title('signal after echo cancellation-x[n]')
xlabel('n');
ylabel('value');






