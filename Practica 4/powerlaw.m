function plimage = powerlaw(image, gamma)

    % Aplicamos la formula necesaria. Como asumimos que c es 1 no hace
    % falta ponerlo.
    plimage = image .^ gamma;

end