%% Region Growing for horse
%% initializing part
clear;clc;
load berkeley_horses.mat

% segmented_image=groundTruth{1}.Segmentation;
% ground_1=groundTruth{1}.Boundaries;
% %figure();imshow(ground_1);title('Boundaries');
% max_value=max(max(segmented_image));
% %figure();imshow(uint8(segmented_image*255/max_value));title('Segmented');

matrix_horse = double(imread('Gauss_rgb1.png')); % read image
figure();imshow(uint8(matrix_horse));title('Image');
[m,n,k]=size(matrix_horse);
regioned_matrix=zeros(m,n);
%%
p_1_x=39;p_1_y=39;
new_added_2_1=[p_1_x p_1_y];
p_2_x=37;p_2_y=105; % yer
new_added_2_2=[p_2_x p_2_y];
p_3_x=98;p_3_y=62;
new_added_2_3=[p_3_x p_3_y];



value_1=round(255/3);value_2=round(255/3*2);value_3=round(255/3*3);
regioned_matrix(p_1_x,p_1_y)=value_1;
regioned_matrix(p_2_x,p_2_y)=value_2;
regioned_matrix(p_3_x,p_3_y)=value_3;

%figure();imshow(uint8(regioned_matrix));title('Regioned matrix');
c_1=zeros(1,3);
c_2=zeros(1,3);
c_3=zeros(1,3);

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

    
    while ~(isequal(new_added_2_1,[]) && isequal(new_added_2_2,[]) && isequal(new_added_2_3,[]) && main_controller==1)
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
                                if norm(c_3-point)<Th-5
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

%         imshow(uint8(regioned_matrix))
        
    end
end
figure();
imshow(uint8(regioned_matrix))
%%
%% mapleme
sol_ust=uint8(regioned_matrix==value_1);%solust
% figure();
% imshow(sol_ust,[]);

sag_ust=uint8(regioned_matrix==value_2);%sagust
% figure();
% imshow(sag_ust,[]);

alt=uint8(regioned_matrix==value_3); %alt

my_result=255*double(sag_ust)+127*double(sol_ust);
figure();
imshow(uint8(my_result));
%% real image
sol_ust_real=zeros(m,n);
sol_ust_real(1:m/2,1:n/2)=1;
% figure();
% imshow(sol_ust_real,[]);

sag_ust_real=zeros(m,n);
sag_ust_real(1:m/2,n/2+1:end)=1;
% figure();
% imshow(sag_ust_real,[]);

alt_real=zeros(m,n);
alt_real(m/2+1:end,:)=1;
% figure();
% imshow(alt_real,[]);
my_result_real=255*double(sag_ust_real)+127*double(sol_ust_real);
imshow(uint8(my_result_real));
%% Goodness alt
alt_intersection=(alt_real+double(alt))>1;
alt_union=(alt_real+double(alt))>0;
goodness_alt=sum(sum(alt_intersection))/sum(sum(alt_union))
%% sol ust
sol_ust_intersection=(sol_ust_real+double(sol_ust))>1;
sol_ust_union=(sol_ust_real+double(sol_ust))>0;
goodness_sol_ust=sum(sum(sol_ust_intersection))/sum(sum(sol_ust_union))
%% sag ust
sag_ust_intersection=(sag_ust_real+double(sag_ust))>1;
sag_ust_union=(sag_ust_real+double(sag_ust))>0;
goodness_sag_ust=sum(sum(sag_ust_intersection))/sum(sum(sag_ust_union))


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
