function himage = halfsize(image)
    % Se inicializa la imagen
    himage = uint8(zeros(128,128));
    
    % Se hace una iteración siguiendo grupos de 2x2 pixeles buscando la
    % maxima intensidad
    for i = 1:128
        for j = 1:128
            himage(i,j) = max(max(image((2*i-1):(2*i),(2*j-1):(2*j))));
        end
    end
end




