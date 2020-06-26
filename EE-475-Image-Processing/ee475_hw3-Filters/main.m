%% QUESTION-1

matrix=imread('circuitboard.jpg');
matrix=matrix(:,:,1); % because all dimensions are the same
matrix=double(matrix);
% imshow(matrix,'InitialMagnification', 'fit')
[a, b]=size(matrix);

matrix_noised = double(matrix)+randn(a,b)*sqrt(1024); % ads gaussian noise
matrix_noised=uint8(matrix_noised);
figure;
imshow(matrix_noised,'InitialMagnification', 'fit')
imwrite(matrix_noised,'xx_noised_circuit.png')
%% extended_matrix

extended_matrix=zeros(a+6,b+6);

extended_matrix(4:(a+3),4:(b+3))=matrix_noised(1:a,1:b);

extended_matrix(3,:)=extended_matrix(4,:); 
extended_matrix(2,:)=extended_matrix(5,:);
extended_matrix(1,:)=extended_matrix(6,:);

extended_matrix((a+4),:)=extended_matrix((a+3),:);
extended_matrix((a+5),:)=extended_matrix((a+2),:);
extended_matrix((a+6),:)=extended_matrix((a+1),:);

extended_matrix(:,3)=extended_matrix(:,4);
extended_matrix(:,2)=extended_matrix(:,5);
extended_matrix(:,1)=extended_matrix(:,6);

extended_matrix(:,(a+4))=extended_matrix(:,(a+3));
extended_matrix(:,(a+5))=extended_matrix(:,(a+2));
extended_matrix(:,(a+6))=extended_matrix(:,(a+1));

% figure();
% imshow(uint8(extended_matrix),'InitialMagnification', 'fit');

%% arithematic linear filter

arit_matrix=zeros(a,b);

for i=1:1:a
    for ii=1:1:b
        temp_matrix=extended_matrix((i):(i+6),(ii):(ii+6));
        
        arit_matrix(i,ii)=sum(sum(temp_matrix))/49;
     
    end
end
%%
aa=1000000;
for i=6:1:a-20
    for ii=6:1:b-20
        temp_matrix=extended_matrix((i+3):(i+12),(ii+3):(ii+12));
        
        temp=var(temp_matrix(:));
        
        if temp<aa
           
           aa=temp; 
        end
        
        %arit_matrix(i,ii)=sum(sum(temp_matrix))/49;
     
    end
end

figure();
imshow(uint8(arit_matrix),'InitialMagnification', 'fit');
imwrite(uint8(arit_matrix),'xx_arithematic_circuit.png')

%% geometric linear filter

geo_matrix=zeros(a,b);

for i=1:1:a
    for ii=1:1:b
        temp_matrix=extended_matrix((i):(i+6),(ii):(ii+6));
        
        geo_matrix(i,ii)=nthroot(prod(prod(temp_matrix)),49);
     
    end
end

% figure();
imshow(uint8(geo_matrix),'InitialMagnification', 'fit');
imwrite(uint8(geo_matrix),'xx_geometric_circuit.png')

%% adaptive linear filter

adap_matrix=zeros(a,b);
var_nn=1024;

for i=1:1:a
    for ii=1:1:b
        temp_matrix=extended_matrix((i):(i+6),(ii):(ii+6));
        
        var_xy=var(temp_matrix(:));
        
        mean_xy=sum(sum(temp_matrix))/49;
        value=extended_matrix(i+3,ii+3);
        constant=var_nn/var_xy;
        if var_nn>var_xy
            
            
            adap_matrix(i,ii)=mean_xy;
            
        else
            constant=1;
            adap_matrix(i,ii)=value-constant*(value-mean_xy);
            
        end
        
            
    end
end

figure();
imshow(uint8(adap_matrix),'InitialMagnification', 'fit');
imwrite(uint8(adap_matrix),'xx_adaptive_circuit.png')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% QUESTION-2

matrix=imread('pentagon.jpg');
matrix=matrix(:,:,1); % because all dimensions are the same

[a,b]=size(matrix);

matrix_noised=imnoise(matrix,'salt & pepper',0.5);
imshow(uint8(matrix_noised),'InitialMagnification', 'fit');
imwrite(uint8(matrix_noised),'xx_noised_pentagon.png')

%% extended_matrix

extended_matrix=zeros(a+6,b+6);

extended_matrix(4:(a+3),4:(b+3))=matrix_noised(1:a,1:b);

extended_matrix(3,:)=extended_matrix(4,:); 
extended_matrix(2,:)=extended_matrix(5,:);
extended_matrix(1,:)=extended_matrix(6,:);
extended_matrix((a+4),:)=extended_matrix((a+3),:);
extended_matrix((a+5),:)=extended_matrix((a+2),:);
extended_matrix((a+6),:)=extended_matrix((a+1),:);

extended_matrix(:,3)=extended_matrix(:,4);
extended_matrix(:,2)=extended_matrix(:,5);
extended_matrix(:,1)=extended_matrix(:,6);
extended_matrix(:,(a+4))=extended_matrix(:,(a+3));
extended_matrix(:,(a+5))=extended_matrix(:,(a+2));
extended_matrix(:,(a+6))=extended_matrix(:,(a+1));


%% median filter

median_matrix=zeros(a,b);

for i=1:1:a
    for ii=1:1:b
        temp_matrix=extended_matrix((i):(i+6),(ii):(ii+6));        
        temp_3=sort(temp_matrix(:));
        median_matrix(i,ii)=temp_3(25);
     
    end
end

figure();
imshow(uint8(median_matrix),'InitialMagnification', 'fit');
imwrite(uint8(median_matrix),'xx_normal_median_pentagon.png')

%% adaptive-median filter

adap_median_matrix=zeros(a,b);



for i=1:1:a
    for ii=1:1:b
        dim=3; % dim by dim filter
        while dim<9
            temp_matrix=extended_matrix((i+3-(dim-1)/2):(i+3+(dim-1)/2),(ii+3-(dim-1)/2):(ii+3+(dim-1)/2));        
            temp_3=sort(temp_matrix(:));
            z_min=temp_3(1);
            z_max=temp_3(end);
            z_med=temp_3((end+1)/2);
            
            if z_min<z_med && z_med<z_max
                if z_min<extended_matrix(i+3,ii+3) && extended_matrix(i+3,ii+3)<z_max
                    adap_median_matrix(i,ii)=extended_matrix(i+3,ii+3);                
                else
                    adap_median_matrix(i,ii)=z_med;            
                end
                dim=9;
            end
            dim=dim+2;    
        end
    end
end

figure();
imshow(uint8(adap_median_matrix),'InitialMagnification', 'fit');
imwrite(uint8(adap_median_matrix),'xx_adaptive_median_pentagon.png')



%% QUESTION-3
%%   astronaut image  
% 
matrix_astronaut=imread('astronaut-interference.jpg');
matrix=matrix_astronaut(:,:,1); % because all dimensions are the same

[a,b]=size(matrix);

spectrum=fft2(matrix);
spectrum_1=fftshift(log(1+abs(spectrum)));

% subplot(2,1,1);mesh(log(1+abs(spectrum)));
% title('fft of the image')
% subplot(2,1,2);mesh(abs(spectrum_1))
% title('shifted fft of the image')

spec=spectrum_1>(max(spectrum_1(:))*0.91);


[x_ast,y_ast]=find(spec==1);
values=[x_ast,y_ast];
values(2,:)=[];
% (413,501)
D=zeros(a,b);
d_0=1;
H=ones(a,b);
for i=1:length(x_ast)-1
    
    for u=1:a
        for v=1:b
            D(u,v)=sqrt((u-values(i,1))^2+(v-values(i,2))^2);          
        end
    end
    
    H_temp=1-exp(-D.^2/(2*d_0*d_0));
    H_temp_interference=exp(-D.^2/(2*d_0*d_0));
       
    H=H.*H_temp;
    %H=H.*H_temp_interference; % interference
       
end

figure();
mesh(H);
title('Notch filter for astronaut')

new_spectrum=H.*fftshift(spectrum);



%new_spectrum=new_spectrum-fftshift(spectrum);
mesh(1+log(abs(new_spectrum)))

invere_shifted=ifftshift(new_spectrum);

new_image=ifft2(invere_shifted);
figure();
imshow(uint8(new_image),[],'InitialMagnification', 'fit')



%% Question-3 car image
matrix_car=imread('car-interference.jpg');
%%
matrix=double(matrix_car(:,:,1)); % because all dimensions are the same

[a,b]=size(matrix);

spectrum=fft2(matrix);
spectrum_1=fftshift(log(1+abs(spectrum)));
% figure(1);
% mesh(log(1+abs(spectrum)))
% figure(2);
% mesh(abs(spectrum_1))

% subplot(2,1,1);mesh(log(1+abs(spectrum)));
% title('fft of the image')
% subplot(2,1,2);mesh(abs(spectrum_1))
% title('shifted fft of the image')





spec=spectrum_1>(max(spectrum_1(:))*0.77);
% figure(2);
% imshow(spec,[]);

[x_car,y_car]=find(spec==1);

values=[x_car,y_car];

values(4:(end-3),:)=[]
% values=[values;45,55;112,41;58,207;115,203]
% (85,124)
D=zeros(a,b);
d_0=10;
H=ones(a,b);

for i=1:length(values(:,1))
    
    for u=1:a
        for v=1:b
            D(u,v)=sqrt((u-values(i,1))^2+(v-values(i,2))^2);          
        end
    end
    
    H_temp=1-exp(-D.^2/(2*d_0*d_0));
       
    
    H_temp_interference=exp(-D.^2/(2*d_0*d_0));
       
    H=H.*H_temp;
    %H=H.*H_temp_interference;
    
    
end

% figure();
% mesh(H);
% title('Notch filter for car')


% imshow(abs(H),[])

new_spectrum=H.*fftshift(spectrum);
%new_spectrum=new_spectrum-fftshift(spectrum);

invere_shifted=ifftshift(new_spectrum);
new_image=ifft2(invere_shifted);
figure();
imshow(uint8(abs(new_image)),[],'InitialMagnification', 'fit')

%%








%% QUESTION-4

matrix=imread('Gonzalez_Rose.jpg');

salt_pepper=0.03:0.03:0.3;
dim=3:2:13; % dim by dim filter

ssim_matrix=zeros(length(salt_pepper),length(dim));

for m=1:length(salt_pepper)
    matrix_noised=double(imnoise(matrix,'salt & pepper',salt_pepper(m)));
    for n=1:length(dim)
        med_result_matrix=median_filter(matrix,dim(n),salt_pepper(m));
        
        [ssim_matrix(m,n),~]=ssim(uint8(matrix),uint8(med_result_matrix));
        

        
    end
end

disp(ssim_matrix)
%%

ssim_matrix_1=load('ssim_matrix_1.mat');
ssim_matrix_2=load('ssim_matrix_2.mat');

figure();
x_values = {'3%','6%','9%','12%','15%','18%','21%','24%','27%','30%'};
y_values = {'3x3','5x5','7x7','9x9','11x11','13x13'};
temp=heatmap(x_values,y_values,ssim_matrix_1.ssim_matrix');
temp.Colormap=flipud(jet);

title('After Filter')
%%
figure();
x_values = {'3%','6%','9%','12%','15%','18%','21%','24%','27%','30%'};
y_values = {'3x3','5x5','7x7','9x9','11x11','13x13'};
temp=heatmap(x_values,y_values,ssim_matrix_2.ssim_matrix');
temp.Colormap=flipud(jet);
title('Before Filter')
xlabel('noise values')
ylabel('filters')








