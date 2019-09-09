[x,t] = simplefit_dataset;
net = FFNN(1,1,[30],'activation_fun_str_list',{'tanh','purelin'});
net = net.train(x, t,...
                'EpochNum',2000,...
                'LearningRate',0.1);
t_hat = net.predict(x);
figure
hold on
plot(x,t,'-k');
plot(x,t_hat,'-b');
hold off

