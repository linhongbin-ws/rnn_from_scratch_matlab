[x,t] = simplefit_dataset;
net = FFNN(1,1,[20],'activation_fun_str_list',{'tanh','purelin'});
% net = net.setTrainOpt(x, t,...
%                 'EpochNum',1000,...
%                 'LearningRate',0.1,...
%                 'FreezeLayer', [],...
%                 'AdaptMethod', 'Adam',...
%                 'TrainMethod','BGD',...
%                 'PenaltyMethod','l1weight');

net = net.setTrainOpt(x, t,...
                'EpochNum',1000,...
                'LearningRate',0.1,...
                'FreezeLayer', [],...
                'TrainMethod','BGD',...
                'PenaltyMethod','l1weight');
net = net.start_train();
     
% t_hat = net.predict(x);
% figure(1)
% hold on
% plot(x,t,'-k');
% plot(x,t_hat,'-b');
% hold off

f = figure('Renderer', 'painters', 'Position', [0 0 1920 1080])
daspect([1 1 1])
box off
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])  
movie(net.train_opt_struct.plot_opt_struct.drawNet.record,1,1000)

% f = figure('Renderer', 'painters', 'Position', [0 0 1920 1080])
% drawNet(f, net.net);
