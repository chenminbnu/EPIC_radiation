

clear all;
clc;
close all;

load('global_mean_cal.mat');

%% plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.82,0.40]);
hold on
plot(0,0)
plot(global_mean(2:end-1,1),'k-','linewidth',1)%, 'markersize',5)
plot(north_mean(2:end-1,1),'r-','linewidth',1)%, 'markersize',5)
plot(south_mean(2:end-1,1),'b-','linewidth',1)%, 'markersize',5)
plot(0,0)
plot(global_mean(2:end-1,2),'k--','linewidth',1)%, 'markersize',5)
plot(north_mean(2:end-1,2),'r--','linewidth',1)%, 'markersize',5)
plot(south_mean(2:end-1,2),'b--','linewidth',1)%, 'markersize',5)
 
box on
ylabel('SW (W/m^2)')    
axis([0 48 50 350 ])
legend({'EPIC','Global','Northern Hemi','Southern Hemi','CERES', 'Global','Northern Hemi','Southern Hemi'},'Location','eastoutside','Orientation','vertical')
set(gca, 'linewidth',1.5, 'xtick',[0 6 12 18 24 30 36 42 48], ...
    'xticklabel', {'06/2015','12/2015','06/2016','12/2016','06/2017','12/2017', '06/2018', '12/2018','06/2019'});
%% save file

print(gcf, '-dtiff', '-r600', 'month_variation.tif')

close all