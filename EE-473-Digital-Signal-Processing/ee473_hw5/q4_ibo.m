%% part a and b
[bc,ac]=df2cf(b,a);
[x,~]=size(bc);
hc=[1 zeros(1,4095)];

for i=1:x
    hc=filter(bc(i,:),ac(i,:),hc);    
end

subplot(2,1,1);stem(hc(1:200));
xlabel('n');ylabel('h[n]');title('Impulse Response cascaded(by stem)');
subplot(2,1,2);plot(hc(1:200));
xlabel('n');ylabel('h[n]');title('Impulse Response cascaded(by plot)');

dirac_delta=[1 zeros(1,4095)];
h=filter(b,a,dirac_delta);
max(hc-h)
%% part c
[x,y]=size(bc);
acq16=zeros(x,y);
bcq16=zeros(x,y);
for i=1:x
    N=16;
    M=max(abs([ac(i,:) bc(i,:)]));
    acq16(i,:)=quant(ac(i,:),N,M);
    bcq16(i,:)=quant(bc(i,:),N,M);   
end
hc16=[1 zeros(1,4095)];
for i=1:x
    hc16=filter(bcq16(i,:),acq16(i,:),hc16);    
end
plot(hc16(1:200));
xlabel('n');ylabel('h[n]');title('Impulse Response of H-16bit quantized and cascaded(by plot)');

%% part d

figure();
[H16,w16] = freqz(hc16,1,4096);

subplot(2,1,1);plot(w/pi,20*log10(abs(H16)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response H-16bit quantized and cascaded');
axis([0 1 -80 10]);
subplot(2,1,2);plot(w/pi,20*log10(abs(H16)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response H-16bit quantized and cascaded');
axis([.41 .47 -.25 0]);
%%
dpzplot(bcq16(1,:),acq16(1,:));
title('Pole-Zero for Block-1')
figure();
dpzplot(bcq16(2,:),acq16(2,:));
title('Pole-Zero for Block-2')
figure();
dpzplot(bcq16(3,:),acq16(3,:));
title('Pole-Zero for Block-3')
figure();
dpzplot(bcq16(4,:),acq16(4,:));
title('Pole-Zero for Block-4')


%% part e$$
%% 
[x,y]=size(bc);
acq12=zeros(x,y);
bcq12=zeros(x,y);
for i=1:x
    N=12;
    M=max(abs([ac(i,:) bc(i,:)]));
    acq12(i,:)=quant(ac(i,:),N,M);
    bcq12(i,:)=quant(bc(i,:),N,M);   
end
hc12=[1 zeros(1,4095)];
for i=1:x
    hc12=filter(bcq12(i,:),acq12(i,:),hc12);    
end
plot(hc12(1:200));
xlabel('n');ylabel('h[n]');title('Impulse Response of H-12bit quantized and cascaded(by plot)');

%%

figure();
[H12,w12] = freqz(hc12,1,4096);

subplot(2,1,1);plot(w/pi,20*log10(abs(H12)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response H-12bit quantized and cascaded');
axis([0 1 -80 10]);
subplot(2,1,2);plot(w/pi,20*log10(abs(H12)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response H-12bit quantized and cascaded');
axis([.41 .47 -.30 0.05]);
%%
dpzplot(bcq12(1,:),acq12(1,:));
title('Pole-Zero for Block-1')
figure();
dpzplot(bcq12(2,:),acq12(2,:));
title('Pole-Zero for Block-2')
figure();
dpzplot(bcq12(3,:),acq12(3,:));
title('Pole-Zero for Block-3')
figure();
dpzplot(bcq12(4,:),acq12(4,:));
title('Pole-Zero for Block-4')









