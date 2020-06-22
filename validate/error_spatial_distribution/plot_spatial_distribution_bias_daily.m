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
maps %�鿴��ǰ���õĵ�ͼͶӰ��ʽ
load coast %% ����������,ȫ�򺣰���
%%%��ͼ
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


%%% ��������
setm(gca);%�鿴��ǰ�������õ�����ͼ��������(map axes)������
setm(gca,'Frame','on');%ʹ��ܿɼ�
getm(gca,'Frame');%ʹ��getm���Ի�ȡָ����ͼ�������������
setm(gca,'Grid','on');%������
setm(gca,'MLabelLocation',60);%���Ͼ��ȿ̶ȱ�ǩ,ÿ��60��
setm(gca,'MeridianLabel','off');%���þ��ȿ̶ȱ�ǩ�ɼ�
setm(gca,'PLabelLocation',[-90:30:-30, 30:30:90])%���Ͼ��ȿ̶ȱ�ǩ,[-90:30:90]
setm(gca,'ParallelLabel','on');%���þ��ȿ̶ȱ�ǩ�ɼ�
setm(gca,'MLabelParallel','equator');%�����ȿ̶ȱ�ǩ�����Ϸ�,���²�
setm(gca, 'fontsize', 12)
%setm(gca, 'title', 'aaaa')
axis off
lg1 = legend([p1 p2 p3 p4 p5 p6],{'<-20', '-20--10', '-10-0', '0-10','10-20','>20'},...
    'Location','best','Orientation','Vertical', 'fontsize',14);
legend('boxoff')
set(lg1, 'Position',[0.13 0.25 0.1 0.25]);
title(lg1, titletext)
%setm(gca,'Origin',[0,180,0]);%���õ�ͼ������λ�ú������ĵ�͵��ĵ������ת�Ƕ�[latitude longitude orientation]
%setm(gca,'PLabelMeridian',90);%��γ�ȱ�ǩ�����ھ���Ϊ90�ȵĵط�
%scaleruler
%colorbar
%colormap jet
%caxis([0,90])
%title('Spatial Distribution of BSRN Stations')
print(gcf, '-dtiff', '-r600', [ savefilename '.tif'])
close all