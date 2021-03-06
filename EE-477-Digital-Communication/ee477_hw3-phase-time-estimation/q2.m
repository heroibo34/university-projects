clear;clc;close all;
snr=0:2:20;
N=[1,5,10,20];
en = 10.^(snr/10); %db to normal
sigma = 1./sqrt(en);

g=rcosdesign(0.5,80,20);
%g=g/max(g);
l=4*rcosdesign(0.5,40,40);
error_table=zeros(length(N),length(snr));

for m=1:4
    pilot=zeros(1,length(g));
    center=(length(g)-1)/2+1;
    interval=40;
    for n=1:N(m)
        pilot(center+interval*(n-1))=1;
    end
    my_start_phase=exp(1i*(pi/4));
    z_k=my_start_phase*pilot;
    sending_signal=conv(g,z_k);
    
    
    
    
    for l=1:length(snr)
        phase_error=0;
        tau_error=0;
        number_of_loop=500;
        for t=1:number_of_loop
        signal_receiving=sending_signal+(1/sqrt(2))*sigma(l)*randn(1,length(sending_signal))...
                        +1i*sigma(l)*(1/sqrt(2))*randn(1,length(sending_signal));
        
        y_k_tau=zeros(1,40);
        shift=interval/4;            
        center_g=(length(g)+1)/2;          
        running_g=g(center_g-interval/2:center_g+interval/2); % interval+1
         
        tau_cont=[]; 
        
             for jj=1:41
                 y_k_t=[];

                 for ii=1:N(m)
                    received_center=(length(signal_receiving)+1)/2+shift;
                    part_received=signal_receiving((ii-1)*interval+received_center-interval/2:(ii-1)*interval+received_center+interval/2);
                    y_k_tau=sum(running_g.*circshift(part_received,jj));
                    
                    y_k_t=[y_k_t y_k_tau];
                 end 
                 phase=exp(1j*pi/4);
                 z_k=phase*(ones(1,N(m)));
                 tau_control=real(sum(y_k_t.*conj(z_k)));
                 tau_cont=[tau_cont tau_control];
            end
            [~,tau_est]=max(tau_cont);
            tau_er_est=tau_est-interval/4;
            tau_error=tau_error+abs(tau_er_est);
        end  
         error_table(m,l)=(tau_error*1e-5)/(number_of_loop*interval);
    end
    

end

%%

save error_table.mat error_table
%%
snr=0:2:20;



plot(snr,abs(error_table(1,:)),'DisplayName','N=1')
hold on;
plot(snr,abs(error_table(2,:)),'DisplayName','N=5')
hold on;

plot(snr,abs(error_table(3,:)),'DisplayName','N=10')
hold on;

plot(snr,abs(error_table(4,:)),'DisplayName','N=20')
hold on;
legend;
title('time error');
xlabel('snr(db)');
ylabel('estimated time error(\mus)')




 