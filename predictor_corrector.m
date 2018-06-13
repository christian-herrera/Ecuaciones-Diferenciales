function [retval] = predictor_corrector (x0, y0, f, h, aprox, e)
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
    printf("Segun Predictor: "); Orig
    printf("\nSegun Corrector: "); Y
endfunction
