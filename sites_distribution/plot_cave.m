%%get site location
Directory = '';
filename= 'CERES_SurfObs.201501-201803_daily.nc';
lats_sites =  ncread([Directory filename], 'latitude' );
lons_sites =  ncread([Directory filename], 'longitude' );
lats_sites = lats_sites(1:58);
lons_sites = lons_sites(1:58);
lons_sites(lons_sites>180) = lons_sites(lons_sites>180) - 360;

% surfrad = [
% 	40.05	-88.37	213
% 	40.125	-105.237	1689
% 	36.624	-116.019	1007
% 	48.31	-105.10	634
% 	34.25	-89.87	98
% 	40.72	-77.93	376
% 	43.73	-96.62	473];

load('site_type.mat');
load('isvalid.mat')
%% show the map
figure
set(gcf,'unit','normalized','position',[0.1,0.1,0.6,0.55]);
% scrsz = get(0, 'ScreenSize');
% set(gcf, 'Position',scrsz);
maps %查看当前可用的地图投影方式
load coast %% 　导入数据,全球海岸线
%%%绘图
axesm robinson
geoshow('landareas.shp', 'FaceColor', [0.5, 0.5, 0.5]);


p1 = plotm(lats_sites(sitetype == 1 & isvalid),lons_sites(sitetype == 1  & isvalid),'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','b');

hold on 

p2 = plotm(lats_sites((sitetype == 2 | sitetype == 3)  & isvalid),lons_sites((sitetype == 2  | sitetype == 3)  & isvalid),'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','r');


p3 = plotm(lats_sites(sitetype == 4  & isvalid ),lons_sites(sitetype == 4  & isvalid),'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','m');


p4 = plotm(lats_sites(sitetype == 3  & isvalid ),lons_sites(sitetype == 3  & isvalid ),'^',...
    'MarkerSize',4,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','k', 'linewidth', 1);

 %%% 设置属性
setm(gca);%查看当前可以设置的所有图形坐标轴(map axes)的属性
setm(gca,'Frame','on');%使框架可见
getm(gca,'Frame');%使用getm可以获取指定的图形坐标轴的属性
setm(gca,'Grid','on');%打开网格
setm(gca,'MLabelLocation',60);%标上经度刻度标签,每隔60度
setm(gca,'MeridianLabel','on');%设置经度刻度标签可见
setm(gca,'PLabelLocation',[-90:30:-30, 30:30:90])%标上经度刻度标签,[-90:30:90]
setm(gca,'ParallelLabel','on');%设置经度刻度标签可见
setm(gca,'MLabelParallel','equator');%将经度刻度标签放在南方,即下部 
setm(gca, 'fontsize', 9)
axis off
legend([p1 p2 p3 p4],{'Polar', 'Continental', 'Island/Coastal', 'SURFRAD'},'Location','southoutside','Orientation','Horizontal', 'fontsize',10)
%setm(gca,'Origin',[0,180,0]);%设置地图的中心位置和绕中心点和地心点的轴旋转角度[latitude longitude orientation]
%setm(gca,'PLabelMeridian',90);%将纬度标签放置在经度为90度的地方
%scaleruler
%colorbar
%colormap jet
%caxis([0,90])
%title('Spatial Distribution of BSRN Stations')
print(gcf, '-dtiff', '-r600', [ 'siteloc.tif'])
close all