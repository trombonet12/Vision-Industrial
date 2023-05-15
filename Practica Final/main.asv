clear all %#ok<CLALL> 
close all
clc

disp("Final Project");

%% Main

% Obtiene la ruta de la carpeta actual de trabajo
ruta_carpeta_actual = pwd;

% Especifica el nombre de la carpeta que deseas leer
nombre_carpeta = 'G2';

% Crea la ruta completa de la carpeta que deseas leer
ruta_carpeta = fullfile(ruta_carpeta_actual, nombre_carpeta);

% Carga la lista de archivos en la carpeta
lista_archivos = dir(ruta_carpeta);

% Inicializa un contador para el bucle
contador = 0;

% Itera a través de la lista de archivos
for i = 1:length(lista_archivos)
    
    % Obtiene el nombre del archivo actual
    nombre_archivo = lista_archivos(i).name;
    
    % Si el archivo actual es una imagen, entonces cárgalo en MATLAB
    if endsWith(nombre_archivo, {'.png'})
        
        % Incrementa el contador
        contador = contador + 1;
        
        % Carga la imagen en MATLAB
        imagen = imread(fullfile(ruta_carpeta, nombre_archivo));
        
        % Invocamos a la función de procesamiento
        procesada = process_license_plate(imagen);
        
    end
end

% Imprime el número total de imágenes procesadas
fprintf('Se procesaron %d imágenes.\n', contador);