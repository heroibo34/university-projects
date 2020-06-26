clear;clc;close all;
channel=[0.74 -0.514 0.37 0.216 0.062];
m=length(channel)-1;

snr_db=0:2:20;
SNR=10.^(snr_db/10);
num_of_bit=10^4;
nEN=5;


sending_data=sign(randn(1,num_of_bit));% x is sending data
sending_bit=(sending_data+1)/2;

cost_value_matrix=zeros(2^(length(channel)-1),num_of_bit+1);
cost_where_matrix=zeros(2^(length(channel)-1),num_of_bit+1);

cost_value_matrix(:,1)=inf*ones(2^(length(channel)-1),1);cost_value_matrix(1,1)=0;

error_matrix=zeros(1,length(snr_db));

%% initializing
temp_even_number=zeros(2^m,1);
temp_odd_number=zeros(2^m,1);
temp_even_binary=zeros(2^m,5);
temp_odd_binary=zeros(2^m,5);
z_even=zeros(2^m,1);
z_odd=zeros(2^m,1);

for i=1:2^m
    temp_even_number(i)=mod((i-1)*2,32);
    temp_odd_number(i)=mod((i-1)*2+1,32);
    temp_even_binary(i,:)=de2bi(temp_even_number(i),5,'left-msb');
    temp_odd_binary(i,:)=de2bi(temp_odd_number(i),5,'left-msb');
    z_even(i)=sum((2*temp_even_binary(i,:)-1).*channel);
    z_odd(i)=sum((2*temp_odd_binary(i,:)-1).*channel);
end
%% initializing end

number_of_frame=5;
for frame=1:number_of_frame
    frame
    for nEN=1:length(snr_db)
        
        noise=1/SNR(nEN);sigma=sqrt(noise);
        temp_y=conv(sending_data,channel);
        received_data=temp_y(1:num_of_bit)+sigma*randn(1,num_of_bit); % channel+noise

        for state=2:num_of_bit+1


            for i=1:2^m

                from=[mod(2*(i-1),16)+1,mod(2*(i-1),16)+2]; % from even,from odd

                from_even_path=cost_value_matrix(from(1),state-1)+(received_data(state-1)-z_even(i))^2;
                from_odd_path=cost_value_matrix(from(2),state-1)+(received_data(state-1)-z_odd(i))^2;

                [val, indice]=min([from_even_path, from_odd_path]);
                cost_value_matrix(i,state)=val;
                cost_where_matrix(i,state)=from(indice);

            end

        end

        %%

        %% coming back
        detected_data=zeros(1,num_of_bit);

        [~,min_indice]=min(cost_value_matrix(:,end));
        detected_data(end)=min_indice>8;

        next_step=cost_where_matrix(min_indice,end);

        for i=num_of_bit:-1:2
            detected_data(i-1)=next_step>8;
            next_step=cost_where_matrix(next_step,i);
        end
        number_of_true=sum(sending_bit==detected_data);
        error_matrix(nEN)=error_matrix(nEN)+1-(number_of_true/num_of_bit);

    end
end 
error_matrix=error_matrix/number_of_frame;
%%
save error_matrix.mat error_matrix

%% plots
snr_db=0:2:20;
semilogy(snr_db,error_matrix,'k-x','DisplayName','Viterbi');
legend;
axis on;
set(gca,'FontSize',14)




