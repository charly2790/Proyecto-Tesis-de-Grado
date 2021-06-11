%Inicializamos
clear; close all; clc;

format compact;
pkg load io;

lang = 1;

%Cargo la matriz de parámetros theta
theta = xlsread('mat_parametros.xlsx');

fprintf('Dimensiones de la matriz de parámetros theta:\n \n')
size(theta)

%Carga de características de las imagenes de prueba
X = load ('C:\Users\charl\Desktop\Tesis 2020\Prueba_Modelo_30\set_prediccion.txt');

%Cantidad de imágenes de prueba
dimMatPrueba = size(X)(:,1);

texto = '\n \nCantidad de imagenes de prueba: \n\n';
num = num2str(dimMatPrueba);
msaje = strcat(texto,num);

fprintf(msaje);


%Se normalizan las características de la matriz de características de pruebas
if dimMatPrueba > 1,
  [X mu sigma] = featureNormalize(X);
end

%realizo las predicciones
[h,pred] = hipotesisRL(theta,X);

if lang == 1,
  fprintf('\n \n Resultado: \n \n')
elseif lang==2,
  fprintf('\n \n Result: \n \n')
end

TraducirResultado(pred,lang);