%% import data
load('EPIC_daily.mat');
load('CAVE_daily.mat');

%% filter data
times = 1:1826;
sites = 1:58;
epic_diffuse = SW_diffuse_epics(times,sites);
epic_direct = SW_direct_epics(times,sites);
obs_diffuse = SW_diffuse_cave_obss(times,sites);
obs_direct =  SW_direct_cave_obss(times,sites);
epic_total = epic_diffuse + epic_direct;
obs_total = obs_diffuse + obs_direct;

epic_par = PAR_diffuse_epics(times,sites) + PAR_direct_epics(times,sites);
load('Surfrad_daily_all.mat');
obs_par = PAR_total_obss_surf(times,sites);
% obs_total2 = SW_direct_obss_surf(times,sites) + SW_diffuse_obss_surf(times,sites);
% a = obs_total;
% b = obs_total2;
% filter = a>0 & b>0
% a = a(filter);
% b = b(filter);
% corrcoef(a, b) 
% sqrt(mean((a-b).^2))
% figure;
% plot(a, 'b')
% hold on
% plot(b, 'r')
%% plot
figure;
colormap jet
set(gcf,'unit','normalized','position',[0.1,0.1,0.45,0.72]);
subplot(2,2,1)
plot_density_plot_SW_daily(obs_diffuse, epic_diffuse,'Observed (W/m^2)','EPIC-derived (W/m^2)','(a) Diffuse SW');
subplot(2,2,2)
plot_density_plot_SW_daily(obs_direct, epic_direct,'Observed (W/m^2)','EPIC-derived (W/m^2)','(b) Direct SW');
subplot(2,2,3)
plot_density_plot_SW_daily(obs_total, epic_total,'Observed (W/m^2)','EPIC-derived (W/m^2)','(c) Total SW');
subplot(2,2,4)
plot_density_plot_par_daily(obs_par, epic_par,'Observed (W/m^2)','EPIC-derived (W/m^2)','(d) Total PAR');

print(gcf, '-dtiff', '-r600', 'daily_validation.tif')

close all