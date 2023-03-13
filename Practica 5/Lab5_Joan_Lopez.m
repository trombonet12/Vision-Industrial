clear all %#ok<CLALL> 
close all
clc

disp("Lab 5: Image Enhancement (Neighborhood Processing)");

disp("Smoothing");

disp("1. Write a function in Matlab to perform a convolution between an image and a symmetric mask of size 3×3 without using Matlab functions");

disp("2. Use the function created in the previous exercise to apply an average filter to the image letters.jpg and display the results, converting the resulting matrix to an image.");

Letter = im2double(im2gray(imread('letters.jpg')));
mask9 = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
ALetter = correlation(Letter, mask9);
figure("Name","Letter Correlation");
subplot(1,2,1);
imshow(Letter);
subplot(1,2,2);
imshow(ALetter);

disp("3. Apply an average filter to the image letters.jpg using the function available in Matlab. Obtain different versions of the image using kernels of size 3×3, 5×5, 9×9, 15×15 and 35×35 and display the resulting images. What is the effect of using an average filter? What is the effect of augmenting the size of the kernel?");

tres = fspecial('average', 3);
cinco = fspecial('average', 5);
nueve = fspecial('average', 9);
quince = fspecial('average', 15);
treinta = fspecial('average', 35);

figure("Name","Average Filter Matlab");
subplot(2,3,1), imshow(Letter), title('Original');
subplot(2,3,2), imshow(imfilter(Letter, tres)), title('3x3');
subplot(2,3,3), imshow(imfilter(Letter, cinco)), title('5x5');
subplot(2,3,4), imshow(imfilter(Letter, nueve)), title('9x9');
subplot(2,3,5), imshow(imfilter(Letter, quince)), title('15x15');
subplot(2,3,6), imshow(imfilter(Letter, treinta)), title('35x35');

disp("A medida que se va aumentando el tamaño del filtro el suavizado es mayor");

disp("4. Using the function written in exercise 1, apply the following weighted average filter to the image and compare the results with the ones obtained in exercise 2");

mask10 = [5/100 10/100 5/100; 10/100 40/100 10/100; 5/100 10/100 5/100];
mask9= [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
ALetter2 = correlation(Letter, mask10);

figure("Name","Average Filter Comparation");
subplot(1,3,1), imshow(Letter), title('Original');
subplot(1,3,2), imshow(ALetter), title('Correlation 1');
subplot(1,3,3), imshow(ALetter2), title('Correlation 2');

disp("No observamos ninguna diferencia apreciable a simple vista, pero al hacer zoom podemos ver como el emborronamiento es menor en la imagen con el filtro ponderado frente a la imagen con el filtro de media");

disp("Sharpening");

disp("1. Load the image moon.bmp, convert it to the range [0.0, 1.0] and display it.");

Moon = im2double(im2gray(imread('moon.bmp')));
figure("Name","Moon");
imshow(Moon);

disp("2. Using the filtering function available in Matlab, apply the above-mentioned Laplacian mask to the image in order to obtain the second derivative. Subtract the response from the original image in order to sharp the details and display the resulting images.");

mask = [0 -1 0; -1 4 -1; 0 -1 0];
MMoon = imfilter(Moon, mask);
SMoon = Moon - MMoon;

figure("Name","Sharpened Moon and Masked Moon");
subplot(1,2,1);
imshow(SMoon);
subplot(1,2,2);
imshow(MMoon);

disp("3. Create a blurred version of the original image convolving it with an average filter. Then, subtract this resulting image from the original one, and add this resulting image again to the original one in order to sharp it. Display the results.");

BMoon= imfilter(Moon, fspecial('average', 3));
diff = Moon - BMoon;
OMoon = Moon + diff;
figure("Name","Blurred Moon");
subplot(1, 3, 1), imshow(OMoon), title('Sharped');
subplot(1, 3, 2), imshow(diff), title('Diff');
subplot(1, 3, 3), imshow(BMoon), title('Blurred');


disp("4. Sharp the image with the unsharp filter available in the fspecial function and show the results. Is it the same as the previous ones?");

UMoon= imfilter(Moon, fspecial('unsharp'));

figure("Name","Unsharped Moon");
subplot(1, 3, 1), imshow(Moon), title('Original');
subplot(1, 3, 2), imshow(OMoon), title('Sharpening');
subplot(1, 3, 3), imshow(UMoon), title('Unsharp');

disp("Template Matching");

disp("Given the image imag_tmatch.bmp and the template pattern_tmatch.bmp, detect the points in the image where the letter a exist. The final result must be a binary image where the positions of the detected letters are white pixels.");

IMatch = im2double(im2gray(imread('imag_tmatch.bmp')));

Pattern = im2double(im2gray(imread('pattern_tmatch.bmp')));

% Usamos la función para generar una corelación
correlacion = normxcorr2(Pattern, IMatch);

% Buscamos los maximos de correlación
[maxCorrVal, maxCorrIdx] = max(correlacion(:));
[maxCorrRow, maxCorrCol] = ind2sub(size(correlacion), maxCorrIdx);

% Aplicamos el limite para detectar la correlación con la a
binaryImg = correlacion > 0.9 * maxCorrVal;

figure("Name","Pattern Reconition");
subplot(1,2,1), imshow(IMatch), title('Original');
subplot(1,2,2), imshow(binaryImg), title('Puntos donde se ha detectado la "a"');
