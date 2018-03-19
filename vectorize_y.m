function y_vec=vectorize_y(y,labels)
%given a column vector y , returns a vectorized y of labels x m matrix
m=size(y,1);
y_vec=zeros(m,labels);
for i=1:labels
    y_vec(:,i)=(y==i);
end
y_vec=y_vec';
end