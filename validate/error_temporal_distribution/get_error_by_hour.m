%% import data
clear all;
close all;
clc;

load('../overall_performance/EPIC_hourly.mat');
load('../overall_performance/CAVE_hourly.mat');
load('../overall_performance/CERES_hourly.mat');
load('../overall_performance/Surfrad_hourly_all.mat');

filename= '../error_spatial_distribution/CERES_SurfObs.201501-201803_daily.nc';

lats_sites =  ncread(filename, 'latitude' );
lons_sites =  ncread(filename, 'longitude' );
lats_sites = lats_sites(1:58);
lons_sites = lons_sites(1:58);
lons_sites(lons_sites>180) = lons_sites(lons_sites>180) - 360;


RMSEs = zeros(24, 4);
R2s = zeros(24, 4);
Biass =  zeros(24, 4);
RRMSEs = zeros(24, 4);
times_all = 1:43824;
times =  1:43824;
times_all = hour(datetime(2015,1,1,times_all,0,0));
times_all(times_all == 0) = 24;


par_total_obss = NaN(43824, 58);
par_total_epics = NaN(43824, 58);
sw_total_obss = NaN(43824, 58);
sw_total_epics = NaN(43824, 58);
sw_direct_obss = NaN(43824, 58);
sw_direct_epics = NaN(43824, 58);
sw_diffuse_obss = NaN(43824, 58);
sw_diffuse_epics = NaN(43824, 58);

%% UTC to local

for i = 1:58

par_total_obs = NaN(43824, 1);
par_total_epic = NaN(43824, 1);
sw_total_obs = NaN(43824, 1);
sw_total_epic = NaN(43824, 1);
sw_direct_obs = NaN(43824, 1);
sw_direct_epic = NaN(43824, 1);
sw_diffuse_obs = NaN(43824, 1);
sw_diffuse_epic = NaN(43824, 1);

times_new = round(times + lons_sites(i)/15);

times_new2 = times_new(times_new>0 & times_new<=43824);
times_filter = times(times_new>0 & times_new<=43824);
par_total_obs(times_new2) = PAR_total_obss_surf(times_filter,i);
par_total_epic(times_new2)  = PAR_direct_epics(times_filter,i) + PAR_diffuse_epics(times_filter,i);
sw_total_obs(times_new2)  = SW_total_obss_surf(times_filter,i);
sw_total_epic(times_new2)  = SW_direct_epics(times_filter,i) + SW_diffuse_epics(times_filter,i);
sw_direct_obs(times_new2)  = SW_direct_obss_surf(times_filter,i);
sw_direct_epic(times_new2)  = SW_direct_epics(times_filter,i);
sw_diffuse_obs(times_new2)  = SW_diffuse_obss_surf(times_filter,i);
sw_diffuse_epic(times_new2)  = SW_diffuse_epics(times_filter,i);



% remove negative
par_total_obss(:,i) = par_total_obs;
par_total_epics(:,i) = par_total_epic;
sw_total_obss(:,i) = sw_total_obs;
sw_total_epics(:,i) = sw_total_epic;
sw_direct_obss(:,i) = sw_direct_obs;
sw_direct_epics(:,i) = sw_direct_epic;
sw_diffuse_obss(:,i) = sw_diffuse_obs;
sw_diffuse_epics(:,i) = sw_diffuse_epic;


end

%% calculate error
for hour_i = 1:24
    times = times_all == hour_i;
    sitefilters = 1:58;
    a = sw_diffuse_epics(times,sitefilters)+sw_direct_epics(times,sitefilters);
    c = sw_diffuse_obss(times,sitefilters)+sw_direct_obss(times,sitefilters);
    
    
    filter = a>0 & c>0;
    a = a(filter);
    c = c(filter);
    
    
    RMSEs(hour_i, 3) = sqrt(mean((a-c).^2));
    Biass(hour_i, 3) = mean(a-c);
    RRMSEs(hour_i, 3) = sqrt(mean((a-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(hour_i, 3) = R2;
    
    %% direct 
    
    a = sw_direct_epics(times,sitefilters);
    c = sw_direct_obss(times,sitefilters);
    
    filter = a>0 & c>0;
    a = a(filter);
    c = c(filter);
    
    
    RMSEs(hour_i, 2) = sqrt(mean((a-c).^2));
    Biass(hour_i, 2) = mean(a-c);
    RRMSEs(hour_i, 2) = sqrt(mean((a-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(hour_i, 2) = R2;
    
    %% diffuse
    
    a = sw_diffuse_epics(times,sitefilters);
    c = sw_diffuse_obss(times,sitefilters);
    
    
    filter = a>0 & c>0;
    a = a(filter);
    c = c(filter);
      
    RMSEs(hour_i, 1) = sqrt(mean((a-c).^2));    
    Biass(hour_i, 1) = mean(a-c);
    RRMSEs(hour_i, 1) = sqrt(mean((a-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(hour_i, 1) = R2;
    
%     epic_par = PAR_diffuse_epics + PAR_direct_epics;
%     obs_par = PAR_total_obss_surf;

   
     %% total PAR
    a = par_total_epics(times,sitefilters);
    c = par_total_obss(times,sitefilters);
       
    filter = a>0 & c>0;
    a = a(filter);
    c = c(filter);
      
    RMSEs(hour_i, 4) = sqrt(mean((a-c).^2));    
    Biass(hour_i, 4) = mean(a-c);
    RRMSEs(hour_i, 4) = sqrt(mean((a-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(hour_i, 4) = R2;
end

