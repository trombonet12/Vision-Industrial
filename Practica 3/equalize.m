function imageeq = equalize(image)
   imageeq = zeros(size(image),"uint8");
   hnorm = imhist(image)/numel(image);
   cdf = csum(hnorm);
  newHist = 255*cdf;
  for i = 1:size(image)
      for j = 1:size(image)
          imageeq(i,j) = uint8(round(newHist(image(i,j)+1)));
      end
  end
end