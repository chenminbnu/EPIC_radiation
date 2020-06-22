clc;
clear all;
close all;

load('../validate/overall_performance/EPIC_hourly.mat');
load('../validate/overall_performance/CAVE_hourly.mat');
load('../validate/overall_performance/CERES_hourly.mat');
load('../validate/overall_performance/Surfrad_hourly_all.mat');

filename= '../validate/error_spatial_distribution/CERES_SurfObs.201501-201803_daily.nc';

lats_sites =  ncread(filename, 'latitude' );
lons_sites =  ncread(filename, 'longitude' );
lats_sites = lats_sites(1:58);
lons_sites = lons_sites(1:58);
lons_sites(lons_sites>180) = lons_sites(lons_sites>180) - 360;

figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.8,0.8]);
set(gca, 'Position', [ 0 0 1 1])

sites = [20 18 26 11 33 17 14];
sitenames = {'BON','BOS','DRA','FPK','GCR','PSU', 'SXF'};
serials = {'(a)','(b)','(c)','(d)','(e)','(f)', '(g)'};

for i = 1:7
subplot(3,3,i)
times = 1:43824;%1:1826;%732:1826;

par_total_obs = NaN(43824, 1);
par_total_epic = NaN(43824, 1);
sw_total_obs = NaN(43824, 1);
sw_total_epic = NaN(43824, 1);
sw_direct_obs = NaN(43824, 1);
sw_direct_epic = NaN(43824, 1);
sw_diffuse_obs = NaN(43824, 1);
sw_diffuse_epic = NaN(43824, 1);

times_new = round(times + lons_sites(sites(i))/15);

times_new2 = times_new(times_new>0 & times_new<=43824);
times_filter = times(times_new>0 & times_new<=43824);
par_total_obs(times_new2) = PAR_total_obss_surf(times_filter,sites(i));
par_total_epic(times_new2)  = PAR_direct_epics(times_filter,sites(i)) + PAR_diffuse_epics(times_filter,sites(i));
sw_total_obs(times_new2)  = SW_total_obss_surf(times_filter,sites(i));
sw_total_epic(times_new2)  = SW_direct_epics(times_filter,sites(i)) + SW_diffuse_epics(times_filter,sites(i));
sw_direct_obs(times_new2)  = SW_direct_obss_surf(times_filter,sites(i));
sw_direct_epic(times_new2)  = SW_direct_epics(times_filter,sites(i));
sw_diffuse_obs(times_new2)  = SW_diffuse_obss_surf(times_filter,sites(i));
sw_diffuse_epic(times_new2)  = SW_diffuse_epics(times_filter,sites(i));



% remove negative
par_total_obs(par_total_obs<0) = 0;
par_total_epic(par_total_epic<0) = 0;
sw_total_obs(sw_total_obs<0) = 0;
sw_total_epic(sw_total_epic<0) = 0;
sw_direct_obs(sw_direct_obs<0) = 0;
sw_direct_epic(sw_direct_epic<0) = 0;
sw_diffuse_obs(sw_diffuse_obs<0) = 0;
sw_diffuse_epic(sw_diffuse_epic<0) = 0;

%% keep consistency
filters = par_total_obs>0 & par_total_epic>0;
par_total_obs(~filters) = nan;
par_total_epic(~filters) = nan;

%% reshape to diurnal
par_total_obs = reshape(par_total_obs, 24, 1826);
par_total_epic = reshape(par_total_epic, 24, 1826);
sw_total_obs = reshape(sw_total_obs, 24, 1826);
sw_total_epic = reshape(sw_total_epic, 24, 1826);
sw_direct_obs =  reshape(sw_direct_obs, 24, 1826);
sw_direct_epic =  reshape(sw_direct_epic, 24, 1826);
sw_diffuse_obs =  reshape(sw_diffuse_obs, 24, 1826);
sw_diffuse_epic = reshape(sw_diffuse_epic, 24, 1826);


skyls = sw_diffuse_obs./sw_total_obs;
skyls(skyls>1 | skyls<=0) = nan;
skyconditions = ones(1826, 1);
skyconditions(sum(skyls<=0.3, 1)>0.7*sum(skyls>0, 1)) = 0;
skyconditions(sum(skyls>=0.7, 1)>0.7*sum(skyls>0, 1)) = 2;

hold on
obs_clear = nanmean(sw_direct_obs(:,skyconditions == 0), 2);
epic_clear = nanmean(sw_direct_epic(:,skyconditions == 0), 2);
obs_cloudy = nanmean(sw_direct_obs(:,skyconditions == 1), 2);
epic_cloudy = nanmean(sw_direct_epic(:,skyconditions == 1), 2);
obs_overcast = nanmean(sw_direct_obs(:,skyconditions == 2), 2);
epic_overcast = nanmean(sw_direct_epic(:,skyconditions == 2), 2);

obs_clear(isnan(obs_clear)) = 0;
epic_clear(isnan(epic_clear)) = 0;
obs_cloudy(isnan(obs_cloudy)) = 0;
epic_cloudy(isnan(epic_cloudy)) = 0;
obs_overcast(isnan(obs_overcast)) = 0;
epic_overcast(isnan(epic_overcast)) = 0;

plot(obs_clear, 'k-', 'linewidth', 1)
plot(epic_clear, 'r-', 'linewidth', 1)
plot(obs_cloudy, 'k--', 'linewidth', 1)
plot(epic_cloudy, 'r--', 'linewidth', 1)
plot(obs_overcast, 'k:', 'linewidth', 1)
plot(epic_overcast, 'r:', 'linewidth', 1)

filters = obs_clear>0;
a = obs_clear(filters);
b = epic_clear(filters);
RRMSE_clear = sqrt(mean((a-b).^2))/mean(a);


filters = obs_cloudy>0;
a = obs_cloudy(filters);
b = epic_cloudy(filters);
RRMSE_cloudy = sqrt(mean((a-b).^2))/mean(a);

filters = obs_overcast>0;
a = obs_overcast(filters);
b = epic_overcast(filters);
RRMSE_overcast = sqrt(mean((a-b).^2))/mean(a);


% plot(nanmean(par_total_obs(:,skyconditions == 0), 2), 'k-')
% plot(nanmean(par_total_epic(:,skyconditions == 0), 2), 'r-')
% plot(nanmean(par_total_obs(:,skyconditions == 1), 2), 'k--')
% plot(nanmean(par_total_epic(:,skyconditions == 1), 2), 'r--')
% plot(nanmean(par_total_obs(:,skyconditions == 2), 2), 'k:')
% plot(nanmean(par_total_epic(:,skyconditions == 2), 2), 'r:')

% plot(nanmean(sw_direct_obs(:,skyconditions == 0), 2), 'k-')
% plot(nanmean(sw_direct_epic(:,skyconditions == 0), 2), 'r-')
% plot(nanmean(sw_direct_obs(:,skyconditions == 1), 2), 'k--')
% plot(nanmean(sw_direct_epic(:,skyconditions == 1), 2), 'r--')
% plot(nanmean(sw_direct_obs(:,skyconditions == 2), 2), 'k:')
% plot(nanmean(sw_direct_epic(:,skyconditions == 2), 2), 'r:')

% plot(nanmean(sw_diffuse_obs(:,skyconditions == 0), 2), 'k-')
% plot(nanmean(sw_diffuse_epic(:,skyconditions == 0), 2), 'r-')
% plot(nanmean(sw_diffuse_obs(:,skyconditions == 1), 2), 'k--')
% plot(nanmean(sw_diffuse_epic(:,skyconditions == 1), 2), 'r--')
% plot(nanmean(sw_diffuse_obs(:,skyconditions == 2), 2), 'k:')
% plot(nanmean(sw_diffuse_epic(:,skyconditions == 2), 2), 'r:')

xlim([1 24])
ylim([0 1250])
text(1.2, 1150, ['RRMSE_{clear}:' num2str(RRMSE_clear*100,'%.2f') '%'], 'fontsize', 8,'fontweight','bold')
text(1.2, 1030, ['RRMSE_{cloudy}:' num2str(RRMSE_cloudy*100,'%.2f') '%'], 'fontsize', 8, 'fontweight','bold')
text(1.2, 910, ['RRMSE_{overcast}:' num2str(RRMSE_overcast*100,'%.2f') '%'], 'fontsize', 8, 'fontweight','bold')

title([serials{i} ' SURFRAD - ' sitenames{i}])
xlabel('Hour')
ylabel('Direct SW (W/m^2)')
box on
set(gca, 'linewidth', 1, 'fontsize', 10)
if(i == 7)
 h=legend({'Observations under clear sky', ...
     'EPIC-derived under clear sky', ...
     'Observations under cloudy sky', ...
     'EPIC-derived under cloudy sky', ...
     'Observations under overcast sky', ...
     'EPIC-derived under overcast sky', ...
     }, 'location','eastoutside', 'fontsize', 10);
  %  title(h,'W/m^2','fontsize',8);
    set(h,'position',[0.435 0.115 0.18 0.21])
    
end
end


%% save file
print(gcf, '-dtiff', '-r600', 'direct_sw.tif')

close all