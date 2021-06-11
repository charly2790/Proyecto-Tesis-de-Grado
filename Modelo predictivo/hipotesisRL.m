function [h,p] = hipotesisRL(all_theta, X)  
%1) all_theta es la matriz de par�metros theta / ser� una matriz de 8 x 136 
%   1 a) 8 es el n�mero de emociones
%   1 b) 136 es el n�mero de parametros que se corresponde con 68 valores en 'X' m�s 68 valores en 'Y'
%2) X es la matriz de caracter�sticas del set de im�genes de prueba / tendra n x 136 donde:
%   2 a) 'n' es el n�mero de elementos a predecir
%   2 b) 136 es el n�mero de parametros que se corresponde con 68 valores en 'X' m�s 68 valores en 'Y'

m = size(X, 1);
num_labels = size(all_theta, 1);

p = zeros(size(X, 1), 1);
h = zeros(num_labels,m);

% Se agrega una columna de unos a l (bios unit)
X = [ones(m, 1) X];

%Polinomio 'z'
z = (all_theta*X');

%Se aplica funci�n sigmoide al polinomio 'z' y se almacena la salida de los clasificadores en 'h'
h = sigmoide(z);


[val,p]=max(h);


end