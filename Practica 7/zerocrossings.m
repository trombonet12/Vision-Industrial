function imedges = zerocrossings(deriv2, T)
    [rows, cols]=size(deriv2);
    imedges = false(size(deriv2));
    for i = 1:rows-1
        for j = 1:cols-1
            drow=0.0;
            dcol=0.0;
            a = deriv2(i,j);
            b = deriv2(i+1,j);
            c = deriv2(i,j+1);
         
            if((a >= 0 && b < 0) || (a < 0 && b >= 0))
                drow = abs(a-b);
            end

            if((a >= 0 && c < 0) || (a < 0 && c >= 0))
                dcol = abs(a-c);
            end
            magnitude = max(drow, dcol);
            if(magnitude >= T) % CP
                imedges(i,j) = 1;
            end
        end
    end 
end