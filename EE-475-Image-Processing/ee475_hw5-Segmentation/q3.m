clear;close all;clc;
dim=256;
diamond_0=64*ones(dim,dim);
center=128;
dist_1=round(64/sqrt(2));
dist_2=round(128/sqrt(2));

% diamond
for i=1:dim
    for j=1:dim
        if abs(i-center)+abs(j-center)<=dist_2
            diamond_0(i,j)=128;            
        end 
        if abs(i-center)+abs(j-center)<=dist_1
            diamond_0(i,j)=192;            
        end     
    end
end
% grt
grt=zeros(dim,dim);
for i=1:dim
    for j=1:dim
        if abs(i-center)+abs(j-center)==dist_1
            grt(i,j)=255;            
        end 
        if abs(i-center)+abs(j-center)==dist_2
            grt(i,j)=255;            
        end     
    end
end
% figure();
% imshow(uint8(diamond_0))
% 
% figure();
% imshow(grt)
% 
diamond_0_noisy=diamond_0+sqrt(484)*randn(dim);
% 
% figure();
% imshow(uint8(diamond_0_noisy))

%%
% diamond_0_binarize = imbinarize(diamond_0);    % binarize ground truth
% imshow(uint8(diamond_0),[])
% noise eklemeye geldim

% edge detection algorithms testing for normal image
j_sobel = edge(diamond_0,'sobel');
j_log = log_function(diamond_0,0,13);
j_canny = edge(diamond_0,'canny');



% edge detection algorithms testing for noisy image
j_sobel_noisy = edge(diamond_0_noisy,'sobel');
j_log_noisy = log_function(diamond_0_noisy,0,13);
j_canny_noisy = edge(diamond_0_noisy,'canny',0.9);

% figure();
% imshow(uint8(255-j_sobel),[]);
% figure();
% imshow(uint8(255-j_sobel_noisy),[]);
%%
figure();
imshow(uint8(255-j_log),[]);
figure();
imshow(uint8(255-j_log_noisy),[]);
%%
figure();
imshow(uint8(255-j_canny),[]);
figure();
imshow(uint8(255-j_canny_noisy),[]);

%%

%%
grt=grt>0;
% Find performances of different algorithms
perf_sobel = edge_performance(j_sobel,grt);
perf_log = edge_performance(j_log,grt);
perf_canny = edge_performance(j_canny,grt);

% Find performances of different algorithms for noisy
perf_sobel_noisy = edge_performance(j_sobel_noisy,grt);
perf_log_noisy = edge_performance(j_log_noisy,grt);
perf_canny_noisy = edge_performance(j_canny_noisy,grt);



% function for 
function ep = edge_performance(matrix_test,my_grt)    
    [my_grt_x,my_grt_y] = find(my_grt==1);
    N_of_my_grt = numel(my_grt_x);
    ep = 0;
    [m,n] = size(matrix_test);
    for i = 1:N_of_my_grt
        delta = matrix_test(my_grt_x(i), my_grt_y(i));
        if delta
            ep = ep + delta;
        else
            close_edge = sum(matrix_test(max(1,my_grt_x(i)-2):min(m,my_grt_x(i)+2), max(1,my_grt_y(i)-2):min(n,my_grt_y(i)+2))); % check if close prediction exits
            if close_edge
                ep = ep + 0.5;
            end
        end
    end
    ep = ep/N_of_my_grt;
end

