%% Kaiser
close all;
clear all;
clc;
%%
%%%%%%%%% INITIALIZATION %%%%%%%%%
dP = 0.05; % passband tolerance
dS = 0.01; % stopband tolerance
wP = 0.4*pi; % passband
wC = 0.5*pi; % cut-off
wS = 0.6*pi; % stopband
A = -20*log10(dS); % amplitude
if A  < 21 % calculate the beta
    B = 0;
else if A < 50
        B = .5842 * (A - 21)^.4 + .07886*(A-21);
    else
        B = .1102*(A-8.7);
    end
end
M = ceil((A - 8) / (2.285* (wS-wP))); % order calculation
w = kaiser(M+1,B); % kaiser window
w = w';
n= 0:M;
h = 0.5*sinc(0.5*(n-M/2)).*w; % find impulse response
[H,omega]=freqz(h,1,4096); % find frequency response
% plot the H
f = figure(); freqz(h); title('Magnitude and Phase of H in dB');

% Save the plot
%saveas(f,'q2_1.jpg');

% Plot the stopband and passband intervals
f = figure();
subplot(2,1,1); plot(omega/pi,abs(H)); title('Passband'); 
xlabel('Frequency'); ylabel('Amplitude'); grid on; xlim([0 0.4]);
subplot(2,1,2); plot(omega/pi,abs(H)); title('Stopband'); 
xlabel('Frequency'); ylabel('Amplitude'); grid on; xlim([0.6 1]);

% Save the plot
%saveas(f,'q2_2.jpg');
% save the data
save kaiser.mat h;