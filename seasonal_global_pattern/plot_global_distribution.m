
%% lat lon
lon = -179.95:0.1:179.95;
lat = 89.95:-0.1:-89.95;
[lons,lats]=meshgrid(lon,lat);

load('seasonal_epic_ceres_2.mat');

%% plot

max_clr = 400;
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.82,0.4]);
set(gca, 'Position', [0 0 1 1])
subplot('position',[0.02 0.51 0.21 0.47])
plot_global_map(lats, lons, spring_sw_epic, max_clr, '(a) EPIC - Spring');
subplot('position',[0.25 0.51 0.21 0.47])
plot_global_map(lats, lons, summer_sw_epic, max_clr, '(b) EPIC - Summer');
subplot('position',[0.48 0.51 0.21 0.47])
plot_global_map(lats, lons, autumn_sw_epic, max_clr, '(c) EPIC - Autumn');
subplot('position',[0.71 0.51 0.21 0.47])
plot_global_map(lats, lons, winter_sw_epic, max_clr, '(d) EPIC - Winter');
 h=colorbar('eastoutside');
     title(h,'W/m^2','fontsize',8);
 % Modify Colorbar to a manual setting
    set(h,'pos',[0.94 0.55 0.012 0.38],'tickdir','out')
subplot('position',[0.02 0.02 0.21 0.47])
plot_global_map(lats, lons, spring_sw_ceres, max_clr, '(e) CERES - Spring');
subplot('position',[0.25 0.02 0.21 0.47])
plot_global_map(lats, lons, summer_sw_ceres, max_clr, '(f) CERES - Summer');
subplot('position',[0.48 0.02 0.21 0.47])
plot_global_map(lats, lons, autumn_sw_ceres, max_clr, '(g) CERES - Autumn');
subplot('position',[0.71 0.02 0.21 0.47])
plot_global_map(lats, lons, winter_sw_ceres, max_clr, '(h) CERES - Winter');
 h=colorbar('eastoutside');
    title(h,'W/m^2','fontsize',8);
    set(h,'pos',[0.94 0.06 0.012 0.38],'tickdir','out')
    
    
    
%% save file
print(gcf, '-dtiff', '-r600', 'seasonal_distribution.tif')

close all