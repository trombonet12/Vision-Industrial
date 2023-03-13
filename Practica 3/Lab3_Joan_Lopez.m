clear all %#ok<CLALL> 
close all
clc

disp("Lab 3: Image Enhancement (Histogram Processing)");

PLow = imread("pollenlow.jpg");
PBlack = imread("pollenblack.jpg");
PWhite = imread("pollenwhite.jpg");

PLowD = double(imread("pollenlow.jpg"));
PBlackD = double(imread("pollenblack.jpg"));
PWhiteD = double(imread("pollenwhite.jpg"));

disp("1. Display the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg along with their correspondent histograms using the imhist function. How is the contrast of each of these images?");
figure('Name','Histogram');

subplot(3,2,1);
imshow(PLow);
subplot(3,2,2);
imhist(PLow);

subplot(3,2,3);
imshow(PBlack);
subplot(3,2,4);
imhist(PBlack);

subplot(3,2,5);
imshow(PWhite);
subplot(3,2,6);
imhist(PWhite);

disp("Se puede ver con el histograma que la primera imagen tiene un rango muy reducido de la escala de grises. La negra todos sus valores son muy cercanos al negro lo que resulta en una imagen muy oscura. Y la blanca como sus valores son muy altos resulta en una imagen quemada.");

disp("3. Using the function created in the previous point, adjust the contrast of the three images of exercise 1 and display the resulting images along with their correspondent histograms. Compare the histograms of the adjusted images with the original ones.");

ALow = adjust(PLowD);
ABlack = adjust(PBlackD);
AWhite = adjust(PWhiteD);

figure('Name','Histogram Ajustado');

subplot(3,2,1);
imshow(ALow);
subplot(3,2,2);
imhist(ALow);

subplot(3,2,3);
imshow(ABlack);
subplot(3,2,4);
imhist(ABlack);

subplot(3,2,5);
imshow(AWhite);
subplot(3,2,6);
imhist(AWhite);

disp("Si comparamos los histogramas iniciales con los generados con la función propia podemos ver que son lo mismos pero estirados hacia los dos extremos.");

disp("4. Apply the function provided by Matlab for adjusting the contrast of the three images, and display the resulting images with their histograms. Are these histograms the same as the ones obtained in the previous exercise? Why?");

ALow2 = imadjust(PLow);
ABlack2 = imadjust(PBlack);
AWhite2 = imadjust(PWhite);

figure('Name','Histogram Ajustado MatLab');

subplot(3,2,1);
imshow(ALow2);
subplot(3,2,2);
imhist(ALow2);

subplot(3,2,3);
imshow(ABlack2);
subplot(3,2,4);
imhist(ABlack2);

subplot(3,2,5);
imshow(AWhite2);
subplot(3,2,6);
imhist(AWhite2);

disp("No quedan iguales ya que matlab condensa los valores por debajo del 1% y los que estan por encima del 99% mientras que nosotros no. Si quiséramos que lo hiciese podríamos usar la función stretchlim para conseguir los valores I_min e I_max.");

disp("5. Would it be possible to use the Matlab’s contrast adjusting function to obtain the complement (negative) of an image?. Think about it, try to perform this operation using the three images and show the results.");

NLow = imadjust(PLow, [0,1], [1,0]);
NBlack = imadjust(PBlack, [0,1], [1,0]);
NWhite = imadjust(PWhite, [0,1], [1,0]);

figure('Name', 'Matlab Adjustada en Negativo');
subplot(3,2,1);
imshow(NLow);
subplot(3,2,2);
imhist(NLow);

subplot(3,2,3);
imshow(NBlack);
subplot(3,2,4);
imhist(NBlack);

subplot(3,2,5);
imshow(NWhite);
subplot(3,2,6);
imhist(NWhite);

disp("6. Given the three versions of the images: the original one, the adjusted one obtained with your function and the adjusted one using the Matlab’s function, which one would you use for a further processing step? Why?");

% De primeras podemos descartar la imagen original, tiene un contraste muy
% bajo y visualmente no aporta mucha información.

% Tenemos que decidir entre la imagen de nuestra función y la de MatLab.
% Aunque nuestra función retorna una imagen más realista, ya que no hacemos
% niguna saturación de los extremos, puede haber algún caso en el que el 
% hecho de no hacer la saturación nos perjudique. Por ejemplo si tenemos
% una imagen que todos los píxeles están entre 90 y 100 pero justamente
% tenemos un píxel de valor 0 y otro de valor 255 no haría ningun
% "histogram stretching".

% Así pues, nosotros elegiríamos la función de MatLab, ya que hace más
% visibles los rangos centrals a costa de perder sensibilidad, ya que
% satura los valores extremos. 
% Si trabajasemos con una aplicación que únicamente necesita información 
% fiable de los extremos, sería buena idea usar nuestra función. Pero como
% será el caso mayoritario nosotros escogemos la función de MatLab.

disp("Histogram Equalization");

disp("1. Write a function in Matlab for computing the cumulative sum of a normalized histogram.");

disp("2. Write a function in Matlab to equalize an image using a uniform transformation with 256 gray levels.");

disp("3. Equalize the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg using the function written in the previous point. Display each resulting image and its correspondent histogram in figures.");

ELow = equalize(PLow);
EBlack = equalize(PBlack);
EWhite= equalize(PWhite);

figure('Name', 'Equalizadas');
subplot(3,2,1), imshow(ELow);
subplot(3,2,2), imhist(ELow);

subplot(3,2,3), imshow(EBlack);
subplot(3,2,4), imhist(EBlack);

subplot(3,2,5), imshow(EWhite);
subplot(3,2,6), imhist(EWhite);

disp("4. Equalize the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg using the function provided by Matlab. Display the resulting images and their histograms, and compare the results with the histograms computed in the previous exercise.");

ELow2 = histeq(PLow);
EBlack2 = histeq(PBlack);
EWhite2= histeq(PWhite);

figure('Name', 'Equalizadas Matlab');
subplot(3,2,1), imshow(ELow2);
subplot(3,2,2), imhist(ELow2);

subplot(3,2,3), imshow(EBlack2);
subplot(3,2,4), imhist(EBlack2);

subplot(3,2,5), imshow(EWhite2);
subplot(3,2,6), imhist(EWhite2);

% Como podemos observar obtenemos un resultado bastante similar, siendo la
% imagen blanca en la que hay mayores diferencias. Estas diferencias
% principalemte son que en el histograma de nuestra función hay mayor
% cantidad de niveles de grises, como podemos ver si ejecutamos el
% siguiente código:
% num = unique(EWhite)
% num = unique(EWhite2)
% Con el nuestro tenemos 125 valores de grises y con el de matlab 57, esto
% hace que la cantidad de píxeles por valor de gris sea menor con nuestra
% función.

disp("5. Compare the results obtained with histogram stretching and equalization and explain briefly the main differences between both approaches.");

% Podemos ver en los histogramas resultantes que al usar el estiramiento de
% histograma este mantiene su forma, pero al usar la ecualización la
% pierde.

% Como ya sabemos el "histogram stretching" y el "histogram equalization"
% son técnicas de mejora de imagenes que aumentan el contraste de las 
% imágenes.

% El histogram stretching consiste en aumentar la diferencia entre el valor
% de intensidad menor y el mayor repartiendo las demás intensidades en ese 
% rango, es decir aumentamos el contraste.

% Por el otro lado el "histogram equalization" consiste en modificar las
% intensidades de los pixeles de tal forma que el histograma quede lo más
% "plano" posible.

% Otra diferencia que cabe destacar es que con el stretching podemos hacer
% el proceso inverso para obtener la imagen original pero con el
% equalization no.


disp("6. Examine the adapthisteq Matlabs function. How it works?. Equalize the histograms of the images pollenlow.jpg, pollenblack.jpg and pollenwhite.jpg using two different grid sizes and display the results.");

Low8 = adapthisteq(PLow, "NumTiles", [8,8]);
Low16 = adapthisteq(PLow, "NumTiles", [16,16]);

Black8 = adapthisteq(PBlack, "NumTiles", [8,8]);
Black16 = adapthisteq(PBlack, "NumTiles", [16,16]);

White8 = adapthisteq(PWhite, "NumTiles", [8,8]);
White16 = adapthisteq(PWhite, "NumTiles", [16,16]);

figure('Name', 'Adapthiseq');
subplot(3,2,1), imshow(Low8), title('NumTiles = 8*8');
subplot(3,2,2), imshow(Low16), title('NumTiles = 16*16');

subplot(3,2,3), imshow(Black8), title('NumTiles = 8*8');
subplot(3,2,4), imshow(Black16), title('NumTiles = 16*16');

subplot(3,2,5), imshow(White8), title('NumTiles = 8*8');
subplot(3,2,6), imshow(White16), title('NumTiles = 16*16');













