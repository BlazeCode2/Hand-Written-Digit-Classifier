function W=randomInitializeWeights(L_in,L_out)

%takes the input layer size and output layer size, gives back a randomly
%initialized theta matrix with bias unit inlcuded of size L_out x (L_in+1)

epsilon=sqrt(6/(L_in+L_out));
W=(rand(L_out,L_in+1)*2-1)*epsilon;

end