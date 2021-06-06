%Inicializamos
clear; close all; clc;

format compact;
pkg load io;
lang = 2;

%número de clases (las clases representaran emociones para este modelo)
num_labels = 8;

%1) carga de la matriz de características
X = load('matriz_x.txt');

%normalización de datos de entrenamiento
[X mu sigma] = featureNormalize(X);

fprintf('Dimensiones de la Matriz de características: \n')

size(X)

fprintf('Dimensiones del vector Y (vector de etiquetas): \n')

%2) carga del vector de etiquetas
y = load('matriz_y.txt');

size(y)

fprintf('\n Entrenando modelo de regresion logistica (uno contra todos)...\n \n')

lambda = 0.1;

%Optimización de parámetros theta
[all_theta] = oneVsAll(X,y,num_labels,lambda);

save mat_parametros.mat all_theta

archExcel = 'mat_parametros.xlsx'

xlswrite(archExcel,all_theta);
  
fprintf('\n Modelo entrenado correctamente... \n')

pause;

%Carga de características de las imagenes de prueba
%X_pred = load ('C:\Users\charl\Desktop\Tesis 2020\Prueba_Modelo_30\set_prediccion.txt');

%Se exportan lo resultados de las predicciones a un archivo excel
%path_excel = 'C:\Users\charl\Desktop\Tesis 2020\Prueba_Modelo_30\Excel\prueba_modelo_30.xlsx';

%Se normalizan las características de la matriz de características de pruebas
%[X_pred mu sigma] = featureNormalize(X_pred);


%[h,pred] = hipotesisRL(all_theta,X_pred);

%if lang == 1,
%  fprintf('\n \n Resultado: \n \n')
%elseif lang==2,
%  fprintf('\n \n Result: \n \n')
%end

%TraducirResultado(pred,lang);

%xlswrite(path_excel,h);

%pred'
%h
