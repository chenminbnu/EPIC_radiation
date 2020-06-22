load('results.mat');

RRMSEs = RRMSEs*100;

figure
set(gcf,'unit','normalized','position',[0.1,0.1,0.85,0.2]);
set(gca, 'Position', [ 0 0 1 1])

subplot(1,4,1)
hold on
plot(Biass(:,1), 'r', 'linewidth',1)
plot(Biass(:,2), 'g', 'linewidth',1)
plot(Biass(:,3), 'b', 'linewidth',1)
plot(Biass(:,4), 'k', 'linewidth',1)
box on
xlim([1 12])
ylim([-20 20])
xlabel('Month')
ylabel('Bias (W/m^2)')
set(gca, 'fontsize',10)

subplot(1,4,2)
hold on
plot(RMSEs(:,1), 'r', 'linewidth',1)
plot(RMSEs(:,2), 'g', 'linewidth',1)
plot(RMSEs(:,3), 'b', 'linewidth',1)
plot(RMSEs(:,4), 'k', 'linewidth',1)
box on
xlim([1 12])
ylim([0 60])
xlabel('Month')
ylabel('RMSE (W/m^2)')
set(gca, 'fontsize',10)

subplot(1,4,3)
hold on
plot(RRMSEs(:,1), 'r', 'linewidth',1)
plot(RRMSEs(:,2), 'g', 'linewidth',1)
plot(RRMSEs(:,3), 'b', 'linewidth',1)
plot(RRMSEs(:,4), 'k', 'linewidth',1)
box on
xlim([1 12])
ylim([0 50])

xlabel('Month')
ylabel('RRMSE (%)')
set(gca, 'fontsize',10)

subplot(1,4,4)
hold on
plot(R2s(:,1), 'r', 'linewidth',1)
plot(R2s(:,2), 'g', 'linewidth',1)
plot(R2s(:,3), 'b', 'linewidth',1)
plot(R2s(:,4), 'k', 'linewidth',1)
box on
xlim([1 12])
ylim([0 1])
xlabel('Month')
ylabel('R^2')
set(gca, 'fontsize',10)

