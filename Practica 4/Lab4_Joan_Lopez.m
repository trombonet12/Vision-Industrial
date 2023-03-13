clear all %#ok<CLALL> 
close all
clc

disp("Lab 4: Image Enhancement (Point Processing and Thresholding)");

disp("Negative transformations");

disp("1. Open the image breast.tif and convert it to the range of values [0.0, 1.0].");

% Abrimos la imagen, la pasamos a formato double y la convertimos al rango
% requerido.
BREAST = mat2gray(im2double(imread("breast.tif")));

disp("2. Obtain the negative of this image using the provided function in Matlab.");
% Con la imagen abierta anteriormente le aplicamos el negativo.
NEGBREAST = imcomplement(BREAST);

disp("3. Display in a figure both images and their correspondent histograms.");
figure('Name', 'Negative transformations');
subplot(2,2,1);
imshow(BREAST);
subplot(2,2,2);
imhist(BREAST);
subplot(2,2,3);
imshow(NEGBREAST);
subplot(2,2,4);
imhist(NEGBREAST);

disp("4. What can be observed? What is the effect of applying the negative transformation to the image?");
disp("Comparando ambos histogramas podemos ver que el negativo es el espejo del original.");



disp("Log transformations");

disp("1. Write a function in Matlab to transform a gray scale image using the logarithmic transformation.");

disp("2. Open the image light.tif and convert it to [0.0, 1.0].");
LIGHT = mat2gray(im2double(imread("light.tif")));

disp("3. Apply the logtrans function to this image.");
LIGHTLOG = logtrans(LIGHT, 1);

disp("4. Display in the same figure both images and their correspondents histograms.");
figure('Name', 'Log transformations');
subplot(2,2,1);
imshow(LIGHT);
subplot(2,2,2);
imhist(LIGHT);
subplot(2,2,3);
imshow(LIGHTLOG);
subplot(2,2,4);
imhist(LIGHTLOG);

disp("5. What can be observed? What is the effect of applying the log transformation to the image?");
disp("Aplicando la transformación logaritmica podemos ver con más detalle la imagen ya que aparece un rango de blancos más amplio");

% ----------------------------------------------------------------------------

disp("Power Law transformations");

disp("1. Write a function in Matlab to transform a gray scale image using a power law transformation.");

disp("2. Display the image spine.jpg and its histogram.");
SPINE = mat2gray(im2double(imread("spine.jpg")));
figure('Name', 'Spine');
subplot(1,2,1);
imshow(SPINE);
subplot(1,2,2);
imhist(SPINE);

disp("3. If a lighter image is wanted, which values of γ do we need to use: lower or higher than 1?");
disp("Si queremos una imagen más blanca tenemos que usar un γ menor que 1.");

disp("4. Using different values of γ, obtain three lighter versions of the image. Show the resulting images and their correspondent histograms.");
% Generamos 3 versiones más claras de la columna
SPINELIGHT1 = powerlaw(SPINE,0.75);
SPINELIGHT2 = powerlaw(SPINE,0.5);
SPINELIGHT3 = powerlaw(SPINE,0.25);

% Mostramos por pantalla las transformaciones y sus histogramas.
figure('Name', 'Spine Transformation');
subplot(3,2,1);
imshow(SPINELIGHT1);
subplot(3,2,2);
imhist(SPINELIGHT1);
subplot(3,2,3);
imshow(SPINELIGHT2);
subplot(3,2,4);
imhist(SPINELIGHT2);
subplot(3,2,5);
imshow(SPINELIGHT3);
subplot(3,2,6);
imhist(SPINELIGHT3);

disp("5. Which image would you use for a further processing step? Why?");
disp("Yo usaría SPINELIGHT2 porque es la que mejor se ve sin llegar a quemar la imagen.");

disp("6. Display the image landscape.jpg and its histogram.");
LANDSCAPE = mat2gray(im2double(imread("landscape.jpg")));
figure('Name', 'Landscape');
subplot(1,2,1);
imshow(LANDSCAPE);
subplot(1,2,2);
imhist(LANDSCAPE);

disp("7. Enhance the image using three power law transformations.");
% Generamos 3 versiones más oscuras de la imagen usando γ mayores que 1.
LANDSCAPE1 = powerlaw(LANDSCAPE,2.5);
LANDSCAPE2 = powerlaw(LANDSCAPE,5);
LANDSCAPE3 = powerlaw(LANDSCAPE,10);

disp("8. Show the resulting images and their correspondent histograms.");
% Mostramos por pantalla las transformaciones y sus histogramas.
figure('Name', 'Landscape Transformation');
subplot(3,2,1);
imshow(LANDSCAPE1);
subplot(3,2,2);
imhist(LANDSCAPE1);
subplot(3,2,3);
imshow(LANDSCAPE2);
subplot(3,2,4);
imhist(LANDSCAPE2);
subplot(3,2,5);
imshow(LANDSCAPE3);
subplot(3,2,6);
imhist(LANDSCAPE3);

disp("9. Which image would you use for a further processing step? Why?");
disp("Me quedaría con la segunda imagen, con la que usa el gamma 5, ya que es la que nos da un mejor nivel de detalle a nivel general."),


% ----------------------------------------------------------------------------

disp("Thresholding");

disp("1. Open the image screws.jpg and display it");
SCREWS = mat2gray(im2double(im2gray(imread("screws.jpg"))));
figure('Name', 'Screws');
subplot(1,2,1);
imshow(SCREWS);
subplot(1,2,2);
imhist(SCREWS);

disp("2. In order to separate the screws from the background, what might be a good range of intensities for thresholding? Justify your answer graphically.");
disp("Como el fondo es completamente blanco, el rango sería establecer una T cercana al 0.5.");

disp("3. Write a function in Matlab to apply a thresholding operation to an image.");

disp("4. Binarize the image screws.jpg using the function written in the previous exercise and display the results");

% Aplicamos nuestra función.
SCREWST1 = thresh(SCREWS, 0.6);

figure('Name', 'Screws Binarize');
imshow(SCREWST1);

disp("5. Binarize the image screws.jpg using the Matlab function provided to this end, display the results and compare them with the ones obtained in the previous exercise.");

% Aplicamos la función de matlab.
SCREWST2 = im2bw(SCREWS,0.6);

figure('Name', 'Binarized Screws Comparation');
subplot(1,2,1);
imshow(SCREWST1);
subplot(1,2,2);
imshow(SCREWST2);

disp("6. Analyze the Matlab function graythresh. What does it do? Use it for binarizing screws.jpg and display the results.");

% La función graythresh es una función de procesamiento de imágenes 
% de MATLAB que se utiliza para calcular automáticamente el valor umbral 
% óptimo para la segmentación de una imagen en blanco y negro. El umbral 
% óptimo se calcula utilizando el método de Otsu, que es una técnica de 
% umbralización de imágenes que maximiza la varianza entre las dos clases 
% de píxeles en una imagen en blanco y negro. El valor umbral devuelto 
% por graythresh es un valor en el rango [0,1] y se utiliza como un valor 
% de umbral en una función de segmentación de imágenes. El valor de umbral 
% calculado por graythresh se basa en la distribución de intensidad de 
% la imagen y es adecuado para imágenes con bimodalidad, lo que significa 
% que la distribución de intensidad de la imagen tiene dos picos claramente 
% definidos. Si la imagen no es bimodal, el valor de umbral 
% puede no ser óptimo.

% Aplicamos nuestra función con graythresh.
SCREWST3 = thresh(SCREWS, graythresh(SCREWS));

figure('Name', 'Binarized Screws with graythresh');
imshow(SCREWST3);






