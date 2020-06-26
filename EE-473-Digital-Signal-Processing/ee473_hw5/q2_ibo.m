%% part a
[b,a] = ellip(4,.2,40,[.41 .47]);
[H,w] = freqz(b,a,4096);
plot(w/pi,20*log10(abs(H)));
axis([0 1 -80 10]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response');
%% part b
plot(w/pi,20*log10(abs(H)));
axis([.41 .47 -.2 0]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response of the Passband Part');
%%
[H,w] = freqz(b*10^(0.005),a,4096);
figure();
subplot(2,1,1);plot(w/pi,20*log10(abs(H)));
axis([0 1 -80 10]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Magnitude Response');
subplot(2,1,2);plot(w/pi,20*log10(abs(H)));
axis([.41 .47 -.1 .1]);
xlabel('w(\cdot \pi)');ylabel('|H| db');title('Oscillate about 1');
%% part c
n=1:200;
dirac_delta=[1 zeros(1,4095)];
h=filter(b,a,dirac_delta);
subplot(2,1,1);stem(n,h(1:length(n)));
xlabel('n');ylabel('h[n]');title('Impulse Response(by stem)');
subplot(2,1,2);plot(n,h(1:length(n)));
xlabel('n');ylabel('h[n]');title('Impulse Response(by plot)');

