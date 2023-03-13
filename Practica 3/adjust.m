function imadj = adjust(image)

    % Obtenemos las dimensiones de la imagen
    [filas, columnas] = size(image);
    
    % Inicializamos una imagen para su salida.
    imadj = zeros(filas,columnas);

    % Calculamos el minimo y el maximo de la imagen
    Imin = min(image(:));
    Imax = max(image(:));
    OMax = 1.0;
    OMin = 0.0;

    % Iteramos por todos los pixeles de la imagen aplicando la formula
    for i = 1:filas
        for j = 1:columnas
            imadj(i,j) = (OMax - OMin) * ((image(i,j)-Imin)/(Imax - Imin)) + OMin;
        end
    end
end