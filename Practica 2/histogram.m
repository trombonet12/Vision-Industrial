function h = histogram(image)
    % Inicializamos una columna de 256 ceros para contener el histograma
    h = zeros(256, 1);

    % Obtenemos las dimensiones de la imagen
    [filas, columnas] = size(image);
    
    % Iteramos por todos los pixeles de la imagen
    for i = 1:filas
        for j = 1:columnas
            % Incrementamos el valor del histograma dependiendo de la
            % intensidad. Tenemos que pasar el valor a uint16 para evitar
            % que suceda un Overflow con el valor 256.
            h(uint16(image(i, j)) + 1) = h(uint16(image(i, j)) + 1) + 1;
        end
    end
end