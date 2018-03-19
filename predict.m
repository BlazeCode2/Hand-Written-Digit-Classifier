function p=predict(Theta1,Theta2,X)


a2=activation(Theta1,X');
h=activation(Theta2,a2);
[val p]=max(h);
p=p';
end