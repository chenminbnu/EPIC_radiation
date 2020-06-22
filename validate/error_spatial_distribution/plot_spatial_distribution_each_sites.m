%%get site location
Directory = '';
filename= 'CERES_SurfObs.201501-201803_daily.nc';
lats_sites =  ncread([Directory filename], 'latitude' );
lons_sites =  ncread([Directory filename], 'longitude' );
lats_sites = lats_sites(1:58);
lons_sites = lons_sites(1:58);
lons_sites(lons_sites>180) = lons_sites(lons_sites>180) - 360;

title_text = 'RMSE';
load('hourly_error_each_site.mat');


ax = worldmap('World');
hold on
load coastlines;
gridm('GLineStyle','-','Gcolor',[.7 .7 .7],'Galtitude',.02)
plot3m(coastlat,coastlon,.01,'k','LineWidth', 0.5)
scatterm(lats_sites, lons_sites, RMSEs(:,1),'filled')
%

%  m_plot(lons_sites,lats_sites,'o','markersize',RMSEs(:,1));
% 
% M=m_shaperead('landareas'); 
% for k=1:length(M.ncst)    
%      m_line(M.ncst{k}(:,1),M.ncst{k}(:,2),'color','k'); 
% end; 
%shading flat;
%caxis([0,max_clr])
%colormap(m_colmap('jet','step',10));
%m_text(-170,80,sub_text,'fontsize',10)
%colorbar
%colormap(jet)
title(title_text,'fontsize',10)
%view(0,90);
hold off