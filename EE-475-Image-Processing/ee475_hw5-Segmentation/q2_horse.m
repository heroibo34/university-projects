%% Region Growing for horse
%% initializing part
clear;clc;
load berkeley_horses.mat

segmented_image=groundTruth{1}.Segmentation;
ground_1=groundTruth{1}.Boundaries;
%figure();imshow(ground_1);title('Boundaries');
max_value=max(max(segmented_image));
figure();imshow(uint8(segmented_image*255/max_value));%title('Segmented');

matrix_horse = double(imread('Berkeley_horses.jpg')); % read image
%figure();imshow(uint8(matrix_horse));title('Image');
[m,n,k]=size(matrix_horse);
regioned_matrix=zeros(m,n);

p_1_x=122;p_1_y=221;   %  at
new_added_2_1=[p_1_x p_1_y];
p_2_x=131;p_2_y=384; % yer
new_added_2_2=[p_2_x p_2_y];
p_3_x=127;p_3_y=286;    % tay
new_added_2_3=[p_3_x p_3_y];
p_4_x=304;p_4_y=129;    % yer 2
new_added_2_4=[p_4_x p_4_y];
p_5_x=296;p_5_y=420;    % yer 3
new_added_2_5=[p_5_x p_5_y];
th_extra_2=10;
th_extra_4=24;
th_extra_5=8;


value_1=round(255/5);value_2=round(255/5*2);value_3=round(255/5*3);value_4=round(255/5*4);value_5=round(255/5*5);
regioned_matrix(p_1_x,p_1_y)=value_1;
regioned_matrix(p_2_x,p_2_y)=value_2;
regioned_matrix(p_3_x,p_3_y)=value_3;
regioned_matrix(p_4_x,p_4_y)=value_4;
regioned_matrix(p_5_x,p_5_y)=value_5;

%figure();imshow(uint8(regioned_matrix));title('Regioned matrix');
c_1=zeros(1,3);
c_2=zeros(1,3);
c_3=zeros(1,3);
c_4=zeros(1,3);
c_5=zeros(1,3);
%% Growing Part
num_of_labeled_2=0;
num_of_labeled_1=1;
Th=-5;
delta_Th=10;
tempp_1=1;
tempp_2=2;
while sum(regioned_matrix(:)==0)
    tempp_1=regioned_matrix;
    
    Th=Th+delta_Th;
    disp(Th)
    main_controller=0;
    [new_added_2_1(:,1) new_added_2_1(:,2)]=find(regioned_matrix==value_1);
    [new_added_2_2(:,1) new_added_2_2(:,2)]=find(regioned_matrix==value_2);
    [new_added_2_3(:,1) new_added_2_3(:,2)]=find(regioned_matrix==value_3);
    [new_added_2_4(:,1) new_added_2_4(:,2)]=find(regioned_matrix==value_4);
    [new_added_2_5(:,1) new_added_2_5(:,2)]=find(regioned_matrix==value_5);
    
    while ~(isequal(new_added_2_5,[]) && isequal(new_added_2_1,[]) && isequal(new_added_2_2,[]) && isequal(new_added_2_3,[]) && isequal(new_added_2_4,[]) && main_controller==1)
        main_controller=1;
        num_of_labeled_1=sum(sum(regioned_matrix>0));

        %region-1 growing
        if ~isequal(new_added_2_1,[])
            value=value_1;
            x=new_added_2_1(:,1);
            y=new_added_2_1(:,2);
            [c_1(1), c_1(2), c_1(3)]=mean_function(matrix_horse,x,y);
            new_added_1_1=[];
            for i=1:length(x)
                if x(i)<m && x(i)>1 && y(i)<n && y(i)>1
                    for k=-1:1
                        for l=-1:1

                            if regioned_matrix(x(i)+k,y(i)+l)==0
                                point(1)=matrix_horse(x(i)+k,y(i)+l,1);
                                point(2)=matrix_horse(x(i)+k,y(i)+l,2);
                                point(3)=matrix_horse(x(i)+k,y(i)+l,3);
                                if norm(c_1-point)<Th
                                    regioned_matrix(x(i)+k,y(i)+l)=value;
                                    new_added_1_1=[new_added_1_1;x(i)+k y(i)+l];
                                end                   
                            end
                        end           
                    end   
                end
            end
        end
        new_added_2_1=new_added_1_1;
        
     
        %region-2 growing
        if ~isequal(new_added_2_2,[])
            value=value_2;
            x=new_added_2_2(:,1);
            y=new_added_2_2(:,2);
            
            [c_2(1), c_2(2), c_2(3)]=mean_function(matrix_horse,x,y);
            
            new_added_1_2=[];
            for i=1:length(x)
                if x(i)<m && x(i)>1 && y(i)<n && y(i)>1
                    for k=-1:1
                        for l=-1:1
                            if regioned_matrix(x(i)+k,y(i)+l)==0
                                point(1)=matrix_horse(x(i)+k,y(i)+l,1);
                                point(2)=matrix_horse(x(i)+k,y(i)+l,2);
                                point(3)=matrix_horse(x(i)+k,y(i)+l,3);
                                if norm(c_2-point)<Th
                                    regioned_matrix(x(i)+k,y(i)+l)=value;
                                    new_added_1_2=[new_added_1_2;x(i)+k y(i)+l];
                                end                   
                            end
                        end           
                    end  
                end
            end
        end
        new_added_2_2=new_added_1_2;
        %region-3 growing
        if ~isequal(new_added_2_3,[])
            value=value_3;
            x=new_added_2_3(:,1);
            y=new_added_2_3(:,2);      
            [c_3(1), c_3(2), c_3(3)]=mean_function(matrix_horse,x,y);
            new_added_1_3=[];
            
            for i=1:length(x)
                if x(i)<m && x(i)>1 && y(i)<n && y(i)>1
                    for k=-1:1
                        for l=-1:1
                            if regioned_matrix(x(i)+k,y(i)+l)==0
                                point(1)=matrix_horse(x(i)+k,y(i)+l,1);
                                point(2)=matrix_horse(x(i)+k,y(i)+l,2);
                                point(3)=matrix_horse(x(i)+k,y(i)+l,3);
                                if norm(c_3-point)<Th
                                    regioned_matrix(x(i)+k,y(i)+l)=value;
                                    new_added_1_3=[new_added_1_3;x(i)+k y(i)+l];
                                end                   
                            end
                        end           
                    end   
                end
            end
        end
        new_added_2_3=new_added_1_3;
        num_of_labeled_2=sum(sum(regioned_matrix>0));

    %region-4 growing
        if ~isequal(new_added_2_4,[])
            value=value_4;
            x=new_added_2_4(:,1);
            y=new_added_2_4(:,2);      
            [c_4(1), c_4(2), c_4(3)]=mean_function(matrix_horse,x,y);
            new_added_1_4=[];
            
            for i=1:length(x)
                if x(i)<m && x(i)>1 && y(i)<n && y(i)>1
                    for k=-1:1
                        for l=-1:1
                            if regioned_matrix(x(i)+k,y(i)+l)==0
                                point(1)=matrix_horse(x(i)+k,y(i)+l,1);
                                point(2)=matrix_horse(x(i)+k,y(i)+l,2);
                                point(3)=matrix_horse(x(i)+k,y(i)+l,3);
                                if norm(c_4-point)<Th+th_extra_4
                                    regioned_matrix(x(i)+k,y(i)+l)=value;
                                    new_added_1_4=[new_added_1_4;x(i)+k y(i)+l];
                                end                   
                            end
                        end           
                    end   
                end
            end
        end
        new_added_2_4=new_added_1_4;
        %imshow(uint8(regioned_matrix))
        %region-5 growing
        new_added_1_5=[];
        if ~isequal(new_added_2_5,[])
            value=value_5;
            x=new_added_2_5(:,1);
            y=new_added_2_5(:,2);      
            [c_5(1), c_5(2), c_5(3)]=mean_function(matrix_horse,x,y);
            new_added_1_5=[];
            
            for i=1:length(x)
                if x(i)<m && x(i)>1 && y(i)<n && y(i)>1
                    for k=-1:1
                        for l=-1:1
                            if regioned_matrix(x(i)+k,y(i)+l)==0
                                point(1)=matrix_horse(x(i)+k,y(i)+l,1);
                                point(2)=matrix_horse(x(i)+k,y(i)+l,2);
                                point(3)=matrix_horse(x(i)+k,y(i)+l,3);
                                if norm(c_5-point)<Th+th_extra_5
                                    regioned_matrix(x(i)+k,y(i)+l)=value;
                                    new_added_1_5=[new_added_1_5;x(i)+k y(i)+l];
                                end                   
                            end
                        end           
                    end   
                end
            end
        end
        new_added_2_5=new_added_1_5;
        imshow(uint8(regioned_matrix))
        
    end
end
%%
figure();
imshow(uint8(regioned_matrix))

%% mapleme
big_horse=uint8(regioned_matrix==value_1);
% figure();
% imshow(big_horse,[]);

small_horse=uint8(regioned_matrix==value_3);
% figure();
% imshow(small_horse,[]);

other_are_matrix=uint8(regioned_matrix==value_2)+uint8(regioned_matrix==value_4)+uint8(regioned_matrix==value_5);
% figure();
% imshow(uint8(other_are_matrix),[]);

my_segmented_matrix=85*double(other_are_matrix)+170*double(big_horse)+255*double(small_horse);
figure();
imshow(uint8(my_segmented_matrix));
%%

segmented_other=uint8(segmented_image==1);
% figure();
% imshow(uint8(segmented_other),[]);

segmented_big_horse=uint8(segmented_image==2);
% figure();
% imshow(uint8(segmented_big_horse),[]);

segmented_small_horse=uint8(segmented_image==3);
% figure();
% imshow(uint8(segmented_small_horse),[]);
%%
% small_control_intersection=(segmented_small_horse+small_horse)>1;
% small_control_union=(segmented_small_horse+small_horse)>0;
% goodness_small_horse=sum(sum(small_control_intersection))/sum(sum(small_control_union))

%% Goodness
small_control_intersection=(segmented_small_horse+small_horse)>1;
small_control_union=(segmented_small_horse+small_horse)>0;
goodness_small_horse=sum(sum(small_control_intersection))/sum(sum(small_control_union))

big_control_intersection=(segmented_big_horse+big_horse)>1;
big_control_union=(segmented_big_horse+big_horse)>0;
goodness_big_horse=sum(sum(big_control_intersection))/sum(sum(big_control_union))

other_control_intersection=(segmented_other+other_are_matrix)>1;
other_control_union=(segmented_other+other_are_matrix)>0;
goodness_other=sum(sum(other_control_intersection))/sum(sum(other_control_union))


function [ans1, ans2, ans3] = mean_function(matrix_horse,x,y)
temp_1=zeros(1,length(x));
temp_2=zeros(1,length(x));
temp_3=zeros(1,length(x));
    for a=1:length(x)
        temp_1(a)=matrix_horse(x(a),y(a),1); 
        temp_2(a)=matrix_horse(x(a),y(a),2); 
        temp_3(a)=matrix_horse(x(a),y(a),3); 
    end
ans1=mean(temp_1);
ans2=mean(temp_2);
ans3=mean(temp_3);
end
