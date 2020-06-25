function [button,button_controller] = detection_button(data,my_filter,button_controller)
%%
data_ac=data-mean(data);%i deal with the ac part of the data
energy_initial=sum(data_ac.^2); %sinitial energy


for m=1:8 %for each filter, ernergy matrix 
    filtered_data=filter(my_filter(m),data_ac);
    energy(m)=sum(filtered_data.^2);
end

x_cordinate=energy(1:4); % after filter [697,770,852,941]
y_cordinate=energy(5:8) ;% after filter [1209,1336,1477,1633]

[value_x,x_indice]=max(x_cordinate);
[value_y,y_indice]=max(y_cordinate);

result_matrix=['1','2','3','A';...
                '4','5','6','B';...
                '7','8','9','C';...
                '*','0','#','D'];
%button=result_matrix(x_indice,y_indice);

% controls whether anyone push the dual tone
if value_x>energy_initial*0.1 && value_y>energy_initial*0.1 
   button=result_matrix(x_indice,y_indice);
else
    button='';
end


%if user push any button for a long time, to print only once
if ~isequal(button_controller,button)
    fprintf(button)
    button_controller=button;
end

end

