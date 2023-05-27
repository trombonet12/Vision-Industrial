function nacionalitat = process_nacionalitat(imagen)
    % Transformamos a escala de grises
    I = im2gray(im2double(imagen));
    
    % Encontrar bordes de la imagen
    E = edge(I, 'Canny');
    
    % Encontrar las regiones conexas (caracteres) en la imagen
    props = regionprops(E,'Centroid', 'Area', 'Perimeter', 'MajorAxisLength', 'MinorAxisLength');
    
    % Establecer umbrales para los filtros
    area_minima = 70; 
    area_max = 180; 
    relacion_aspecto_minima = 1; 
    relacion_aspecto_maxima = 1.8; 
    compacidad_minima = 50; 
    distancia_minima = 5;
    
    % Filtrar los centroides por área, relación de aspecto, compacidad y distancia mínima
    centroides_validos =[];
    for i = 1:length(props)
        area = props(i).Area;
        relacion_aspecto = props(i).MajorAxisLength/props(i).MinorAxisLength;
        compacidad = props(i).Perimeter^2/area;
        %fprintf('Centroide: (%.2f, %.2f) - Area: %.2f - Relacion Aspecto: %.2f - Compacidad: %.2f\n', props(i).Centroid(1), props(i).Centroid(2), area, relacion_aspecto, compacidad);
        if props(i).Centroid(1) <= 60 && area < area_max && area > area_minima && relacion_aspecto > relacion_aspecto_minima && relacion_aspecto < relacion_aspecto_maxima && compacidad > compacidad_minima
            % Revisar que el centroide actual tenga una distancia mínima de 5 píxeles con todos los centroides ya guardados
            es_valido = true;
            for j = 1:size(centroides_validos, 1)
                distancia = norm(props(i).Centroid - centroides_validos(j,:));
                if distancia < distancia_minima
                    es_valido = false;
                    break;
                end
            end
            if es_valido
                centroides_validos = [centroides_validos; props(i).Centroid];
            end
        end
    end
    
    %% Detectamos la nacionalidad
    for i = 1:length(centroides_validos(:,1))
        if (length(centroides_validos(:,1)) ~= 1)
            % Obtener las coordenadas del centroide actual
            cx = centroides_validos(i,1);
            cy = centroides_validos(i,2);
            
            % Calcular la región de interés para la letra actual
            roi = [cx-15 cy-15 30 30];
            if roi(1) < 1
                roi(1) = 1;
            end
            if roi(2) < 1
                roi(2) = 1;
            end
            if roi(1)+roi(3) > size(I,2)
                roi(3) = size(I,2)-roi(1);
            end
            if roi(2)+roi(4) > size(I,1)
                roi(4) = size(I,1)-roi(2);
            end
            
            % Segmentar la imagen original utilizando la región de interés
            I_letra = imcrop(I, roi);
            
            % Binarizar la imagen utilizando un umbral adaptativo
            BW = imbinarize(I_letra, graythresh(I_letra));
            % Eliminar los objetos pequeños de la imagen binarizada
            BW = bwareaopen(BW, 50);
            
            % Contar el número de objetos en la imagen binarizada
            [~, num_objetos] = bwlabel(BW);
            num_agujeros = num_objetos - 1;
            % Determinar qué letra es según el número de agujeros
            switch num_agujeros
                case 0
                    letras_detectadas = "GB";
                case 1
                    letras_detectadas = "PL";
                otherwise
                    letras_detectadas = "?";
            end
        else
            letras_detectadas = "D";
        end
    
        nacionalitat = letras_detectadas;
    end
end