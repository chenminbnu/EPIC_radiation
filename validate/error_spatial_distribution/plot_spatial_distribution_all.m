load('hourly_error_each_site.mat');
plot_spatial_distribution_bias_hourly(Biass(:,1), '(a) Bias (W/m^2)', 'hourly_a_Bias')
plot_spatial_distribution_RMSE_hourly(RMSEs(:,1), '(b) RMSE (W/m^2)', 'hourly_b_RMSE')
plot_spatial_distribution_RRMSE_hourly(RRMSEs(:,1), '(c) RRMSE (%)', 'hourly_c_RRMSE')
plot_spatial_distribution_R2_hourly(R2s(:,1), '(d) R^2', 'hourly_d_R2')

load('daily_error_each_site.mat');
plot_spatial_distribution_bias_daily(Biass(:,1), '(a) Bias (W/m^2)', 'daily_a_Bias')
plot_spatial_distribution_RMSE_daily(RMSEs(:,1), '(b) RMSE (W/m^2)', 'daily_b_RMSE')
plot_spatial_distribution_RRMSE_daily(RRMSEs(:,1), '(c) RRMSE (%)', 'daily_c_RRMSE')
plot_spatial_distribution_R2_daily(R2s(:,1), '(d) R^2', 'daily_d_R2')

