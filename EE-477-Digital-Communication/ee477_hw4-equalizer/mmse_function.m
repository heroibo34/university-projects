function coeff=mmse_function(h,tap,snr_db)
%%
en=10.^(snr_db/10);
M=length(h)-1;
M=M/2;
N=(tap-1)/2;
H=zeros(tap,tap+length(h)-1);
%%
row_temp=[h zeros(1,tap-1)];
H(1,:)=row_temp;
for i=2:tap
    H(i,:)=circshift(row_temp,i-1); 
end
%%
e=[zeros(1,N+M) 1 zeros(1,N+M)]';
v=zeros(length(snr_db),tap);
for i=1:length(snr_db)
    [~,temp]=size(H*H');
    
    v(i,:)=(inv(H*H'+eye(temp)./en(i))*H)*e;
end
coeff=v;


end

