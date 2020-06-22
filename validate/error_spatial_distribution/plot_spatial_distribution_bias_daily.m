function plot_spatial_distribution_bias_daily(bias, titletext, savefilename)
%%get site location
Directory = '';
filename= 'CERES_SurfObs.201501-201803_daily.nc';
lats_sites =  ncread([Directory filename], 'latitude' );
lons_sites =  ncread([Directory filename], 'longitude' );
lats_sites = lats_sites(1:58);
lons_sites = lons_sites(1:58);
lons_sites(lons_sites>180) = lons_sites(lons_sites>180) - 360;


colors = flipud(autumn(6));

%% show the map
figure
set(gcf,'unit','normalized','position',[0.1,0.1,0.6,0.55]);
set(gca, 'Position', [ 0 0 1 1])
% scrsz = get(0, 'ScreenSize');
% set(gcf, 'Position',scrsz);
maps %查看当前可用的地图投影方式
load coast %% 　导入数据,全球海岸线
%%%绘图
axesm robinson
geoshow('landareas.shp', 'FaceColor', [0.5, 0.5, 0.5]);

filter = bias<=-20;
if sum(filter)>0
    p1 = plotm(lats_sites(filter),lons_sites(filter),'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(1,:));
else
    p1 = plotm(-200, -200,'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(1,:));
end

hold on
filter = bias>-20 & bias<=-10;
if sum(filter)>0
    
    p2 = plotm(lats_sites(filter),lons_sites(filter),'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(2,:));
else
    p2 = plotm(-200, -200,'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(2,:));
end


filter = bias>-10 & bias<=0;
if sum(filter)>0
    p3 = plotm(lats_sites(filter),lons_sites(filter),'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(3,:));
else
    p3 = plotm(-200, -200,'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(3,:));
end

filter = bias>0 & bias<=10;
if sum(filter)>0
    p4 = plotm(lats_sites(filter),lons_sites(filter),'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(4,:));
else
    p4 = plotm(-200, -200,'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(4,:));
end


filter = bias>10 & bias<=20;
if sum(filter)>0
    p5 = plotm(lats_sites(filter),lons_sites(filter),'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(5,:));
else
    p5 = plotm(-200, -200,'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(5,:));
end

filter = bias>20;
if sum(filter)>0
    p6 = plotm(lats_sites(filter),lons_sites(filter),'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(6,:));
else
    p6 = plotm(-200, -200,'o',...
        'MarkerSize',12,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',colors(6,:));
end


%%% 设置属性
setm(gca);%查看当前可以设置的所有图形坐标轴(map axes)的属性
setm(gca,'Frame','on');%使框架可见
getm(gca,'Frame');%使用getm可以获取指定的图形坐标轴的属性
setm(gca,'Grid','on');%打开网格
setm(gca,'MLabelLocation',60);%标上经度刻度标签,每隔60度
setm(gca,'MeridianLabel','off');%设置经度刻度标签可见
setm(gca,'PLabelLocation',[-90:30:-30, 30:30:90])%标上经度刻度标签,[-90:30:90]
setm(gca,'ParallelLabel','on');%设置经度刻度标签可见
setm(gca,'MLabelParallel','equator');%将经度刻度标签放在南方,即下部
setm(gca, 'fontsize', 12)
%setm(gca, 'title', 'aaaa')
axis off
lg1 = legend([p1 p2 p3 p4 p5 p6],{'<-20', '-20--10', '-10-0', '0-10','10-20','>20'},...
    'Location','best','Orientation','Vertical', 'fontsize',14);
legend('boxoff')
set(lg1, 'Position',[0.13 0.25 0.1 0.25]);
title(lg1, titletext)
%setm(gca,'Origin',[0,180,0]);%设置地图的中心位置和绕中心点和地心点的轴旋转角度[latitude longitude orientation]
%setm(gca,'PLabelMeridian',90);%将纬度标签放置在经度为90度的地方
%scaleruler
%colorbar
%colormap jet
%caxis([0,90])
%title('Spatial Distribution of BSRN Stations')
print(gcf, '-dtiff', '-r600', [ savefilename '.tif'])
close all