clear all %#ok<CLALL> 
close all
clc

disp("Lab 9: Image processing and feature extraction");

%% Descriptors

%% APPLE

I_original = imread('apple.jpg');
I = im2gray(im2double(I_original));

figure('Name','Apple - Histogram');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

% Hemos aprovechado que la imagen está en RGB para hacer diferentes pruebas
% basandonos en los tres canales de la imagen para ver si alguno de ellos
% es mejor respecto a los otros. En este caso el mejor es el canal azul
 
blueChannel = I_original(:,:,3); % blue channel

I = im2gray(im2double(blueChannel));

% Como la imagen tiene sombras hemos hecho este bucle para obtener el
% umbral en el cual desaparecen y solo nos quedamos con el objeto
figure('Name','apple - thresholds - blue');

for i = 1:25
    I_aux = imbinarize(I, i/25);
    subplot(5,5,i), imshow(I_aux), title(i/25);
end

% Como vemos se eliminó en el 0.44

I = imbinarize(I, 0.44);
I = imopen(I, strel('disk', 3));
I = imcomplement(I);
I = imfill(I,'holes');

figure('Name','apple - binary - blue');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Final');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
apple = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');

%% BELL

I_original = imread('bell.jpg');
I = im2gray(im2double(I_original));


figure('Name','bell - Histogram - blue ');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

% Hemos aprovechado que la imagen está en RGB para hacer diferentes pruebas
% basandonos en los tres canales de la imagen para ver si alguno de ellos
% es mejor respecto a los otros. En este caso el mejor es el canal azul

blueChannel = I_original(:,:,3); % blue channel

I = im2gray(im2double(blueChannel));


% Como la imagen tiene sombras hemos hecho este bucle para obtener el
% umbral en el cual desaparecen y solo nos quedamos con el objeto
figure('Name','bell - thresholds - blue');

for i = 1:25
    I_aux = imbinarize(I, i/25);
    subplot(5,5,i), imshow(I_aux), title(i/25);
end

% Como se ve el mejor umbral es 0.44

I = imbinarize(I, 0.44);
I = imopen(I, strel('disk', 7));
I = imcomplement(I);
I = imfill(I,'holes');

figure('Name','bell - binary - blue');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Final');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
bell = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');

%% SHOE

I_original = imread('shoe.jpg');
I = im2gray(im2double(I_original));

figure('Name','shoe - Histogram');
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

I = imbinarize(I);
I = imopen(I, strel('disk', 3));
I = imcomplement(I);
I = imfill(I,'holes');

figure('Name','shoe - Binary');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Binary');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
shoeAux = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');
shoe.Area = (shoeAux(1).Area + shoeAux(2).Area)/2;
shoe.Orientation = (shoeAux(1).Orientation + shoeAux(2).Orientation)/2;
shoe.Eccentricity = (shoeAux(1).Eccentricity + shoeAux(2).Eccentricity)/2;
shoe.Solidity = (shoeAux(1).Solidity + shoeAux(2).Solidity)/2;


%% FORK

I_original = imread('fork.jpg');
I = im2gray(im2double(I_original));

figure('Name','fork - Histogram');
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

I = imbinarize(I);
I = imfill(I,'holes');

figure('Name','fork - Binary');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Binary');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
fork = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');


%% ANALISIS

%Cargamos los datos
areas = [apple.Area, bell.Area, shoe.Area, fork.Area];
orientations = [apple.Orientation, bell.Orientation, shoe.Orientation, fork.Orientation];
eccentricities = [apple.Eccentricity, bell.Eccentricity, shoe.Eccentricity, fork.Eccentricity];
solidities = [apple.Solidity, bell.Solidity, shoe.Solidity, fork.Solidity];

%Normalizamos los datos
areas = areas/max(areas);
orientations = orientations/max(orientations);
eccentricities = eccentricities/max(eccentricities);
solidities = solidities/max(solidities);

%Array de datos y etiquetas
variables = [areas; orientations; eccentricities; solidities];
labels =  ["areas", "orientations", "eccentricities", "solidities"];

%% Primer analisis
%Buscamos la variable con mayor desviación estandard
stds = [std(areas), std(orientations), std(eccentricities), std(solidities)];
[~, idx] = sort(stds,'descend');

fprintf("Las mejores features basandonos en mayor desviación estandard media son: %s y %s", labels(idx(1)), labels(idx(2)));

%% Segundo análisis
%Buscamos la mayor distancia media entre todas las variables.
figure('Name','Analisis');
k = 1;
avgAux = 0;
for i = 1:4
    for j = 1:4
        subplot(4,4,k), plot(variables(i,:), variables(j,:), 'o');

        xlabel(labels(i));
        ylabel(labels(j));

        % Calculate the average distance between the points
        dist = pdist([variables(i,:);variables(j,:)]);
        avg = mean(dist);
       
        if avg > avgAux
            avgAux = avg;
            avgIdx = [i, j];
        end
        k=k+1;
    end 
end


fprintf("Las mejores features basandonos en mayor distancia de medias son: %s y %s \n", labels(avgIdx(1)), labels(avgIdx(2)));