function p = sigmoide(z)
%Funci�n sigmoide
  %entrada: funci�n polin�mica 'z' 

  p = 1.0 ./ (1.0 + exp(-z));

end
