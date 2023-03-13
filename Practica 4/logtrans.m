function logimage = logtrans(image, c)

    % Aplicamos la formula de la transformación logaritmica.
    logimage = c * log(1 + image);
    
end