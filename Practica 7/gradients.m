function[Gx, Gy] = gradients(img)
    sobel = fspecial('sobel');
    Gx = imfilter(img, sobel, 'conv');
    Gy = imfilter(img, sobel', 'conv');
end