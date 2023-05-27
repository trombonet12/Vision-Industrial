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

% Inicializamos contadores
D = 0;
GB = 0;
PL = 0;

% Itera a través de la lista de archivos
for i = 1:length(lista_archivos)
    
    % Obtiene el nombre del archivo actual
    nombre_archivo = lista_archivos(i).name;
    
    % Si el archivo actual es una imagen, entonces cárgalo en MATLAB
    if endsWith(nombre_archivo, {'.png'})
        
        % Carga la imagen en MATLAB
        imagen = imread(fullfile(ruta_carpeta, nombre_archivo));
        
        % Invocamos a la función de procesamiento
        matricula = process_license_plate(imagen);
        nacionalitat = process_nacionalitat(imagen);
    
        % Imprimir las letras detectadas
        fprintf('%s-%s\n', nacionalitat, matricula);

        switch nacionalitat
            case "D"
                D = D + 1;
            case "GB"
                GB = GB + 1;
            case "PL"
                PL = PL + 1;
        end
    end
end

fprintf("------\nTotals:\nGB: %d\nPL: %d\nD: %d\n", GB, PL, D);