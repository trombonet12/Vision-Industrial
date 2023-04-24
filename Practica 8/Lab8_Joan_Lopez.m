clear all %#ok<CLALL> 
close all
clc

disp("Lab 8: Morphological Image Processing");

%% Erosion and Dilation

%% 1. Load the image morph1.jpg and binarize it
I  = imbinarize(im2gray(im2double(imread('morph1.jpg'))));

%% 2. Erode the binary image using disks of radius 5, 10 and 20, respectively. 
% Display the results and the original image in the same figure. 
% Using these images, explain the effects produced by the erosion operation.

I5 = imerode(I, strel('disk', 5));
I10 = imerode(I, strel('disk', 10));
I20 = imerode(I, strel('disk', 20));

figure('Name', 'Erosion');
subplot(2,2,1), imshow(I), title('Original');
subplot(2,2,2), imshow(I5), title('Eroded 5');
subplot(2,2,3), imshow(I10), title('Eroded 10');
subplot(2,2,4), imshow(I20), title('Eroded 20');

% La erosión se usa para eliminar objetos pequeños de la imagen


%% 3. Write a code to automatically count the number of circles in the 
% image circles.jpg. Display the output image
I = imbinarize(im2gray(im2double(imread('circles.jpg'))));

I7 = imerode(I, strel('disk', 7));

figure('Name', 'Contar Circulos');
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imshow(I7), title('Eroded 7');

[~, numFill] = bwlabel(I7);
disp(numFill);


%% 4. Load the image text.jpg and binarize it
I = imbinarize(im2gray(im2double(imread('text.jpg'))));

figure('Name', 'Text');
imshow(I), title('Text');


%% 5. Improve the quality of the text using a dilation operation. Perform 
% the operation using several structuring elements available in the strel
% function and display the results. Using these images, explain the effects
% produced by the dilation operation

I_diamond = imdilate(I, strel('diamond', 3));
I_disk = imdilate(I, strel('disk', 3));
I_octagon = imdilate(I, strel('octagon', 3));
I_cross = imdilate(I, strel('line', 3, 0));
I_rect = imdilate(I, strel('rectangle', [3 3]));
I_square = imdilate(I, strel('square', 3));
% Hemos puesto un tamaño de 3 ya que el octogono necesita que el tamaño sea
% multiplo de 3

figure('Name', 'Dilation text');
subplot(2,3,1), imshow(I_diamond), title('Diamond');
subplot(2,3,2), imshow(I_disk), title('Disk');
subplot(2,3,3), imshow(I_octagon), title('Octagon');
subplot(2,3,4), imshow(I_cross), title('Cross');
subplot(2,3,5), imshow(I_rect), title('Rectangle');
subplot(2,3,6), imshow(I_square), title('Square');
% Se puede apreciar que obtenemos el mismo resultado con el cuadrado y con
% el rectángulo ya que un rectangulo de 3x3 es un cuadrado de 3x3


%% 6. Load the image licoln.jpg and binarize it
I = imbinarize(im2gray(im2double(imread('licoln.jpg'))));


%% 7. Obtain the boundaries of the image combining an erosion or dilation 
% operation with the original image.
I_dilation = imdilate(I, strel('disk', 3));
I_erosion = imerode(I, strel('disk',3));

boundariesDil = I_dilation - I;
boundariesEro = I - I_erosion;
boundaries = boundariesEro + boundariesDil;
figure('Name', 'Boundaries');
subplot(1,3,1),imshow(boundariesDil), title("Dilatation - Image");
subplot(1,3,2),imshow(boundariesEro), title("Image - Erosion");
subplot(1,3,3), imshow(boundaries), title("Dilatation - Erosion");
% Hemos probado de sumar las dos imagenes (boundariesDil i boundariesElo)
% esta suma basicamente es restar la erosión a la dilatacion


%% Opening and Closing

%% 1. Load the image shapes.jpg  and apply a threshold in order to obtain 
% a binary image
I = im2gray(im2double(imread('shapes.jpg')));

threshold = graythresh(I);
I = imbinarize(I, threshold);

figure('Name', 'Shapes');
imshow(I), title('Shapes');


%% 2. Perform opening operations using squares of different sizes as
% structuring elements. Display the results and observe the effects produced 
% by the opening operation
I_15 = imopen(I, strel('square', 15));
I_19 = imopen(I, strel('square', 19));
I_23 = imopen(I, strel('square', 23));
I_27 = imopen(I, strel('square', 27));

figure('Name', 'Shapes Opening');
subplot(2,2,1), imshow(I_15), title('Opening 15');
subplot(2,2,2), imshow(I_19), title('Opening 19');
subplot(2,2,3), imshow(I_23), title('Opening 23');
subplot(2,2,4), imshow(I_27), title('Opening 27');

% Como podemos ver el opening elimina los objetos mas pequeños que no
% cumplen con las condiciones de la estructura. 


%% 3. Perform closing operations using squares of different sizes as 
% structuring elements. Display the results and observe the effects 
% produced by the closing operation.
I_15 = imclose(I, strel('square', 15));
I_19 = imclose(I, strel('square', 19));
I_23 = imclose(I, strel('square', 23));
I_27 = imclose(I, strel('square', 27));

figure('Name', 'Shapes Closing');
subplot(2,2,1), imshow(I_15), title('Closing 15');
subplot(2,2,2), imshow(I_19), title('Closing 19');
subplot(2,2,3), imshow(I_23), title('Closing 23');
subplot(2,2,4), imshow(I_27), title('Closing 27');


% Como podemos ver el closing elimina los agujeros mas pequeños que no
% cumplen con las condiciones de la estructura.


%% 4. Load the image fingerprint.jpg and apply a threshold in order to 
%  obtain a binary image.
I = im2gray(im2double(imread('fingerprint.jpg')));

threshold = graythresh(I);
I = imbinarize(I, threshold);

figure('Name', 'Fingerprint');
imshow(I), title('Fingerprint');

%% 5. Improve the quality of the fingerprint using a combination of opening 
% and closing operations and display the final results

I_CO_Square_3 = imclose(imopen(I, strel('square', 3)), strel('square', 3));
I_OC_Square_3 = imopen(imclose(I, strel('square', 3)), strel('square', 3));

I_CO_Rect_3 = imclose(imopen(I, strel('rectangle', [3 3])), strel('rectangle', [3 3]));
I_OC_Rect_3 = imopen(imclose(I, strel('rectangle', [3 3])), strel('rectangle', [3 3]));

I_CO_Cross_3 = imclose(imopen(I, strel('line', 3, 0)), strel('line', 3, 0));
I_OC_Cross_3 = imopen(imclose(I, strel('line', 3, 0)), strel('line', 3, 0));

figure('Name', 'Fingerprint CO y OC');
subplot(3,2,1), imshow(I_CO_Square_3), title('CO Square 3');
subplot(3,2,2), imshow(I_OC_Square_3), title('OC Square 3');

subplot(3,2,3), imshow(I_CO_Rect_3), title('CO Rect 3');
subplot(3,2,4), imshow(I_OC_Rect_3), title('OC Rect 3');

subplot(3,2,5), imshow(I_CO_Cross_3), title('CO Cross 3');
subplot(3,2,6), imshow(I_OC_Cross_3), title('OC Cross 3');

% Hemos probado de hacer el OC y el CO con un disco de tamaños 3, 5, 7 y 9
% pero los resultados son muy malos. También hemos mirado de hacerlo con un
% cuadrado de tamaño 5, 7 y 9 pero el resultado tambien era malo


%% Exercises

%% 1. Load the image letters2.jpg. Apply a threshold in order to obtain a binary image.
I = im2gray(im2double(imread('letters.jpg')));

threshold = graythresh(I);
I = imbinarize(I, threshold);

figure('Name', 'Letters');
imshow(I);

%% 2. Apply erosion, dilation, opening and closing transformations to the 
% image using the following structuring elements:

G1 = ones(3,3);
G2 = [1 0 1];
G3 = [0 1 0; 1 1 1; 0 1 0];
G4 = [1 0 1; 0 1 0; 1 0 1];

I_erosion_G1 = imerode(I, G1);
I_erosion_G2 = imerode(I, G2);
I_erosion_G3 = imerode(I, G3);
I_erosion_G4 = imerode(I, G4);

I_dilation_G1 = imdilate(I, G1);
I_dilation_G2 = imdilate(I, G2);
I_dilation_G3 = imdilate(I, G3);
I_dilation_G4 = imdilate(I, G4);

I_opening_G1 = imopen(I, G1);
I_opening_G2 = imopen(I, G2);
I_opening_G3 = imopen(I, G3);
I_opening_G4 = imopen(I, G4);

I_closing_G1 = imclose(I, G1);
I_closing_G2 = imclose(I, G2);
I_closing_G3 = imclose(I, G3);
I_closing_G4 = imclose(I, G4);

figure('Name', 'Letters Erosion');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_erosion_G1), title('Erosion G1');
subplot(2,3,3), imshow(I_erosion_G2), title('Erosion G2');
subplot(2,3,4), imshow(I_erosion_G3), title('Erosion G3');
subplot(2,3,5), imshow(I_erosion_G4), title('Erosion G4');

figure('Name', 'Letters Dilation');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_dilation_G1), title('Dilation G1');
subplot(2,3,3), imshow(I_dilation_G2), title('Dilation G2');
subplot(2,3,4), imshow(I_dilation_G3), title('Dilation G3');
subplot(2,3,5), imshow(I_dilation_G4), title('Dilation G4');

figure('Name', 'Letters Opening');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_opening_G1), title('Opening G1');
subplot(2,3,3), imshow(I_opening_G2), title('Opening G2');
subplot(2,3,4), imshow(I_opening_G3), title('Opening G3');
subplot(2,3,5), imshow(I_opening_G4), title('Opening G4');

figure('Name', 'Letters Closing');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_closing_G1), title('Closing G1');
subplot(2,3,3), imshow(I_closing_G2), title('Closing G2');
subplot(2,3,4), imshow(I_closing_G3), title('Closing G3');
subplot(2,3,5), imshow(I_closing_G4), title('Closing G4');


%% 3. Compute the skeleton only for the letters present in the image and 
% display, in the same figure, the original image and the results.

I_letter = imerode(I, strel('square', 5));  
kernel = zeros(23,23);

% -1 in kernels borders
kernel(:, 1) = -1;
kernel(:, 23) = -1;
kernel(1, :) = -1;
kernel(23, :) = -1;
kernel(12,12) = 1;

I_letter2 = I_letter - bwhitmiss(I_letter, kernel);
I_letter2 = imdilate(I_letter2, strel('square', 5));

I_skeleton = bwmorph(I_letter2,'skel', Inf);
I_skeleton2 = bwskel(imbinarize(I_letter2)); % Binarizamos porque el bwskel no permite doubles

figure('Name', 'Letters Skeleton');
subplot(1,3,1), imshow(I), title('Original');
subplot(1,3,2), imshow(labeloverlay(double(I_letter2),double(I_skeleton),'Transparency',0)), title('Skeleton'); 
subplot(1,3,3), imshow(labeloverlay(double(I_letter2),double(I_skeleton2),'Transparency',0)), title('Skeleton 2');

% Al hacer el labeloverlay pasamos a double porque no permite imagenes
% binarizadas


%% 4. Use the Hit and Miss transform to obtain the end points and the triple 
% junctions of the skeleton. Show, in the same figure: the original skeleton,
% the end points, the triple junctions and the combination of end points and
%triple junctions.

I_endpoints = bwmorph(I_skeleton, 'endpoints');
I_triple_junctions = bwmorph(I_skeleton, 'branchpoints');
figure('Name', 'Letters Endpoints');
subplot(2,2,1), imshow(I_skeleton), title('Skeleton');
subplot(2,2,2), imshow(I_endpoints), title('Endpoints');
subplot(2,2,3), imshow(I_triple_junctions), title('Triple Junctions');
subplot(2,2,4), imshow(I_endpoints | I_triple_junctions), title('Endpoints & Triple Junctions');