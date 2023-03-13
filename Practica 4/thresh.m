function binimage = thresh(image, T)
    
    % Inicialitzam binimage
    binimage = false(size(image,1),size(image,2));
    
    % Aplicam el interval
    binimage(image > T) = true;

end