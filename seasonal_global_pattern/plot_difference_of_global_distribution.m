
%% lat lon
lon = -179.95:0.1:179.95;
lat = 89.95:-0.1:-89.95;
[lons,lats]=meshgrid(lon,lat);

load('seasonal_epic_ceres_2.mat');

%% plot

max_clr = 50;
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.82,0.2]);
set(gca, 'Position', [0 0 1 1])
subplot('position',[0.02 0.05 0.21 0.9])
plot_difference_global_map(lats, lons, spring_sw_epic-spring_sw_ceres, max_clr, '(a) Spring');
subplot('position',[0.25 0.05 0.21 0.9])
plot_difference_global_map(lats, lons, summer_sw_epic-summer_sw_ceres, max_clr, '(b) Summer');
subplot('position',[0.48 0.05 0.21 0.9])
plot_difference_global_map(lats, lons, autumn_sw_epic-autumn_sw_ceres, max_clr, '(c) Autumn');
subplot('position',[0.71 0.05 0.21 0.9])
plot_difference_global_map(lats, lons, winter_sw_epic-winter_sw_ceres, max_clr, '(d) Winter');
 h=colorbar('eastoutside');
     title(h,'W/m^2','fontsize',8);
 % Modify Colorbar to a manual setting
    set(h,'pos',[0.94 0.10 0.012 0.75],'tickdir','out')
    
    
    
%% save file
print(gcf, '-dtiff', '-r600', 'difference_of_seasonal_distribution.tif')

close all