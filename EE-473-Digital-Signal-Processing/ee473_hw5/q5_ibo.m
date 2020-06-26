%% part a
[b,a] = ellip(4,.2,40,[.41 .47]);
h=filter(b,a,[1 zeros(1,4095)]);
[r,p,k]=residue(fliplr(b),fliplr(a));
bp=zeros(4,3);
ap=zeros(4,3);
for m=1:4
    if m==1
        [bp(m,:),ap(m,:)]=residue(r(2*m-1:2*m),p(2*m-1:2*m),k);
    else
        [bp(m,2:3),ap(m,1:3)]=residue(r(2*m-1:2*m),p(2*m-1:2*m),0);
    end
    ap(m,:)=fliplr(ap(m,:));
    coff=ap(m,1);
    ap(m,:)=ap(m,:)./coff;
    bp(m,:)=fliplr(bp(m,:));
    bp(m,:)=bp(m,:)./coff;
    bp=real(bp);
    
end
%% part b
hp=zeros(1,4096);
for i=1:4
    hp=hp+filter(bp(i,:),ap(i,:),[1 zeros(1,4095)]);

end

plot(hp(1:200))
xlabel('n');ylabel('hp[n]');title('Impulse Response of hp[n]');
max(h-hp)
%% part c

[x,y]=size(bp);
apq16=zeros(x,y);
bpq16=zeros(x,y);
r16=zeros(4,2);
p16=zeros(4,2);
k16=[];
for i=1:4
    N=16;
    M=max(abs([ap(i,:) bp(i,:)]));
    apq16(i,:)=quant(ap(i,:),N,M);
    bpq16(i,:)=quant(bp(i,:),N,M);  
    [r16(i,1:2),p16(i,1:2),temp]=residue(fliplr(bpq16(i,:)),fliplr(apq16(i,:)));
    k16=[k16 temp];
end

[bp16_temp, ap16_temp]=residue(r16(:),p16(:),k16);

bp16_temp=fliplr(bp16_temp)./ap16_temp(end);
ap16_temp=fliplr(ap16_temp)./ap16_temp(end);

bp16=real(bp16_temp);
ap16=real(ap16_temp);

%% part d

hp16=zeros(1,4096);
for i=1:4
    hp16=hp16+filter(bpq16(i,:),apq16(i,:),[1 zeros(1,4095)]);

end

plot(hp16(1:200))
xlabel('n');ylabel('quantizied paralel form of h[n]');title('Impulse Response of h with 16bit quantized and paralelled');

%%

hp16=[1 zeros(1,4095)];
hp16=filter(bp16,ap16,hp16);
[H16,w]=freqz(hp16,1,4096);
%%
subplot(2,1,1);plot(w/pi,20*log10(abs(H16)));
axis([0 1 -80 10]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response with freqz');

subplot(2,1,2);plot(w/pi,20*log10(abs(H16)));
axis([.41 .47 -.2 0]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response on bandpass');
%%
freqz(bp16,ap16,4096);
title('Frequency Response with freqz(bp16,ap16,4096)')
%%
figure();
plot(w/pi,20*log10(abs(H16)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response of quantized paralel system');
axis([0 1 -80 10]);

%% part e
dpzplot(bp16,ap16)
%dpzplot(bcq12(3,:),acq12(3,:));
title('Pole-Zero for ap16-bp16')

%% part f
%% part f-c

[x,y]=size(bp);
apq12=zeros(x,y);
bpq12=zeros(x,y);
r12=zeros(4,2);
p12=zeros(4,2);
k12=[];
for i=1:4
    N=12;
    M=max(abs([ap(i,:) bp(i,:)]));
    apq12(i,:)=quant(ap(i,:),N,M);
    bpq12(i,:)=quant(bp(i,:),N,M);  
    [r12(i,1:2),p12(i,1:2),temp]=residue(fliplr(bpq12(i,:)),fliplr(apq12(i,:)));
    k12=[k12 temp];
end

[bp12_temp, ap12_temp]=residue(r12(:),p12(:),k12);

bp12_temp=fliplr(bp12_temp)./ap12_temp(end);
ap12_temp=fliplr(ap12_temp)./ap12_temp(end);

bp12=real(bp12_temp);
ap12=real(ap12_temp);

%% part f-d
hp12=zeros(1,4096);
for i=1:4
    hp12=hp12+filter(bpq12(i,:),apq12(i,:),[1 zeros(1,4095)]);

end

plot(hp12(1:200))
xlabel('n');ylabel('quantizied paralel form of h[n]');title('Impulse Response of h with 12bit quantized and paralelled');


%%
hp12=[1 zeros(1,4095)];
hp12=filter(bp12,ap12,hp12);
[H12,w]=freqz(hp12,1,4096);
%%
subplot(2,1,1);plot(w/pi,20*log10(abs(H12)));
axis([0 1 -80 10]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response with freqz() parallel and 12bit');

subplot(2,1,2);plot(w/pi,20*log10(abs(H12)));
axis([.41 .47 -.25 0.2]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response on bandpass');



%%
freqz(bp12,ap12,4096);
title('Frequency Response with freqz(bp12,ap12,4096)')
%%
figure();
plot(w/pi,20*log10(abs(H12)));
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response of quantized paralel system');
axis([0 1 -80 10]);

%% part e
dpzplot(bp12,ap12)
%dpzplot(bcq12(3,:),acq12(3,:));
title('Pole-Zero for ap12-bp12')








