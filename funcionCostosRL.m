function [J, grad] = funcionCostosRL(theta, X, y, lambda)

%Cantidad de ejemplos de entrenamiento
m = length(y);

J = 0;

grad = zeros(size(theta));


%Calculo de polinomio 'z'
z = X*theta;

%Se aplica la función sigmoide al polinomio 'z'
h = sigmoide(z);


%Quitamos la columna Theta0 p/ regularización, initial_theta tiene 28x1
cant_filas = size(theta)(:,1);

%la matriz theta_reg resulta en una de 27x1
theta_reg = theta([2:cant_filas],1);


%Se calcula el costo de haber para los parámetros theta actuales
J = (1/m)*[(-y'*log(h))-((1-y')*log(1-h))] + (lambda/(2*m)*sum(theta_reg.^2));

temp0 = (X(:,1))'*(1/m)*(h-y);


temp1 = ((1/m)*((h-y)'*(X(:,[2:cant_filas]))))+((lambda/m)*theta_reg)';

grad = [temp0 temp1];

grad = grad(:);

end
