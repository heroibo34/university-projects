%% Filter design
clear;
clc;
freqs=[697,770,852,941,1209,1336,1477,1633]; %frequencies
f_range=15;%bandpass filter range
sample_rate=8930;

for m=1:8%design 8 bandpass filter for each frequencies
    my_filter(m)=designfilt('bandpassfir','FilterOrder',150, ...
                    'CutoffFrequency1',freqs(m)-f_range, ...
                    'CutoffFrequency2',freqs(m)+f_range, ...
                    'SampleRate',sample_rate);       
end
% fvtool(my_filter(1))

%% Arduino Part

priorports=instrfind;  
delete(priorports);   
s = serial('/dev/cu.wchusbserialfa130');   
s.InputBufferSize = 300; 
set(s,'BaudRate', 115200); 
fopen(s); 
button_controller='tekrar'; 

while 1 %

data = fread(s);
[button_value,button_controller]=detection_button(data,my_filter,button_controller);
%detection_button is a function that takes data,filters and print the
%button
end
fclose(s); % serial port'u kapatmak








