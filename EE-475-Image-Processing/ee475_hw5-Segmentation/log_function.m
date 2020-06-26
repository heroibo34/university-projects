function otptth = log_function(im,threshold,order)

% threshold=8;
im=double(im);
%smoothening the image with a filter
% gfilter= [1 5 7 5 1;
%        5 9 -7 9 5;
%        7 -7 -80 -7 7;
%        5 9 -7 9 5;
%        1 5 7 5 1];
my_h=fspecial('log',order,2);
s_mim=conv2(im,my_h,'same');
% finding the zero crossings
[my_rr,my_cc]=size(s_mim);
my_zc=zeros([my_rr,my_cc]);
for i=2:my_rr-1
    for j=2:my_cc-1
        
            if ((s_mim(i,j+1)>=0 && s_mim(i,j)<0) || (s_mim(i,j+1)<0 && s_mim(i,j)>=0))                             
                my_zc(i,j)= 1;
                        
            elseif ((s_mim(i+1,j)>=0 && s_mim(i,j)<0) || (s_mim(i+1,j)<0 && s_mim(i,j)>=0))                             
                my_zc(i,j)= 1;
            elseif ((s_mim(i+1,j+1)>=0 && s_mim(i,j)<0) || (s_mim(i+1,j+1)<0 && s_mim(i,j)>=0))                             
                my_zc(i,j)= 1;
            elseif ((s_mim(i+1,j)>=0 && s_mim(i,j+1)<0) || (s_mim(i+1,j)<0 && s_mim(i,j+1)>=0))
                my_zc(i,j)= 1;
            end

            
    end
end



gradient_filter = [ -1,-1,-1;-1,8,-1;-1,-1,-1];

gran_img = imfilter(im, gradient_filter);

% thresholding operation
otptth = my_zc & abs(gran_img)>50;
