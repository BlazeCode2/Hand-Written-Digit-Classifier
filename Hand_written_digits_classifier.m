%W.M.R.R.Wickramasinghe
%==================Neural Network to Classify Hand Written Digits==========
%% 
%=====================load dataset=========================================
clear all,close all,clc;
%load training dataset
X=(loadMNISTImages('train-images.idx3-ubyte'))';
y=(loadMNISTLabels('train-labels.idx1-ubyte'));
idx=find(y==0);
y(idx)=10;
%load test set
X_test=(loadMNISTImages('t10k-images.idx3-ubyte'))';
y_test=(loadMNISTLabels('t10k-labels.idx1-ubyte'));
idx=find(y_test==0);
y_test(idx)=10;

ex=size(y,1);
idx=randperm(ex);

%Training set
X_train=X(idx(1:50000),:);
y_train=y(idx(1:50000),:);

%Cross validation set
X_val=X(idx(50001:end),:);
y_val=y(idx(50001:end),:);



%% 
%===================Data visualization=====================================
displayData(X_train(1:100,:));

%% 
%===================Neural Network properties==============================
input_layer_size=size(X_train,2);%without bias unit
output_layer_size=10;
hidden_layer_size=25;

%% 
%===================Find a good lambda=====================================
Theta_1=randomInitializeWeights(input_layer_size,hidden_layer_size);
Theta_2=randomInitializeWeights(hidden_layer_size,output_layer_size);
initial_theta=[Theta_1(:);Theta_2(:)];
options =optimset('MaxIter', 50);
lambdas=[0 0.01 0.02 0.04 0.08 0.16 0.32 0.64 1.28 2.56 5.12 10.24];
error=zeros(size(lambdas,2),1);

for idx=1:size(lambdas,2)
costFunction = @(p) CostndGrad(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   output_layer_size, X_train, y_train, lambdas(idx));
                               
[nn_params, cost] = fmincg(costFunction, initial_theta, options);
Jval(idx)=CostndGrad(nn_params,input_layer_size,hidden_layer_size,output_layer_size, X_val, y_val, 0);
end
[minimum_J idx]=min(Jval);
lambda=lambdas(idx);
fprintf('Optimum lambda value : %f \n',lambda);



%% 

%===================Train Neural Network===================================
Theta_1=randomInitializeWeights(input_layer_size,hidden_layer_size);
Theta_2=randomInitializeWeights(hidden_layer_size,output_layer_size);
initial_theta=[Theta_1(:);Theta_2(:)];
options =optimset('MaxIter', 50);
lambda=0.32;%comment this to proceed with the optimum lambda
costFunction = @(p) CostndGrad(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   output_layer_size, X_train, y_train, lambda);
                               
[nn_params, cost] = fmincg(costFunction, initial_theta, options);
u1=hidden_layer_size*(input_layer_size+1);
Theta1=reshape(nn_params(1:u1),hidden_layer_size,input_layer_size+1);
Theta2=reshape(nn_params(u1+1:end),output_layer_size,hidden_layer_size+1);
%saving the parameters
save 'nn_weights.mat' Theta1 Theta2
%% 
%==========================Check accuracy==================================
p=predict(Theta1,Theta2,X_train);
accuracy=mean(double(p==y_train));
fprintf('\n Acquired an accuracy of %.2f%% on the training set',accuracy*100);

p=predict(Theta1,Theta2,X_val);
accuracy=mean(double(p==y_val));
fprintf('\n Acquired an accuracy of %.2f%% on the cross validation set',accuracy*100);

%% 
%============================Use neural network============================
clear all,close all,clc;

load('nn_weights.mat');
X_test=(loadMNISTImages('t10k-images.idx3-ubyte'))';
%shuffle set
idx=randperm(size(X_test,1));
X_test=X_test(idx,:);
for i=1:size(X_test,1)
    X=X_test(i,:);
    displayData(X);
    pred=predict(Theta1,Theta2,X);
    t=['Predicted as : ',num2str(mod(pred,10))];
    title(t,'FontSize',24);
    pause;
end
    

%% 
%====================Use NN for camera inputs==============================

clc,clear all,close all;
load('nn_weights.mat');


while true
     X=image_output();
%      X=imageTo28x28Gray(100,0);
    figure(2);
    displayData(X);
    pred=predict(Theta1,Theta2,X);
    t=['Predicted as : ',num2str(mod(pred,10))];
    title(t,'FontSize',24);
    pause(1);
end