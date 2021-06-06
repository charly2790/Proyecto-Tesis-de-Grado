function [all_theta] = oneVsAll(X, y, num_labels, lambda)

%Cantidad de filas de la matriz de caracter�sticas
m = size(X, 1);
%Cantidad de columnas de la matriz de caracter�sticas
n = size(X, 2);

%Se inicializa una matriz de 0s de i x j, donde 'i' es el n�mero de etiquetas y 'j' el n�mero de caracter�sticas
all_theta = zeros(num_labels, n + 1);

%vector para almacenar iteraci�n a iteraci�n el vector de parametros theta correspondiente a c/ etiqueta(clase)
theta_i = zeros(1,n+1);

% Agrego una columna de 1s a la matriz 'X' (bias unit)
X = [ones(m, 1) X];

%Configuraciones para la funci�n fmincg/fminunc
options = optimset('GradObj','on','MaxIter',1200);

initial_theta = zeros(n + 1, 1);

for i=1:num_labels
  
  [theta_i] = fmincg(@(t)(funcionCostosRL(t,X,(y == i),lambda)),initial_theta,options);
  all_theta(i,:)=theta_i;

end

end
