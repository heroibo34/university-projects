function coeff=zero_force_function(h,tap)
%%
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
v=(inv(H*H')*H)*e;
coeff=v;


end

