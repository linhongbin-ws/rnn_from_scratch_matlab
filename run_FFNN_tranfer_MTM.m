generate_sim_data_CAD;
net = FFNN(6,5,[30 30],'activation_fun_str_list',{'tanh','tanh','purelin'});
net = net.setTrainOpt(input_mat(1:6,:), output_mat(2:6,:),...
                'EpochNum',500,...
                'LearningRate',1,...
                'FreezeLayer', [],...
                'TrainMethod','BGD',...
                'AdaptMethod', 'AdaGrad',...
                'PenaltyMethod','l1weight');
net.train_opt_struct.miniBatch_ratio = 0.03;
net.train_opt_struct.plot_opt_struct.drawNet.updateRate = 1;
net = net.start_train();   

%%
load('./data/MTMR_all_couple/Real_MTMR_pos_4096.mat');
load('./data/MTMR_all_couple/Real_MTMR_tor_4096.mat');
pos_mat = input_mat;
tor_mat = output_mat;

load('./data/MTMR_all_couple/Real_MTMR_pos_4096_reverse.mat');
load('./data/MTMR_all_couple/Real_MTMR_tor_4096_reverse.mat');
pos_mat = [pos_mat,input_mat];
tor_mat = [tor_mat,output_mat];

net_target = FFNN(6,5,[30 30],'activation_fun_str_list',{'tanh','tanh','purelin'});
net_target.net = net.net; 
net_target = net_target.setTrainOpt(pos_mat(1:6,:), tor_mat(2:6,:),...
                'EpochNum',500,...
                'LearningRate',1,...
                'FreezeLayer', [],...
                'TrainMethod','BGD',...
                'AdaptMethod', 'AdaGrad',...
                'PenaltyMethod','l1weight');
net_target.train_opt_struct.miniBatch_ratio = 0.03;
net_target = net_target.start_train();   

