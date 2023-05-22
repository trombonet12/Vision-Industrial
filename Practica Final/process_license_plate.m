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
    props = regionprops(E,'Centroid', 'Eccentricity');
    
    % Establecer un umbral máximo para la excentricidad de las regiones conexas
    excentricidad_maxima = 0.05; % ajusta este valor según tus necesidades
    
    % Filtrar los centroides por excentricidad máxima
    centroides_validos = [];
    for i = 1:length(props)
        if props(i).Eccentricity > excentricidad_maxima
            centroides_validos = [centroides_validos; props(i).Centroid];
        end
    end
    
    % Mostrar la imagen original y los bordes
    subplot(1,2,2), imshow(imagen), title('Lineas exteriores con Hough y Centroides');
    
    % Dibujar los centroides de los caracteres válidos
    hold on;
    plot(centroides_validos(:,1), centroides_validos(:,2), 'r*');
    hold off;

    %% Output
    matricula = 1;
end