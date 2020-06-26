freqs=1000;
range=20;
sample_rate=8800:5:9200;
for i=1:length(sample_rate)
my_filter=designfilt('bandpassfir','FilterOrder',150, ...
                    'CutoffFrequency1',freqs-f_range, ...
                    'CutoffFrequency2',freqs+f_range, ...
                    'SampleRate',sample_rate(i));               
out=filter(my_filter,data);
temp(i)=sum(out.^2)
end

[x,y]=max(temp);
sampling_rate=8800+5*(y-1);