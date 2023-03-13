clear all %#ok<CLALL> 
close all
clc

disp("Matrices and Matlab");

disp("1. Create a 5×5 matrix of ones (A).");
A = [1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];
disp(A);

disp("2. Create a 5×3 matrix of ones (B).");
B = [1 1 1;1 1 1;1 1 1;1 1 1;1 1 1];
disp(B);

disp("3. Create a 3×3 matrix of zeros (C).");
C = zeros(3,3);
disp(C);

disp("4. Create a 4×4 matrix with equal row, column, and diagonal sums (D)");
D = magic(4);
disp(D);

disp("5. Create a 4×4 random matrix whose values are uniformly distributed between 0 and 1 (E).");
E = rand(4,4);
disp(E);

disp("6. Create a 5×5 identity matrix (F).");
F = eye(5);
disp(F);

disp("7. Sum the matrices A and F.");
disp(A + F);

disp("8. Subtract the matrices A and F.");
disp(A - F);

disp("9. Sum the matrices A and C. Is it possible?.");
disp("No es posible perque tenen dimensions diferents.");

disp("10. Compute D^20.");
disp(D^20);

disp("11. Compute F × 2.");
disp(F*2);

disp("12. Compute A × F.");
disp(A*F);

disp("13. Compute A × F, element by element");
disp(mtimes(A,F));

disp("14. Compute the transpose matrix of E.");
disp(E');

disp("15. Compute the inverse matrix of E.");
disp(inv(E));

disp("16. Compute the determinant of matrix C.");
disp(det(C));

disp("17. Store the size of matrix B in two variables, rows and cols.");
rows = size(B,1);
cols = size(B,2);
disp(rows);
disp(cols);

disp("18. Given the matrix F, obtain the indices of the elements whose value is not zero");
disp(find(F));

disp("19. Set the detected values in the previous point to -1.");
aux=F;
aux(aux~=0)=-1;
disp(aux);

disp("20. Given a 10×10 matrix, set the values of the even columns to zero.");
J=rand(10,10);
J(:, 2:2:end) = 0;
disp(J);

disp("21. Create a 10×10 matrix where the values of each row coincide with the row number.");
I = repmat((1:10)', 1, 10);
disp(I);

disp("22. Given a 10×10 matrix, set the values of the fourth row to zero.");
L=rand(10,10);
L(4, :) = 0;
disp(L);

disp("23. Given a 10×10 matrix, set the values of the second column to zero.");
M=rand(10,10);
M(:, 2) = 0;
disp(M);

disp("24. Given a 10×10 matrix, set the values of the fifth column to the values of the first column");
N=rand(10,10);
N(:, 1) = N(:, 5);
disp(N);

disp("25. Given a 10×10 matrix, set all the values to zero, except the rows and columns in the edges of the matrix.");
O=rand(10,10);
O(2:9, 2:9) = 0;
disp(O);

disp("Introduction to Image Processing Toolbox");

disp("1. Open and display the image landscape.jpg. Determine the dimensions of the image. Is this a color image?");
LAND = imread("landscape.jpg");
disp(LAND);
dims=size(LAND);
fprintf('Les dimiensions de la imatge son: %d x %d.\n', dims(1), dims(2));
disp("Si que tiene color porque dentro de cada pixel tenemos los valores RGB.");

disp("2. Convert the image to gray-scale, and display the result. Then, save this resulting image into another file called landscapegray.jpg. What is the data type of the pixels?");
LAND_GREY=rgb2gray(LAND);
figure(1);
imshow(LAND_GREY);
imwrite(LAND_GREY,"landscapegray.jpg");
disp("El tipus de dades dels pixels es: ");
disp(class(LAND_GREY));

disp("3. Rescale the pixel values to the range [0, 1] and convert the image to double precision.");
LAND_DOUBLE = im2double(double(LAND_GREY) / 255);
disp(LAND_DOUBLE);

disp("4. Display the gray scale image as a three-dimensional plot. Compare the results using two functions: mesh and surf.");
figure(2);
mesh(LAND_DOUBLE);
figure(3);
surf(LAND_DOUBLE);
disp("Les dues mostren la mateixa forma que es la representació gràfica dels valors dels pixels de l'imatge, pero el mesh posa colors als valors.");

disp("5. Convert the gray scale image to an indexed image with a colormap of 16 components and display the result. Do you observe differences between the original and the indexed images?");
LAND_IND = gray2ind(LAND_GREY,16);
figure(4);
imshow(LAND_IND);
disp("L'imatge es veu més oscura que l'original.");

disp("6. Write a Matlab script for generating the negative of the image moon.bmp without using any Matlab function.");

MOON = imread('moon.bmp');
[m, n] = size(MOON); 

for i = 1:m
    for j = 1:n 
        MOON_NEG(i, j) = 255 - MOON(i, j); 
    end
end
figure(5);
imshow(MOON_NEG);

disp("7. Write a Matlab script which flips the image moon.bmp vertically without using any Matlab function.");

MOON = imread('moon.bmp');
[m, n] = size(MOON); 

for i = 1:m
    for j = 1:n 
        MOON_FLIP(i, j) = MOON(m - i + 1, j);
    end
end
figure(6);
imshow(MOON_FLIP); 