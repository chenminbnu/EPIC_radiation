%% import data
clear all;
close all;
clc;

load('../overall_performance/EPIC_daily.mat');
load('../overall_performance/CAVE_daily.mat');
load('../overall_performance/CERES_daily.mat');

% load('../overall_performance/EPIC_hourly.mat');
% load('../overall_performance/CAVE_hourly.mat');
% load('../overall_performance/CERES_hourly.mat');
load('../overall_performance/Surfrad_daily_all.mat');

RMSEs = zeros(12, 4);
R2s = zeros(12, 4);
Biass =  zeros(12, 4);
RRMSEs = zeros(12, 4);
times_all = 1:1826;
times_all = month(datetime(2015,1,0) + times_all);
for month_i = 1:12
    times = times_all == month_i;
    sitefilters = 1:58;
    a = SW_diffuse_epics(times,sitefilters)+SW_direct_epics(times,sitefilters);
    b = SW_diffuse_syns(times,sitefilters)+SW_direct_syns(times,sitefilters);
    c = SW_diffuse_cave_obss(times,sitefilters) + SW_direct_cave_obss(times,sitefilters);
    d = SW_diffuse_cave_syns(times,sitefilters) + SW_direct_cave_syns(times,sitefilters);
    
    % a = SW_diffuse_epics(times,sites);
    % b = SW_diffuse_syns(times,sites);
    % c = SW_diffuse_cave_obss(times,sites);
    % d = SW_diffuse_cave_syns(times,sites);
    
    % a = SW_direct_epics(times,sites);
    % b = SW_direct_syns(times,sites);
    % c = SW_direct_cave_obss(times,sites);
    % d = SW_direct_cave_syns(times,sites);
    
    filter = a>0 & b>0 & c>0 & d>0;
    a = a(filter);
    b = b(filter);
    c = c(filter);
    d = d(filter);
    
    
    RMSEs(month_i, 3) = sqrt(mean((a-c).^2));
    %     RMSEs(month_i, 2) = sqrt(mean((b-c).^2));
    
    Biass(month_i, 3) = mean(a-c);
    %     Biass(month_i, 3) = mean(b-c);
    RRMSEs(month_i, 3) = sqrt(mean((a-c).^2))/mean(c);
    %     RRMSEs(month_i, 3) = sqrt(mean((b-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(month_i, 3) = R2;
    %     R = corrcoef(b,c);
    %     R = R(1,2);
    %     R2 = R^2;
    %     R2s(month_i, 3) = R2;
    
    %% direct 
    
    a = SW_direct_epics(times,sitefilters);
    b = SW_direct_syns(times,sitefilters);
    c = SW_direct_cave_obss(times,sitefilters);
    d = SW_direct_cave_syns(times,sitefilters);
    
    filter = a>0 & b>0 & c>0 & d>0;
    a = a(filter);
    b = b(filter);
    c = c(filter);
    d = d(filter);
    
    
    RMSEs(month_i, 2) = sqrt(mean((a-c).^2));
    %     RMSEs(month_i, 2) = sqrt(mean((b-c).^2));
   
    Biass(month_i, 2) = mean(a-c);
    %     Biass(month_i, 3) = mean(b-c);
    RRMSEs(month_i, 2) = sqrt(mean((a-c).^2))/mean(c);
    %     RRMSEs(month_i, 3) = sqrt(mean((b-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(month_i, 2) = R2;
    %     R = corrcoef(b,c);
    %     R = R(1,2);
    %     R2 = R^2;
    %     R2s(month_i, 3) = R2;
    
    %% diffuse
    
    a = SW_diffuse_epics(times,sitefilters);
    b = SW_diffuse_syns(times,sitefilters);
    c = SW_diffuse_cave_obss(times,sitefilters);
    d = SW_diffuse_cave_syns(times,sitefilters);
    
    
    filter = a>0 & b>0 & c>0 & d>0;
    a = a(filter);
    b = b(filter);
    c = c(filter);
    d = d(filter);
      
    RMSEs(month_i, 1) = sqrt(mean((a-c).^2));    
    Biass(month_i, 1) = mean(a-c);
    RRMSEs(month_i, 1) = sqrt(mean((a-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(month_i, 1) = R2;

    
    epic_par = PAR_diffuse_epics + PAR_direct_epics;
    obs_par = PAR_total_obss_surf;

   
     %% total PAR
    a = epic_par(times,sitefilters);
    c = obs_par(times,sitefilters);
    
    
    filter = a>0 & c>0;
    a = a(filter);
    c = c(filter);
      
    RMSEs(month_i, 4) = sqrt(mean((a-c).^2));    
    Biass(month_i, 4) = mean(a-c);
    RRMSEs(month_i, 4) = sqrt(mean((a-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(month_i, 4) = R2;
end

