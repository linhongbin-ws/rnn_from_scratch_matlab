load('./data/Real_Joint4_10Reps/Real_Joint4_10Reps_pos.mat');
load('./data/Real_Joint4_10Reps/Real_Joint4_10Reps_tor.mat');
train_input_mat = input_mat(4,1:500);
train_output_mat = output_mat(4,1:500);
train_input_mat = train_input_mat(1:4:end)
train_output_mat = train_output_mat(1:4:end)

fixWindowLength = 3;
train_input_cell = {};
train_output_cell = {};
% cut data into cells with fix window
for i = 1:size(train_input_mat,2)-fixWindowLength+1
    train_input_cell = vertcat(train_input_cell, {train_input_mat(:,i:i+fixWindowLength-1)});
    train_output_cell = vertcat(train_output_cell, {train_output_mat(:,i:i+fixWindowLength-1)});
end
train_input_cell = train_input_cell.';
train_output_cell = train_output_cell.';


net = RNN(1,1,[10,5],'activation_fun_str_list',{'tanh','tanh','purelin'});
%net = RNN(1,1,[10],'activation_fun_str_list',{'relu','purelin'});
net = net.train(train_input_cell,...
                train_output_cell,...
                'EpochNum',500,...
                'LearningRate',0.3);

test_input_cell = {train_input_mat};
y_hat_list = net.predict(train_input_cell);
y_hat = [];
for i = 1:size(y_hat_list,2)
    y_hat = [y_hat y_hat_list{i}(:,end)];
end
x = rad2deg(train_input_mat);

y_hat_list2 = net.predict(test_input_cell)

figure
hold on
plot(x, train_output_mat,'-k');
plot(x(fixWindowLength:end),y_hat,'-b');
%plot(x, y_hat_list2{1}, '-g')
hold off

