function out = distance_to_center(i,ii,center_pixel)
%this function finds the distance between (i,ii) and (pixel_number,pixel_number)

out=(center_pixel-i)^2+(center_pixel-ii)^2;
out = sqrt(out);
end

