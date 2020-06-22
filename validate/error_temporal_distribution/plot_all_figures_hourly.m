load('results_hourly.mat');

RRMSEs = RRMSEs*100;

figure
set(gcf,'unit','normalized','position',[0.1,0.1,0.85,0.2]);
set(gca, 'Position', [ 0 0 1 1])

subplot(1,4,1)
hold on
plot(7:18, Biass(7:18,1), 'r', 'linewidth',1)
plot(7:18, Biass(7:18,2), 'g', 'linewidth',1)
plot(7:18, Biass(7:18,3), 'b', 'linewidth',1)
plot(7:18, Biass(7:18,4), 'k', 'linewidth',1)
box on
xlim([7 18])
ylim([-20 20])
xlabel('Hour') 
ylabel('Bias (W/m^2)')
set(gca, 'fontsize',10)

subplot(1,4,2)
hold on
plot(7:18, RMSEs(7:18,1), 'r', 'linewidth',1)
plot(7:18, RMSEs(7:18,2), 'g', 'linewidth',1)
plot(7:18, RMSEs(7:18,3), 'b', 'linewidth',1)
plot(7:18, RMSEs(7:18,4), 'k', 'linewidth',1)
box on
xlim([7 18])
ylim([0 200])
xlabel('Hour') 
ylabel('RMSE (W/m^2)')
set(gca, 'fontsize',10)

subplot(1,4,3)
hold on
plot(7:18, RRMSEs(7:18,1), 'r', 'linewidth',1)
plot(7:18, RRMSEs(7:18,2), 'g', 'linewidth',1)
plot(7:18, RRMSEs(7:18,3), 'b', 'linewidth',1)
plot(7:18, RRMSEs(7:18,4), 'k', 'linewidth',1)
box on
xlim([7 18])
ylim([0 100])

xlabel('Hour') 
ylabel('RRMSE (%)')
set(gca, 'fontsize',10)

subplot(1,4,4)
hold on
plot(7:18, R2s(7:18,1), 'r', 'linewidth',1)
plot(7:18, R2s(7:18,2), 'g', 'linewidth',1)
plot(7:18, R2s(7:18,3), 'b', 'linewidth',1)
plot(7:18, R2s(7:18,4), 'k', 'linewidth',1)
box on
xlim([7 18])
ylim([0 1])
xlabel('Hour') 
ylabel('R^2')
set(gca, 'fontsize',10)

