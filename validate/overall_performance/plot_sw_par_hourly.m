%% import data
load('EPIC_hourly.mat');
load('CAVE_hourly.mat');

%% filter data
times = 1:43824;
sites = 1:58;
epic_diffuse = SW_diffuse_epics(times,sites);
epic_direct = SW_direct_epics(times,sites);
obs_diffuse = SW_diffuse_cave_obss(times,sites);
obs_direct =  + SW_direct_cave_obss(times,sites);
epic_total = epic_diffuse + epic_direct;
obs_total = obs_diffuse + obs_direct;

epic_par = PAR_diffuse_epics(times,sites) + PAR_direct_epics(times,sites);
load('Surfrad_hourly_all.mat');
obs_par = PAR_total_obss_surf(times,sites);

%% plot
figure;
colormap jet
set(gcf,'unit','normalized','position',[0.1,0.1,0.45,0.72]);
subplot(2,2,1)
plot_density_plot_SW_hourly(obs_diffuse, epic_diffuse,'Observed (W/m^2)','EPIC-derived (W/m^2)','(a) Diffuse SW');
subplot(2,2,2)
plot_density_plot_SW_hourly(obs_direct, epic_direct,'Observed (W/m^2)','EPIC-derived (W/m^2)','(b) Direct SW');
subplot(2,2,3)
plot_density_plot_SW_hourly(obs_total, epic_total,'Observed (W/m^2)','EPIC-derived (W/m^2)','(c) Total SW');
subplot(2,2,4)
plot_density_plot_par_hourly(obs_par, epic_par,'Observed (W/m^2)','EPIC-derived (W/m^2)','(d) Total PAR');

print(gcf, '-dtiff', '-r600', 'hourly_validation.tif')

close all