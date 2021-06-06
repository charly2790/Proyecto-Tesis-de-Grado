function TraducirResultado(pred,lang)
  
  %número de predicciones realizadas
  num_pred = size(pred,2);
  %res = zeros(1,num_pred);
  %lang -> lenguaje
  %1 - español
  %2 - ingles  
  
  for i=1:num_pred
    
    id = pred(i);
    desc = "";
    
    if lang == 1,
      
      if id == 1,
        %desc = "1 - Enojo";
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 1 - Enojo");
      elseif id == 2,
        %desc = "2 - Desprecio"; 
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 2 - Desprecio");
      elseif id == 3,
        %desc = "3 - Asco";
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 3 - Asco");
      elseif id == 4,
        %desc = "4 - Miedo";
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 4 - Miedo");
      elseif id ==5,
        %desc = "5 - Felicidad";
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 5 - Felicidad");
      elseif id==6,
        %desc = "6 - neutral";
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 6 - Neutral");
      elseif id ==7,
        %desc = "7 - tristeza";
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 7 - Tristeza");
      elseif id ==8,
        %desc = "8 - Sorpresa";
        desc = strcat(" Ordinal (",num2str(i),") Resultado: 8 - Sorpresa");
      end
      
   elseif lang == 2,
      
      if id == 1,
        %desc = "1 - Enojo";
        desc = strcat(" Ordinal (",num2str(i),") Result: 1 - Anger");
      elseif id == 2,
        %desc = "2 - Desprecio"; 
        desc = strcat(" Ordinal (",num2str(i),") Result: 2 - Contempt");
      elseif id == 3,
        %desc = "3 - Asco";
        desc = strcat(" Ordinal (",num2str(i),") Result: 3 - Disgust");
      elseif id == 4,
        %desc = "4 - Miedo";
        desc = strcat(" Ordinal (",num2str(i),") Result: 4 - Fear");
      elseif id ==5,
        %desc = "5 - Felicidad";
        desc = strcat(" Ordinal (",num2str(i),") Result: 5 - Happiness");
      elseif id==6,
        %desc = "6 - neutral";
        desc = strcat(" Ordinal (",num2str(i),") Result: 6 - Neutral");
      elseif id ==7,
        %desc = "7 - tristeza";
        desc = strcat(" Ordinal (",num2str(i),") Result: 7 - Sadness");
      elseif id ==8,
        %desc = "8 - Sorpresa";
        desc = strcat(" Ordinal (",num2str(i),") Result: 8 - Surprise");
      end
      
    end  
      
    fprintf(strcat(desc," \n"));
    
  end  

end  