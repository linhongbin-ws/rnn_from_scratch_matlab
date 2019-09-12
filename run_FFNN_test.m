%generate_sim_data_CAD;
net = FFNN(6,5,[30 30],'activation_fun_str_list',{'tanh','tanh','purelin'});
net = net.setTrainOpt(input_mat(1:6,:), output_mat(2:6,:),...
                'EpochNum',50,...
                'LearningRate',0.9,...
                'FreezeLayer', [],...
                'TrainMethod','BGD');
net.train_opt_struct.miniBatch_ratio = 0.01;
net = net.start_train();   


