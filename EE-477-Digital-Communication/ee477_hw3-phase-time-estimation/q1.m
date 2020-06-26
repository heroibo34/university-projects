clear;clc;close all;
snr=0:2:20;
N=[1,5,10,20];
en = 10.^(snr/10); %db to normal
sigma = 1./sqrt(en);

g=rcosdesign(0.5,80,20);
%g=g/max(g);
l=4*rcosdesign(0.5,40,40);
error_table_11=zeros(length(N),length(snr));

for m=1:4
    pilot=zeros(1,length(g));
    interval=40;
    center=(length(g)-1)/2+1;
    
    for n=1:N(m)
        pilot(center+interval*(n-1))=1;
    end
    my_start_phase=exp(1i*(pi/4));
    z_k=my_start_phase*pilot;
    sending_signal=conv(g,z_k);

    for l=1:length(snr)
        phase_error=0;
        number_of_loop=200;
        for t=1:number_of_loop
        received_signal=sending_signal+(1/sqrt(2))*sigma(l)*randn(1,length(sending_signal))...
                        +1i*sigma(l)*(1/sqrt(2))*randn(1,length(sending_signal));
        
                    
        merkez=(length(g)+1)/2  ;          
        running_g=g(merkez-interval/2:merkez+interval/2); 
        
        for ii=1:N(m)
            received_center=(length(received_signal)+1)/2;
            received_part=received_signal((ii-1)*interval+received_center-interval/2:(ii-1)*interval+received_center+interval/2);
            y_k(ii)=sum(running_g.*received_part);
        end
        phase=exp(1i*pi/4);
        z_k=phase*(ones(1,N(m)));  
        
        test_factor=sum(conj(z_k).*y_k);
        phase_estimated=-atan(imag(test_factor)/real(test_factor));
        phase_error=phase_error+abs(phase_estimated);  
                    

        end  
         error_table_11(m,l)=phase_error/number_of_loop;
    end
    

end
save error_table_11.mat error_table_11
coeff=360/2/pi;
plot(snr,coeff*abs(error_table_11(1,:)),'DisplayName','N=1')
hold on;
plot(snr,coeff*abs(error_table_11(2,:)),'DisplayName','N=5')
hold on;

plot(snr,coeff*abs(error_table_11(3,:)),'DisplayName','N=10')
hold on;

plot(snr,coeff*abs(error_table_11(4,:)),'DisplayName','N=20')
hold on;
legend;

title('phase error');
xlabel('snr(db)');
ylabel('estimated phase error(degree)')

% plot(my_signal)
% figure();
% plot(abs(received_signal))
% figure();
% plot(abs(temp))






