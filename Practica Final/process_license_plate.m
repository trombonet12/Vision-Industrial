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
    props = regionprops(E, 'Centroid');

    % Mostrar la imagen original y los bordes
    subplot(1,2,2), imshow(imagen), title('Lineas exteriores y Centroides');
    hold on;

    % Dibujar los bordes de la imagen
    B = bwboundaries(E);
    for k = 1:length(B)
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
    end

    % Dibujar los centroides de los caracteres
    for k = 1:length(props)
        c = props(k).Centroid;
        plot(c(1), c(2), 'r.', 'MarkerSize', 10);
    end

    %% Output
    matricula = 1;
end