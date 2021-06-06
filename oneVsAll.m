function [all_theta] = oneVsAll(X, y, num_labels, lambda)

%Cantidad de filas de la matriz de características
m = size(X, 1);
%Cantidad de columnas de la matriz de características
n = size(X, 2);

%Se inicializa una matriz de 0s de i x j, donde 'i' es el número de etiquetas y 'j' el número de características
all_theta = zeros(num_labels, n + 1);

%vector para almacenar iteración a iteración el vector de parametros theta correspondiente a c/ etiqueta(clase)
theta_i = zeros(1,n+1);

% Agrego una columna de 1s a la matriz 'X' (bias unit)
X = [ones(m, 1) X];

%Configuraciones para la función fmincg/fminunc
options = optimset('GradObj','on','MaxIter',1200);

initial_theta = zeros(n + 1, 1);

for i=1:num_labels
  
  [theta_i] = fmincg(@(t)(funcionCostosRL(t,X,(y == i),lambda)),initial_theta,options);
  all_theta(i,:)=theta_i;

end

end
