################################################################################
##                                                                            ##
##           Autor: Christian Herrera           Creado: 2018-05-28            ##
##                                                                            ##
##                                                                            ##
## Funcionamiento:                                                            ##
##   El algoritmo recibe 5 valores y una funcion, este mismo determinara      ##
##   la cantidad de intervalos que necesitara para lograr llegar al valor     ##
##   que queremos aproximar con una cantidad de intervalos especifica.        ##
##   El algoritmo se basa en el Metodo Predictor-Corrector, Usando:           ##
##                                                                            ##
##          Predictor: Euler                                                  ##
##          Corrector: Euler Mejorado                                         ##
##                                                                            ##
##   Dos de los valores que le pasamos deben ser los puntos de inicio, es     ##
##   decir, el valor inicial de la ecuacion diferencial.                      ##
##                                                                            ##
##   Nos devolvera varios valores, los cuales los captaremos en 2 variables.  ##
##   En la primer variable, nos almacenara el valor de la solucion de la      ##
##   ecuacion diferencial evaluada en "aprox" (Es una aproximacion).          ##
##   En la segunda variable, obtendremos una Matriz de 2 columnas, donde se   ##
##   guardaran los resultados de aplicar el metodo en cada intervalo.         ##
##                                                                            ##
##   Por ultimo, el algoritmo devuelve la tabla con los valores hallados para ##
##   cada X(i). El ultimo parametro es el error que permitimos que se cometa, ##
##   el corrector se mantendra haciendo calculos hasta que el error sea menor ##
##   o igual que "e".                                                         ##
##                                                                            ##
################################################################################

function [result, matriz] = predictor_corrector (x0, y0, f, h, aprox, e)
   n = (aprox - x0)/h;
   
   #Calculo los Xi y los Yi 
    X(1) = x0;
    Y(1) = y0;
    for(i=2:n+1)
      X(i) = X(i-1) + h;
      Y(i) = Y(i-1) + h*f(X(i-1) , Y(i-1)); # <- Euler (predictor)
      Orig(i) = Y(i);
      
      W(1)=Y(i);
      j=0;
      do
        j++;
        W(j+1) = Y(i-1) + (h/2)*(f(X(i-1) , Y(i-1)) + f(X(i), W(j))); #<- Corrector
      until(abs(W(j+1)-W(j)) < e)
          
      Y(i)=W(j+1);
    endfor;
    
    #Guardo el resultado final
    result = Y(n+1);
    matriz = [X(:), Y(:)];
endfunction
