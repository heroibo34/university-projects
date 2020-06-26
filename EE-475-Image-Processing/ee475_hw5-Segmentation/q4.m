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
%%
b_w = edge(diamond_0,'canny');
[H,T,R] = hough(b_w,'RhoResolution',0.5,'Theta',-90:0.5:89);
P = houghpeaks(H,8,'threshold',ceil(0.2*max(H(:))));
lines = houghlines(b_w,T,R,P,'FillGap',5,'MinLength',7);
figure();imshow(uint8(diamond_0));hold on;
my_max_len = 0;
for i = 1:length(lines)
   xy = [lines(i).point1; lines(i).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');


   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','blue');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','blue');


   my_len = norm(lines(i).point1 - lines(i).point2);
   if ( my_len > my_max_len)
      my_max_len = my_len;
      xy_long = xy;
   end
end