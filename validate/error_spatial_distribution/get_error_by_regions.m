%% import data
clear all;
close all;
clc;

% load('../overall_performance/EPIC_daily.mat');
% load('../overall_performance/CAVE_daily.mat');
% load('../overall_performance/CERES_daily.mat');

load('../overall_performance/EPIC_hourly.mat');
load('../overall_performance/CAVE_hourly.mat');
load('../overall_performance/CERES_hourly.mat');

RMSEs = zeros(3, 3);
R2s = zeros(3, 3);
Biass =  zeros(3, 3);
RRMSEs = zeros(3, 3);
load('site_type.mat');
sitetype(sitetype==3) = 2;
sitetype(sitetype==4) = 3;
for site_i = 1:3
    times = 1:43824;%1:1826;%732:1826;1:43824;%
    sitefilters = sitetype == site_i;
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
    
    
    RMSEs(site_i, 3) = sqrt(mean((a-c).^2));
    %     RMSEs(site_i, 2) = sqrt(mean((b-c).^2));
    
    Biass(site_i, 3) = mean(a-c);
    %     Biass(site_i, 3) = mean(b-c);
    RRMSEs(site_i, 3) = sqrt(mean((a-c).^2))/mean(c);
    %     RRMSEs(site_i, 3) = sqrt(mean((b-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(site_i, 3) = R2;
    %     R = corrcoef(b,c);
    %     R = R(1,2);
    %     R2 = R^2;
    %     R2s(site_i, 3) = R2;
    
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
    
    
    RMSEs(site_i, 2) = sqrt(mean((a-c).^2));
    %     RMSEs(site_i, 2) = sqrt(mean((b-c).^2));
    
    Biass(site_i, 2) = mean(a-c);
    %     Biass(site_i, 3) = mean(b-c);
    RRMSEs(site_i, 2) = sqrt(mean((a-c).^2))/mean(c);
    %     RRMSEs(site_i, 3) = sqrt(mean((b-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(site_i, 2) = R2;
    %     R = corrcoef(b,c);
    %     R = R(1,2);
    %     R2 = R^2;
    %     R2s(site_i, 3) = R2;
    
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
    
    
    RMSEs(site_i, 1) = sqrt(mean((a-c).^2));
    %     RMSEs(site_i, 2) = sqrt(mean((b-c).^2));
    
    Biass(site_i, 1) = mean(a-c);
    %     Biass(site_i, 3) = mean(b-c);
    RRMSEs(site_i, 1) = sqrt(mean((a-c).^2))/mean(c);
    %     RRMSEs(site_i, 3) = sqrt(mean((b-c).^2))/mean(c);
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(site_i, 1) = R2;
    %     R = corrcoef(b,c);
    %     R = R(1,2);
    %     R2 = R^2;
    %     R2s(site_i, 3) = R2;
end

