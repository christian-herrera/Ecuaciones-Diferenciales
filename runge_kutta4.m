################################################################################
##                                                                            ##
##           Autor: Christian Herrera           Creado: 2018-05-28            ##
##                                                                            ##
##                                                                            ##
## Funcionamiento:                                                            ##
##   El algoritmo recibe 4 o 5 valores y una funcion, este mismo determinara  ##
##   la cantidad de intervalos que necesitara para lograr llegar al valor     ##
##   que queremos aproximar con una cantidad de intervalos especifica.        ##
##   El algoritmo se basa en el Metodo de Runge-Kutta de orden 4.             ##
##                                                                            ##
##   Funciona realizando calculos de forma recursiva. Su ecuacion para hacer  ##
##   los calculos es la siguiente:                                            ##
##             Y(i+1) = Y(i) + (h/6)*[ K1 + 2*K2 + 2*K3 + K4 ]                ##
##                                                                            ##
##   Con: K1 = f( X(i),Y(i) )                                                 ##
##        K2 = f( X(i)+h/2,Y(i)+h/2*K1 )                                      ##
##        K3 = f( X(i)+h/2,Y(i)+h/2*K2 )                                      ##
##        K3 = f( X(i)+h, Y(i)+h*K3 )                                         ##
##                                                                            ##
##   Dos de los valores que le pasamos deben ser los puntos de inicio, es     ##
##   decir, el valor inicial de la ecuacion diferencial.                      ##
##                                                                            ##
##   Nos devolvera varios valores, los cuales los captaremos en 2 variables.  ##
##   En la primer variable, nos almacenara el valor de la solucion de la      ##
##   ecuacion diferencial evaluada en "aprox" (Es una aproximacion).          ##
##   En la segunda variable, obtendremos una Matriz de 2 columnas, donde se   ##
##   guardaran los resultados de aplicar euler en cada intervalo.             ##
##                                                                            ##
##   Por ultimo, el algoritmo devuelve la tabla con los valores hallados para ##
##   cada X(i). Esto esta habilitado siempre y cuando se le pase un 1 como    ##
##   ultimo parametro o si no se le pasa este ultimo valor.                   ##
##   En caso de no querer mostrar la tabla, se le pasara como ultimo          ##
##   parametro, un valor distinto de 1.                                       ##
##                                                                            ##
################################################################################

function [result, matriz] = runge_kutta4 (x0, y0, f, h, aprox, mostrar_tabla=1)
  clc;
  #Determino cuantos intervalos necesito para llegar a "aprox"
  n = (aprox - x0)/h;
  
  #determino si es posible hacer el calculo
  if(mod(n,1) != 0)
    printf("Error, No hay una cantidad entera de intervalos para llegar a x=%f con h=%f\n", aprox, h);
    result = 0;
    matriz = [0, 0];
  else
    #Calculo los Xi y los Yi
    X(1) = x0;
    Y(1) = y0;
    for(i=2:n+1)
      K1 = f(X(i-1), Y(i-1));
      K2 = f(X(i-1) + h/2, Y(i-1) + (h/2)*K1);
      K3 = f(X(i-1) + h/2, Y(i-1) + (h/2)*K2);
      K4 = f(X(i-1) + h, Y(i-1) + h*K3);
      X(i) = X(i-1) + h;
      Y(i) = Y(i-1) + (h/6)*(K1 + 2*K2 + 2*K3 + K4);
    endfor;
    
    #Imprimo en consola la tabla
    if(mostrar_tabla)
      printf(" n    |        Xn        |        Yn     \n------------------------------------------\n");
      for(i=1:n+1)
        if(i <= 10)
          printf(" %i    |   %.10f   |   %.10f\n", i-1, X(i), Y(i) );
        elseif(i > 10 & i <= 100)
          printf(" %i   |   %.10f   |   %.10f\n", i-1, X(i), Y(i) );
        elseif(i > 100)
          printf(" %i  |   %.10f   |   %.10f\n", i-1, X(i), Y(i) );
        endif
      endfor
    endif
    printf("Resultado Final: Y(%i)≈%.10f\n", aprox, Y(n+1));
    
    #Guardo el resultado final
    result = Y(n+1);
    matriz = [X(:), Y(:)];
  endif
endfunction
