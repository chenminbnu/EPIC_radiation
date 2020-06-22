load('epic_zonal.mat');
load('ceres_zonal.mat');

time_filter = 165:1639;
figure;
colormap jet
set(gcf,'unit','normalized','position',[0.1,0.1,0.82,0.75]);
set(gca, 'Position', [0 0 1 1])
subplot('position',[0.05 0.70 0.4 0.25])
imagesc(direct_sw_epic_zonal(:,time_filter) + diffuse_sw_epic_zonal(:,time_filter)- direct_sw_ceres_zonal(:,time_filter) - diffuse_sw_ceres_zonal(:,time_filter), [-100 100])
title('(a) Total SW')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
subplot('position',[0.5 0.70 0.4 0.25])
imagesc(direct_par_epic_zonal(:,time_filter) + diffuse_par_epic_zonal(:,time_filter)- direct_par_ceres_zonal(:,time_filter) - diffuse_par_ceres_zonal(:,time_filter), [-100 100])
title('(b) Total PAR')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});

 h=colorbar('eastoutside');
    title(h,'W/m^2','fontsize',8);
    set(h,'pos',[0.93 0.7 0.012 0.25],'tickdir','out')

    
subplot('position',[0.05 0.40 0.40 0.25])
imagesc(direct_sw_epic_zonal(:,time_filter) - direct_sw_ceres_zonal(:,time_filter), [-100 100])
title('(c) Direct SW')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});

subplot('position',[0.5 0.40 0.40 0.25])
imagesc(direct_par_epic_zonal(:,time_filter) - direct_par_ceres_zonal(:,time_filter), [-100 100])
title('(d) Direct PAR')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});

 h=colorbar('eastoutside');
    title(h,'W/m^2','fontsize',8);
    set(h,'pos',[0.93 0.40 0.012 0.25],'tickdir','out')
    
    
subplot('position',[0.05 0.1 0.4 0.25])
imagesc(diffuse_sw_epic_zonal(:,time_filter)-diffuse_sw_ceres_zonal(:,time_filter), [-100 100])
title('(e) Diffuse SW')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
set(gca,'xtick',[202 568 933 1298], 'xticklabel',{'1/1/2016', '1/1/2017', '1/1/2018', '1/1/2019'}...
    , 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
set(gca,'TickDir','out', 'box', 'off'); % The only other option is 'in'

subplot('position',[0.5 0.1 0.4 0.25])
imagesc(diffuse_par_epic_zonal(:,time_filter)-diffuse_par_ceres_zonal(:,time_filter), [-100 100])
title('(f) Diffuse PAR')
set(gca,'xtick',[202 568 933 1298], 'xticklabel',{'1/1/2016', '1/1/2017', '1/1/2018', '1/1/2019'}...
    , 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
set(gca,'TickDir','out', 'box', 'off'); % The only other option is 'in'

 h=colorbar('eastoutside');
    title(h,'W/m^2','fontsize',8);
    set(h,'pos',[0.93 0.1 0.012 0.25],'tickdir','out')
  
% % set box property to off and remove background color
% set(a,'box','off','color','none')
% % create new, empty axes with box but without ticks
% b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
% % set original axes as active
% axes(a)
% % link axes in case of zooming
% linkaxes([a b])
%% save file

print(gcf, '-dtiff', '-r600', 'difference_zonal_variation.tif')

close all