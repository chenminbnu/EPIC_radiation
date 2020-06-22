%% import data
load('EPIC_daily.mat');
load('CAVE_daily.mat');
load('CERES_daily.mat');

load('EPIC_hourly.mat');
load('CAVE_hourly.mat');
load('CERES_hourly.mat');

RMSEs = zeros(58, 2);
R2s = zeros(58, 2);
Biass =  zeros(58, 2);
RRMSEs = zeros(58, 2);

for site_i = 1:58
    sites = site_i;
    times = 1:43824;%1:1826;%732:1826;
    a = SW_diffuse_epics(times,sites)+SW_direct_epics(times,sites);
    b = SW_diffuse_syns(times,sites)+SW_direct_syns(times,sites);
    c = SW_diffuse_cave_obss(times,sites) + SW_direct_cave_obss(times,sites);
    d = SW_diffuse_cave_syns(times,sites) + SW_direct_cave_syns(times,sites);
    
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
    
    
    RMSEs(site_i, 1) = sqrt(mean((a-c).^2));
    RMSEs(site_i, 2) = sqrt(mean((b-c).^2));
    
    Biass(site_i, 1) = mean(a-c);
    Biass(site_i, 2) = mean(b-c);
    RRMSEs(site_i, 1) = sqrt(mean((a-c).^2))/mean(c);
    RRMSEs(site_i, 2) = sqrt(mean((b-c).^2))/mean(c);
    
    R = corrcoef(a,c);
    R = R(1,2);
    R2 = R^2;
    R2s(site_i, 1) = R2;
    R = corrcoef(b,c);
    R = R(1,2);
    R2 = R^2;
    R2s(site_i, 2) = R2;
    
    
    
end

