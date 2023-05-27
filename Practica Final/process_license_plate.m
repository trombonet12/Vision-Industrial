function matricula = process_license_plate(imagen)

    %% A figure showing the input image in gray scale and its corresponding histogram
    % Transformamos a escala de grises
    I = im2gray(im2double(imagen));

    % Añadimos a la figura
    figure('Name','Matricula Grisos - Histograma');
    subplot(1,2,1), imshow(I), title('Original');
    subplot(1,2,2), imhist(I), title('Histogram');

    %% A figure showing the edges of the image and the original image with the outer lines and the centroids of the letters
    figure('Name','Matricula - Edges y Centroids');
    
    % Encontrar bordes de la imagen
    E = edge(I, 'Canny');
    subplot(1,2,1), imshow(E), title('Edges');
    
    % Encontrar las regiones conexas (caracteres) en la imagen
    props = regionprops(E,'Centroid', 'Area', 'Perimeter', 'MajorAxisLength', 'MinorAxisLength');
    
    % Establecer umbrales para los filtros
    area_minima = 200; 
    area_max = 600; 
    relacion_aspecto_minima = 1; 
    relacion_aspecto_maxima = 4; 
    compacidad_minima = 110; 
    distancia_minima = 5;
    
    % Filtrar los centroides por área, relación de aspecto, compacidad y distancia mínima
    centroides_validos =[ ];
    for i = 1:length(props)
        area = props(i).Area;
        relacion_aspecto = props(i).MajorAxisLength/props(i).MinorAxisLength;
        compacidad = props(i).Perimeter^2/area;
        %fprintf('Centroide: (%.2f, %.2f) - Area: %.2f - Relacion Aspecto: %.2f - Compacidad: %.2f\n', props(i).Centroid(1), props(i).Centroid(2), area, relacion_aspecto, compacidad);
        if area < area_max && area > area_minima && relacion_aspecto > relacion_aspecto_minima && relacion_aspecto < relacion_aspecto_maxima && compacidad > compacidad_minima
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
    
    % Mostrar la imagen original y los bordes
    subplot(1,2,2), imshow(imagen), title('Lineas exteriores con Hough y Centroides');
    
    % Dibujar los centroides de los caracteres válidos
    hold on;
    plot(centroides_validos(:,1), centroides_validos(:,2), 'r*');
    hold off;

    % Aplicar la transformada de Hough para encontrar las líneas verticales de la matrícula
    [H,theta,rho] = hough(E, 'Theta', -89:0.1:89);
    P  = houghpeaks(H,3);
    lines = houghlines(E,theta,rho,P,'FillGap',700);

    hold on;
    x_max = -Inf;
    x_min = Inf;
    line_max = [];
    line_min = [];
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       x = xy(:,1);
       if max(x) > x_max
           x_max = max(x);
           line_max = xy;
       end
       if min(x) < x_min
           x_min = min(x);
           line_min = xy;
       end
    end
    plot(line_max(:,1),line_max(:,2),'LineWidth',2,'Color','green');
    plot(line_min(:,1),line_min(:,2),'LineWidth',2,'Color','green');
    hold off;

    % Aplicar la transformada de Hough para encontrar las líneas horizontales de la matrícula
    [H,theta,rho] = hough(E);
    P  = houghpeaks(H,3);
    lines = houghlines(E,theta,rho,P,'FillGap',700);

    hold on;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    end
    hold off;

    %% A figure showing the image after a thresholding, the skeletons of the letters and the endpoints/branchpoints of the letters
    figure('Name','Matricula - Binarizacion, Esqueletos y Puntos');
    
    % Convertir la imagen a blanco y negro mediante un umbral
    umbral = graythresh(I);
    BW = imbinarize(I,umbral);
    
    % Mostrar la imagen binarizada
    subplot(1,3,1), imshow(BW), title('Binarizacion');
    
    % Encontrar los esqueletos de los caracteres
    esqueletos = bwmorph(BW,'skel',Inf);
    
    % Mostrar los esqueletos de los caracteres
    subplot(1,3,2), imshow(esqueletos), title('Esqueletos');
    
    % Encontrar los puntos finales y de ramificación de los esqueletos de los caracteres
    endpoints = bwmorph(esqueletos,'endpoints');
    branchpoints = bwmorph(esqueletos,'branchpoints');
    
    % Mostrar los puntos finales y de ramificación de los esqueletos de los caracteres
    subplot(1,3,3), imshow(esqueletos), hold on;
    [y,x] = find(endpoints);
    plot(x,y,'r*');
    [y,x] = find(branchpoints);
    plot(x,y,'go');
    hold off;

    %% Detectamos las 3 primeras letras y las imprimimos por pantalla
    letras_detectadas = '';
    for i = 1:min(7, length(centroides_validos))
        % Obtener las coordenadas del centroide actual
        cx = centroides_validos(i,1);
        cy = centroides_validos(i,2);
        
        % Calcular la región de interés para la letra actual
        roi =[cx-45 cy-60 90 120];
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
        skeleton = bwmorph(BW, 'thin', Inf);
        % Eliminar los objetos pequeños de la imagen binarizada
        BW = bwareaopen(BW, 50);
        
        % Contar el número de objetos en la imagen binarizada
        [~, num_objetos] = bwlabel(BW);
        num_agujeros = num_objetos - 1;
        if i<=3
            % Determinar qué letra es según el número de agujeros
            switch num_agujeros
                case 0
                    letra = 'C';
                case 1
                    letra = 'A';
                case 2
                    letra = 'B';
                otherwise
                    letra = '?';
       
            end
        else
             switch num_agujeros
                case 0
                    letra_7=imread('lletres\7.png');
                    letra_7=im2gray(letra_7);
                    letra_7=bwmorph(letra_7, 'thin', Inf);
                    correlacion_7 = normxcorr2(letra_7, skeleton);
                    umbral = 0.31; % Ajusta el umbral según sea necesario
                    posiciones_7 = find(correlacion_7 > umbral);   
                        if posiciones_7~=0
                        letra = '7';
                        else
                        letra = '1';   
                        end  
                case 1
                    letra = '0';
                case 2
                    letra = '8';
                otherwise
                    letra = '?';
       
             end
        end
        % Agregar la letra detectada a la cadena de letras
        letras_detectadas = [letras_detectadas, letra];
    end

    %% Output
    matricula = letras_detectadas;
end