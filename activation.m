function a_next=activation(theta,a_current)
%returns the activation of the next layer. input activation units are
%without bias.
a_current=[ones(1,size(a_current,2));a_current];
z=theta*a_current;
a_next=sigmoid(z);
end
