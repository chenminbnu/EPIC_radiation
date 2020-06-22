function plot_global_map(lats, lons, sw_total, max_clr, title_text)
axis equal
m_proj('robinson','lat',[-90 90],'lon',[-180 180]); % robinson Mollweide
%m_coast('color','k');
hold on
m_grid('tickdir','in','linestyle','none','backcolor',[.9 .99 1], 'xticklabels',[], ...
    'fontsize',6);
m_pcolor(lons,lats,sw_total);
M=m_shaperead('landareas'); 
for k=1:length(M.ncst)    
     m_line(M.ncst{k}(:,1),M.ncst{k}(:,2),'color','k'); 
end; 
shading flat;
caxis([0,max_clr])
%colormap(m_colmap('jet','step',10));
%m_text(-170,80,sub_text,'fontsize',10)
colorbar
colormap(jet)
title(title_text,'fontsize',10)
%view(0,90);
hold off