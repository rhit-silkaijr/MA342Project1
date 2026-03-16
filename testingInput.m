A = importdata('naca2418.dat.txt');
X = points_based_on_input(A,10)
plot(X(:,1),X(:,2))