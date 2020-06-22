function plot_density_plot_par_hourly(obs,estimate,x_text, y_text, title_text)
obs0 = obs;
estimate0 = estimate;
obs = obs(obs0>0 & estimate0>0);
estimate = estimate(obs0>0 & estimate0>0);

obs = obs(:);
estimate = estimate(:);

R = corrcoef(obs,estimate);
R = R(1,2);
R2 = R^2;
RMSE = sqrt(mean((obs-estimate).^2));
Bias = mean((estimate-obs));
%MAE = mean(abs((obs-estimate)));
RRMSE = RMSE/(mean(obs))*100;

% figure
hold on
box on
colormap jet

plot([0,610],[0,610],'k','Linewidth',1.5)
 scatplot(obs, estimate,'circle')
 %scatter(obs, estimate)
axis equal
axis([0 610 0 610])
xlabel(x_text);
ylabel(y_text);
title(title_text)

text(15,590,['Bias = ' num2str(Bias,'%.2f')],'FontSize',9, 'FontWeight', 'Bold');
%text(15,450,['MAE = ' num2str(MAE,'%.2f')],'FontSize',9);
text(15,552,['RMSE = ' num2str(RMSE,'%.2f')],'FontSize',9, 'FontWeight', 'Bold');
text(15,514,['RRMSE = ' num2str(RRMSE,'%.2f') '%'],'FontSize',9, 'FontWeight', 'Bold');

text(15,472,['R^2 = ' num2str(R2,'%.2f')],'FontSize',9, 'FontWeight', 'Bold');


% text(5,400,['Bias = ' num2str(Bias,'%.4f')],'FontSize',15);
% text(5,380,['MAE = ' num2str(MAE,'%.4f')],'FontSize',15);
% text(5,360,['RMSE = ' num2str(RMSE,'%.4f')],'FontSize',15);
% pars=polyfit(obs,estimate,1);
% plot([0 range(1,2)],[polyval(pars,0) ,polyval(pars,range(1,2))],'k','Linewidth',1.5)
% a = pars(1,1);
% b = pars(1,2);
% text(5,340,['R^2 = ' num2str(R2,'%.4f')],'FontSize',15);
% text(5,320,['y = ' num2str(a,'%.4f') '*x + ' num2str(b,'%.4f')],'FontSize',15);

set(gca,'FontSize',10,'Linewidth',2, 'xTick', 0:200:600, 'xTicklabel', 0:200:600, ...
    'yTick', 0:200:600, 'yTicklabel', 0:200:600);


% saveas(gcf, [title_text, '.png'])
end