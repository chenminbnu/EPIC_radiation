% SW_diffuse_obss_surf = NaN(43824, 85);
% SW_direct_obss_surf = NaN(43824, 85);
% SW_total_obss_surf = NaN(43824, 85);
% PAR_total_obss_surf = NaN(43824, 85);
% 
% SW_diffuse_obss_surf(:,[20 18 26 11 33 17 14]) = SW_diffuse_obss(:,2:8);
% SW_direct_obss_surf(:,[20 18 26 11 33 17 14]) = SW_direct_obss(:,2:8);
% SW_total_obss_surf(:,[20 18 26 11 33 17 14]) = SW_total_obss(:,2:8);
% PAR_total_obss_surf(:,[20 18 26 11 33 17 14]) = PAR_total_obss(:,2:8);


SW_diffuse_obss_surf1 = SW_diffuse_obss_surf;
SW_direct_obss_surf1 = SW_direct_obss_surf;
SW_total_obss_surf1 = SW_total_obss_surf;
PAR_total_obss_surf1 = PAR_total_obss_surf;

SW_diffuse_obss_surf1(SW_diffuse_obss_surf1<0) = 0;
SW_direct_obss_surf1(SW_direct_obss_surf1<0) = 0;
SW_total_obss_surf1(SW_total_obss_surf1<0) = 0;
PAR_total_obss_surf1(PAR_total_obss_surf1<0) = 0;

SW_diffuse_obss_surf = NaN(1826, 85);
SW_direct_obss_surf = NaN(1826, 85);
SW_total_obss_surf = NaN(1826, 85);
PAR_total_obss_surf = NaN(1826, 85);

for k = 1:1826
    SW_diffuse_obss_surf(k,:) = nanmean(SW_diffuse_obss_surf1(((k-1)*24 + 1):(k*24),:), 1);
     SW_direct_obss_surf(k,:) = nanmean(SW_direct_obss_surf1(((k-1)*24 + 1):(k*24),:), 1);
      SW_total_obss_surf(k,:) = nanmean(SW_total_obss_surf1(((k-1)*24 + 1):(k*24),:), 1);
       PAR_total_obss_surf(k,:) = nanmean(PAR_total_obss_surf1(((k-1)*24 + 1):(k*24),:), 1);
end
