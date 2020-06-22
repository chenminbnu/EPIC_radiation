%% import data
load('EPIC_daily.mat');
load('Surfrad_daily_all.mat');

%% filter data
times = 732:1826;
times = 1:731;
sites = 1:58;
epic_diffuse = SW_diffuse_epics(times,sites);
epic_direct = SW_direct_epics(times,sites);
epic_par = PAR_direct_epics(times,sites) + PAR_diffuse_epics(times,sites);

obs_diffuse = SW_diffuse_obss_surf(times,sites);
obs_direct =  SW_direct_obss_surf(times,sites);
obs_par = PAR_total_obss_surf(times,sites);

epic_total = epic_diffuse + epic_direct;
obs_total = obs_diffuse + obs_direct;
%% plot
figure;
colormap jet
set(gcf,'unit','normalized','position',[0.1,0.1,0.82,0.82]);
set(gca, 'Position', [0 0 1 1])

subplot(2,2,1)
plot_density_plot_SW_daily(obs_total, epic_total,'The observed','EPIC','Total SW');
subplot(2,2,2)
plot_density_plot_SW_daily(obs_direct, epic_direct,'The observed','EPIC','Direct SW');
subplot(2,2,3)
plot_density_plot_SW_daily(obs_diffuse, epic_diffuse,'The observed','EPIC','Diffuse SW');
subplot(2,2,4)
plot_density_plot_par_daily(obs_par, epic_par,'The observed','EPIC','Total PAR');

