%% 4-pam
delta = sqrt(2/5);
f_c=5;
t=0:0.001:1-0.001;
signal_1=-3*delta*cos(2*pi*f_c*t); % 00
signal_2=-delta*cos(2*pi*f_c*t); % 01
signal_3=delta*cos(2*pi*f_c*t); % 10
signal_4=3*delta*cos(2*pi*f_c*t); % 11

subplot(2,2,1);
plot(t,signal_1)
title('s_1=00');
xlabel('t');
ylabel('amplitude');
subplot(2,2,2); 
plot(t,signal_2)
title('s_2=01');
xlabel('t');
ylabel('amplitude');
subplot(2,2,3); 
plot(t,signal_3)
title('s_3=10');
xlabel('t');
ylabel('amplitude');
subplot(2,2,4); 
plot(t,signal_4)
title('s_4=11');
xlabel('t');
ylabel('amplitude');




signal=[signal_3, signal_4, signal_4, signal_1];
t=linspace(0,4-0.001,4000);
figure();
plot(t,signal)
title('4PAM');
xlabel('t');
ylabel('amplitude');




%% 4-pam constellation

values=[-3, -1, 1, 3];
plot(real(values),imag(values),'ored','linewidth',3);
xlim([-5 5]);
ylim([-2 2]);
title('4-PAM Consellation Diagram');
xlabel('cos(wf_{c}t)');
line(xlim,[0 0],'color','k','linewidth',1);
line([0 0],ylim,'color','k','linewidth',1)
text(-3.1,0.2,'00')
text(-1.1,0.2,'01')
text(0.9,0.2,'10')
text(2.9,0.2,'11')
text(-3.1,-0.2,'s_1')
text(-1.1,-0.2,'s_2')
text(0.9,-0.2,'s_3')
text(2.9,-0.2,'s_4')
text(4.5,0.1,'x\Delta')





%% BPSK
delta = sqrt(2);
f_c=5;
t=0:0.001:1-0.001;
s_0=delta*cos(2*pi*f_c*t); % 0
s_1=-delta*cos(2*pi*f_c*t); % 1

subplot(2,1,1);
plot(t,s_0)
title('s_1=0');
xlabel('t');
ylabel('amplitude');
subplot(2,1,2); 
plot(t,s_1)
title('s_2=1');
xlabel('t');
ylabel('amplitude');


t=linspace(0,8-0.001,8000);
signal=[s_1, s_0, s_1, s_1, s_1, s_1, s_0, s_0];
figure(2);
plot(t, signal);
title('BPSK');
xlabel('t');
ylabel('amplitude');

%% BPSK consellation diagram

values=[-1, 1];
plot(real(values),imag(values),'ored','linewidth',3);
xlim([-3 3]);
ylim([-3 3]);
title('BPSK Consellation Diagram');
xlabel('cos(wf_{c}t)');
line(xlim,[0 0],'color','k','linewidth',1);
line([0 0],ylim,'color','k','linewidth',1)

text(-1.02,0.2,'1')
text(0.98,0.2,'0')
text(-1.02,-0.2,'s_2')
text(0.98,-0.2,'s_1')

text(2.2,0.2,'f_1=cos(wf_{c}t)')
text(0.1,2.8,'f_2=sin(wf_{c}t)')



%% QPSK

delta = sqrt(2);
f_c=5;
t=0:0.001:1-0.001;
s_0=delta*cos(2*pi*f_c*t); % 00
s_1=delta*cos(2*pi*f_c*t+pi/2); % 01
s_2=delta*cos(2*pi*f_c*t+pi); % 10
s_3=delta*cos(2*pi*f_c*t+3*pi/2); % 11

subplot(2,2,1);
plot(t,s_0)
title('s_1=00');
xlabel('t');
ylabel('amplitude');
subplot(2,2,2); 
plot(t,s_1)
title('s_2=01');
xlabel('t');
ylabel('amplitude');
subplot(2,2,3); 
plot(t,s_2)
title('s_3=10');
xlabel('t');
ylabel('amplitude');
subplot(2,2,4); 
plot(t,s_3)
title('s_4=11');
xlabel('t');
ylabel('amplitude');

signal=[s_2, s_3, s_3, s_0];
t=linspace(0,4-0.001,4000);
figure(3);
plot(t,signal)
title('QPSK');
xlabel('t');
ylabel('amplitude');

%% QPSK consellation diagram

values=[-1i,1i,-1, 1];
plot(real(values),imag(values),'ored','linewidth',3);
xlim([-3 3]);
ylim([-3 3]);
title('QPSK Consellation Diagram');
xlabel('cos(wf_{c}t)');
line(xlim,[0 0],'color','k','linewidth',3);
line([0 0],ylim,'color','k','linewidth',3)

text(0.95,0.2,'00')
text(0.1,1,'01')
text(-1.05,0.2,'10')
text(0.1,-1,'11')
text(0.98,-0.2,'s_1')
text(-0.2,1,'s_2')
text(-1.02,-0.2,'s_3')
text(-0.2,-1,'s_4')


text(2.2,0.2,'f_1=cos(wf_{c}t)')
text(0.1,2.8,'f_2=sin(wf_{c}t)')
grid on;

%% BFSK

delta = sqrt(2);
f_c=5;
t=0:0.001:1-0.001;
s_0=delta*cos(2*pi*f_c*t); % 0
s_1=delta*cos(2*pi*(f_c+f_c)*t); % 1

subplot(2,1,1);
plot(t,s_0)
title('s_1=0');
xlabel('t');
ylabel('amplitude');
subplot(2,1,2); 
plot(t,s_1)
title('s_2=1');
xlabel('t');
ylabel('amplitude');


signal=[s_1, s_0, s_1, s_1, s_1, s_1, s_0, s_0];
t=linspace(0,8-0.001,8000);
figure(4);
plot(t,signal)
title('BFSK');
xlabel('t');
ylabel('amplitude');

%% BFSK consellation diagram


values=[1i, 1];
plot(real(values),imag(values),'ored','linewidth',3);
xlim([-3 3]);
ylim([-3 3]);
title('BFSK Consellation Diagram');
xlabel('cos(wf_{c}t)');
line(xlim,[0 0],'color','k','linewidth',3);
line([0 0],ylim,'color','k','linewidth',3);

text(-0.2,1,'1')
text(0.98,0.2,'0')
text(1,-0.2,'s_2')
text(0.1,1,'s_1')

text(2.2,0.2,'f_1=cos(wf_{c}t)')
text(0.1,2.8,'f_2=cos(w2f_{c}t)')
grid on


%% 16-QAM

delta=sqrt(1/5);
f_c=5;
t=0:0.001:1-0.001;

s_1_1=-3*delta*cos(2*pi*f_c*t)+3*delta*sin(2*pi*f_c*t); % 0000
s_1_2=-3*delta*cos(2*pi*f_c*t)+1*delta*sin(2*pi*f_c*t); % 0001
s_1_3=-3*delta*cos(2*pi*f_c*t)-1*delta*sin(2*pi*f_c*t); % 0010
s_1_4=-3*delta*cos(2*pi*f_c*t)-3*delta*sin(2*pi*f_c*t); % 0011

s_2_1=-delta*cos(2*pi*f_c*t)+3*delta*sin(2*pi*f_c*t); % 0100
s_2_2=-delta*cos(2*pi*f_c*t)+1*delta*sin(2*pi*f_c*t); % 0101
s_2_3=-delta*cos(2*pi*f_c*t)-1*delta*sin(2*pi*f_c*t); % 0110
s_2_4=-delta*cos(2*pi*f_c*t)-3*delta*sin(2*pi*f_c*t); % 0111

s_3_1=delta*cos(2*pi*f_c*t)+3*delta*sin(2*pi*f_c*t); % 1000
s_3_2=delta*cos(2*pi*f_c*t)+1*delta*sin(2*pi*f_c*t); % 1001
s_3_3=delta*cos(2*pi*f_c*t)-1*delta*sin(2*pi*f_c*t); % 1010
s_3_4=delta*cos(2*pi*f_c*t)-3*delta*sin(2*pi*f_c*t); % 1011

s_4_1=3*delta*cos(2*pi*f_c*t)+3*delta*sin(2*pi*f_c*t); % 1100
s_4_2=3*delta*cos(2*pi*f_c*t)+1*delta*sin(2*pi*f_c*t); % 1101
s_4_3=3*delta*cos(2*pi*f_c*t)-1*delta*sin(2*pi*f_c*t); % 1110
s_4_4=3*delta*cos(2*pi*f_c*t)-3*delta*sin(2*pi*f_c*t); % 1111



%16qam symbols

subplot(4,4,1);
plot(t,s_1_1)
title('s_1=0000');
xlabel('t');
ylabel('amplitude');
subplot(4,4,2); 
plot(t,s_1_2)
title('s_2=0001');
xlabel('t');
ylabel('amplitude');
subplot(4,4,3); 
plot(t,s_1_3)
title('s_3=0010');
xlabel('t');
ylabel('amplitude');
subplot(4,4,4); 
plot(t,s_1_4)
title('s_4=0011');
xlabel('t');
ylabel('amplitude');

subplot(4,4,5);
plot(t,s_2_1)
title('s_5=0100');
xlabel('t');
ylabel('amplitude');
subplot(4,4,6); 
plot(t,s_2_2)
title('s_6=0101');
xlabel('t');
ylabel('amplitude');
subplot(4,4,7); 
plot(t,s_2_3)
title('s_7=0110');
xlabel('t');
ylabel('amplitude');
subplot(4,4,8); 
plot(t,s_2_4)
title('s_8=0111');
xlabel('t');
ylabel('amplitude');

subplot(4,4,9);
plot(t,s_3_1)
title('s_9=1000');
xlabel('t');
ylabel('amplitude');
subplot(4,4,10); 
plot(t,s_3_2)
title('s_{10}=1001');
xlabel('t');
ylabel('amplitude');
subplot(4,4,11); 
plot(t,s_3_3)
title('s_{11}=1010');
xlabel('t');
ylabel('amplitude');
subplot(4,4,12); 
plot(t,s_3_4)
title('s_{12}=1011');
xlabel('t');
ylabel('amplitude');

subplot(4,4,13);
plot(t,s_4_1)
title('s_{13}=1100');
xlabel('t');
ylabel('amplitude');
subplot(4,4,14); 
plot(t,s_4_2)
title('s_{14}=1101');
xlabel('t');
ylabel('amplitude');
subplot(4,4,15); 
plot(t,s_4_3)
title('s_{15}=1110');
xlabel('t');
ylabel('amplitude');
subplot(4,4,16); 
plot(t,s_4_4)
title('s_{16}=1111');
xlabel('t');
ylabel('amplitude');




%16qam symbols





signal=[s_3_4, s_4_1];
figure();
t=linspace(0,2-0.001,2000);
plot(t,signal)
title('16-QAM')

%% 16-Constellation

M = 16;                         % Modulation order
x = (0:15)';                    % Integer input
y1 = qammod(x,16,'bin');        % 16-QAM output

scatterplot(y1)
text(real(y1)+0.1, imag(y1), dec2bin(x))
title('16-QAM, Constellation')
axis([-4 4 -4 4])
%set(gca,'XTickLabel',[-4 -3 -2 -1 0 1 2 3 4])
yticks(-5:5)
xticks(-5:5)
ylabel('sin(2\Pif_ct)')
xlabel('cos2\Pif_ct')
grid on;
line(xlim,[0 0],'color','k','linewidth',3);
line([0 0],ylim,'color','k','linewidth',3);




%%


