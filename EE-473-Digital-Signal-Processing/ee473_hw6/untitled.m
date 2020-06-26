clear all;

%3
w_pass = 0.4;     w_stop = 0.6;
order = 10;       W = [1, 5];
extrema = [[0:w_pass/((order-1)/2):w_pass], ...
    w_pass, [w_stop:(1-w_stop)/((order-1)/2):1] 1];
levels = zeros(1, order+2);
levels(1:floor((order+2)*w_pass)) = 1;
[parks_mc, err] = firpm(order, [0 w_pass w_stop 1], [1 1 0 0], W);
[H_parks_mc,w] = freqz(parks_mc,1,512);
figure(1);     plot(w/pi, abs(H_parks_mc)); grid on;
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Magnitude';
figure(2);     plot(w/pi, angle(H_parks_mc)); grid on;
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Phase';

%4
kaiser_window = kaiserord([200 300],[1 0],[0.05 0.01],1000,'cell');
kaiser = fir1(kaiser_window{:});
[H_kaiser,w_k]=freqz(kaiser,1);
figure(3);     plot(w_k/pi,abs(H_kaiser)); grid on;
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Magnitude';
figure(4);     plot(w_k/pi,angle(H_kaiser)); grid on;
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Phase';