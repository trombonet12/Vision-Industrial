clear all %#ok<CLALL> 
close all
clc

disp("Lab 2: Digital Image Formation");

disp("1. Generate the following binary images of size 256×256 and display the results:");
% En ambos casos lo primero que se hace es generar una imagen cuadrada
% negra, luego se calcula el punto de inicio y final del segundo tercio
% mediante la función size y con la función floor nos aseguramos que sea un
% entero y no un float.
figure;
A = false(256);
A(:, floor((size(A)/3)):floor(((size(A)/3)*2))) = true;
subplot(1,2,1);
imshow(A);
B = false(256);
B(floor((size(B)/3)):floor(((size(B)/3)*2)), :) = true;
subplot(1,2,2);
imshow(B);

disp("2. Generate the following gray scale images of size 256×256 and display the results:");
% En ambos casos se genera una matriz y se le van asignando los valores de
% 1 a 256 de manera incremental a medida si se avanza en las columnas o en
% las filas.

figure;
C = uint8(repmat((0:255)', 1, 256));
subplot(1,2,1);
imshow(C);

D = uint8(repmat(255:-1:0,256,1));
subplot(1,2,2);
imshow(D);

disp("3. Generate the following RGB images of size 256×256 and display the results:");
% Crea una matriz de 256x256 con valores de 255
% Concatena una matriz de ceros para el canal verde y otra para el canal azul
% Convierte la matriz a tipo uint8 para representar los valores de intensidad

figure;
% Se genera una matriz de 256x256 donde todos sus valores son 255
UNOS = ones(256) * 255; 
% Se concatenan 3 matrizes para poder generar una imagen RGB, donde estará
% al máximo una de las componentes del RGB. Luego lo convertimos a uint8.
R = uint8(cat(3, UNOS, zeros(256), zeros(256)));
G = uint8(cat(3, zeros(256), UNOS, zeros(256)));
Bl = uint8(cat(3, zeros(256), zeros(256), UNOS));

subplot(1,3,1);
imshow(R);
subplot(1,3,2);
imshow(G);
subplot(1,3,3);
imshow(Bl);


disp("5. Using the function implemented in the previous point, compute the histogram of the images of the exercise 2, and plot the results. Are the histograms the same?");
figure;
subplot(1,2,1);
plot(histogram(C));
subplot(1,2,2);
plot(histogram(D));
disp("Si que son iguales.");

disp("6. Resize the images generated in exercise 2 to 512×512, 128×128 and 64×64 using the correspondent Matlab function. Plot each resulting image and its correspondent histogram in figures. Given these histograms, how can we say about the resizing process in Matlab?");
% Figura C
figure;

subplot(3,2,1);
C_512 = imresize(C, [512, 512]);
imshow(C_512);
subplot(3,2,2);
plot(histogram(C_512));

subplot(3,2,3);
C_128 = imresize(C, [128, 128]);
imshow(C_128);
subplot(3,2,4);
plot(histogram(C_128));

subplot(3,2,5);
C_64 = imresize(C, [64, 64]);
imshow(C_64);
subplot(3,2,6);
plot(histogram(C_64));


% Figura D
figure;
subplot(3,2,1);
D_512 = imresize(D, [512, 512]);
imshow(D_512);
subplot(3,2,2);
plot(histogram(D_512));

subplot(3,2,3);
D_128 = imresize(D, [128, 128]);
imshow(D_128);
subplot(3,2,4);
plot(histogram(D_128));

subplot(3,2,5);
D_64 = imresize(D, [64, 64]);
imshow(D_64);
subplot(3,2,6);
plot(histogram(D_64));

disp("La función de Matlab lo que hace es eliminar franjas de valores de siguiendo un patrón constante.");

disp("8. Use the function implemented in the previous point to reduce images generated in exercise 2 and display the results.");

figure;
subplot(1,2,1);
imshow(halfsize(C));
subplot(1,2,2);
imshow(halfsize(D));
