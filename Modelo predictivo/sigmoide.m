function p = sigmoide(z)
%Función sigmoide
  %entrada: función polinómica 'z' 

  p = 1.0 ./ (1.0 + exp(-z));

end
