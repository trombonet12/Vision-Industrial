function cimage = correlation(img, mask)
    [m, n] = size(img);
    cimage = zeros(m, n);
    pad_img = padarray(img, [1, 1], 'replicate');

    for i = 2:m+1
        for j = 2:n+1
            patch = pad_img(i-1:i+1, j-1:j+1);
            if all(size(patch) == size(mask))
                value = sum(patch .* mask, 'all');
                cimage(i-1, j-1) = value;
            else
                cimage(i-1, j-1) = 0;
            end
        end
    end
end