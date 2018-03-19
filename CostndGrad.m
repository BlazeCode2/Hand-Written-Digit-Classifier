function [J grad]=CostndGrad(nn_para,input_layer_size,hidden_layer_size,labels,X,y,lambda)

%This returns the cost of the NN with given data, and also calculates the
%gradients of the parameters which are unrolled into a vector

%reconstructing parameter matrices
numel_T1=hidden_layer_size*(input_layer_size+1);
numel_T2=labels*(hidden_layer_size+1);
Theta_1=reshape(nn_para(1:numel_T1),hidden_layer_size,input_layer_size+1);
Theta_2=reshape(nn_para(numel_T1+1:end),labels,hidden_layer_size+1);

%calculate cost
m=size(X,1);
a1=X';
a2=activation(Theta_1,a1);
h=activation(Theta_2,a2);
y_vec=vectorize_y(y,labels);
log_h=log(h);
log_1_h=log(1-h);
temp= y_vec.*log_h+(1-y_vec).*log_1_h;
T1=Theta_1(:,2:end);
T2=Theta_2(:,2:end);
T=[T1(:);T2(:)];
J=(-(sum(temp(:)))./m) + (lambda*(T'*T))/(2*m);

d3=h-y_vec;
d2=(Theta_2'*d3);
d2=d2(2:end,:).*g_prime(a2);
Theta_1(:,1)=0;
Theta_2(:,1)=0;

Theta1_grad=(d2*([ones(1,size(a1,2));a1])'+lambda*Theta_1)./m;
Theta2_grad=(d3*([ones(1,size(a2,2));a2])'+lambda*Theta_2)./m;
grad=[Theta1_grad(:);Theta2_grad(:)];

end