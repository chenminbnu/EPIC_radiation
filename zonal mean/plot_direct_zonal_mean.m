load('epic_zonal.mat');
load('ceres_zonal.mat');

time_filter = 165:1639;
figure;
colormap jet
set(gcf,'unit','normalized','position',[0.1,0.1,0.82,0.5]);
set(gca, 'Position', [0 0 1 1])
subplot('position',[0.05 0.55 0.4 0.38])
ax = imagesc(direct_sw_epic_zonal(:,time_filter) , [0 500])
title('(a) EPIC - Direct SW')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
subplot('position',[0.5 0.55 0.4 0.38])
imagesc(direct_sw_ceres_zonal(:,time_filter) , [0 500])
title('(b) CERES - Direct SW')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});

 h=colorbar('eastoutside');
    title(h,'W/m^2','fontsize',8);
    set(h,'pos',[0.93 0.55 0.012 0.38],'tickdir','out')

    
subplot('position',[0.05 0.1 0.4 0.38])
imagesc(direct_par_epic_zonal(:,time_filter) , [0 200])
title('(c) EPIC - Direct PAR')
set(gca,'xtick',[], 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
set(gca,'xtick',[202 568 933 1298], 'xticklabel',{'1/1/2016', '1/1/2017', '1/1/2018', '1/1/2019'}...
    , 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
set(gca,'TickDir','out', 'box', 'off'); % The only other option is 'in'

subplot('position',[0.5 0.1 0.4 0.38])
imagesc(direct_par_ceres_zonal(:,time_filter) , [0 200])
title('(d) CERES - Direct PAR')
set(gca,'xtick',[202 568 933 1298], 'xticklabel',{'1/1/2016', '1/1/2017', '1/1/2018', '1/1/2019'}...
    , 'ytick', [1 900 1800], 'yticklabel',{'90буN','0бу','90буS'});
set(gca,'TickDir','out', 'box', 'off'); % The only other option is 'in'

 h=colorbar('eastoutside');
    title(h,'W/m^2','fontsize',8);
    set(h,'pos',[0.93 0.1 0.012 0.38],'tickdir','out')
    

% % set box property to off and remove background color
% set(a,'box','off','color','none')
% % create new, empty axes with box but without ticks
% b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
% % set original axes as active
% axes(a)
% % link axes in case of zooming
% linkaxes([a b])
%% save file

print(gcf, '-dtiff', '-r600', 'direct_zonal_variation.tif')

close all