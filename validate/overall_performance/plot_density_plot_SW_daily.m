function plot_density_plot_SW_daily(obs,estimate,x_text, y_text, title_text)
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
plot([0,500],[0,500],'k','Linewidth',1.5)
 scatplot(obs, estimate,'circle')
 %scatter(obs, estimate)
 axis equal

axis([0 500 0 500])

xlabel(x_text);
ylabel(y_text);
title(title_text)
text(25,480,['Bias = ' num2str(Bias,'%.2f')],'FontSize',9, 'FontWeight', 'Bold');
%text(25,1000,['MAE = ' num2str(MAE,'%.2f')],'FontSize',9);
text(25,450,['RMSE = ' num2str(RMSE,'%.2f')],'FontSize',9, 'FontWeight', 'Bold');
text(25,420,['RRMSE = ' num2str(RRMSE,'%.2f') '%'],'FontSize',9, 'FontWeight', 'Bold');

text(25,385,['R^2 = ' num2str(R2,'%.2f')],'FontSize',9, 'FontWeight', 'Bold');

% pars=polyfit(obs,estimate,1);
% %plot([0 range(1,2)],[polyval(pars,0) ,polyval(pars,range(1,2))],'k','Linewidth',1.5)
% a = pars(1,1);
% b = pars(1,2);
set(gca,'FontSize',10,'Linewidth',2, 'xTick', 0:100:500, 'xTicklabel', 0:100:500, ...
    'yTick', 0:100:500, 'yTicklabel', 0:100:500);
% saveas(gcf, [title_text, '.png'])
end


