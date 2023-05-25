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
    area_minima = 100; 
    area_max = 600; 
    relacion_aspecto_minima = 1; 
    relacion_aspecto_maxima = 4; 
    compacidad_minima = 110; 
    
    % Filtrar los centroides por área, relación de aspecto y compacidad
    centroides_validos =[ ];
    for i = 1:length(props)
        area = props(i).Area;
        relacion_aspecto = props(i).MajorAxisLength/props(i).MinorAxisLength;
        compacidad = props(i).Perimeter^2/area;
        %fprintf('Centroide: (%.2f, %.2f) - Area: %.2f - Relacion Aspecto: %.2f - Compacidad: %.2f\n', props(i).Centroid(1), props(i).Centroid(2), area, relacion_aspecto, compacidad);
        if area < area_max && area > area_minima && relacion_aspecto > relacion_aspecto_minima && relacion_aspecto < relacion_aspecto_maxima && compacidad > compacidad_minima
            centroides_validos = [centroides_validos; props(i).Centroid];
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
        
    % Binarizar la imagen utilizando un umbral adaptativo
    BW = imbinarize(I, graythresh(I));
    
    % Eliminar los objetos pequeños de la imagen binarizada
    BW = bwareaopen(BW, 30);
    
    % Realizar una erosión y una dilatación para eliminar pequeños huecos en los caracteres
    SE = strel('disk',2);
    BW = imerode(BW, SE);
    BW = imdilate(BW, SE);
    subplot(1,3,1), imshow(BW), title('Binarizacion');
        
    % Obtener el esqueleto de la imagen binarizada
    skeleton = bwmorph(BW, 'thin', Inf);
    subplot(1,3,2), imshow(skeleton), title('Esqueleto');
    
    % Obtener los puntos finales y de ramificación del esqueleto
    endpoints = bwmorph(skeleton, 'endpoints');
    branchpoints = bwmorph(skeleton, 'branchpoints');
    subplot(1,3,3), imshow(skeleton), title('Puntos');
    hold on;
    [x_end, y_end] = find(endpoints);
    plot(y_end,x_end,'r.','MarkerSize',10);
    [x_br, y_br] = find(branchpoints);
    plot(y_br,x_br,'b.','MarkerSize',10);
    hold off;

    %% Output
    matricula = 1;
end