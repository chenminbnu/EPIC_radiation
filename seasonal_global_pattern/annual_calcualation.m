annual_sw_epic = (spring_sw_epic + ...
    summer_sw_epic + ...
    autumn_sw_epic + ...
    winter_sw_epic)/4;
annual_sw_ceres = (spring_sw_ceres + ...
    summer_sw_ceres + ...
    autumn_sw_ceres + ...
    winter_sw_ceres)/4;

Longs = [-179.95:0.1:179.95];
Lats = [89.95:-0.1:-89.95];

[Longs, Lats] = meshgrid( Longs, Lats);
Lats = abs(Lats)*pi/180;

Lats2 = Lats;
Lats2(isnan(annual_sw_epic)) = nan;
area_global = cos(Lats2) ;
area_global = nansum(area_global(:));

    
global_epic = annual_sw_epic.*cos(Lats2);
global_ceres = annual_sw_ceres.*cos(Lats2);


global_mean1 = nansum(global_epic(:))/area_global;
global_mean2 = nansum(global_ceres(:))/area_global;




% figure;
% subplot(1,2,1)
% imagesc(annual_sw_epic)
% subplot(1,2,2)
% imagesc(annual_sw_ceres)

