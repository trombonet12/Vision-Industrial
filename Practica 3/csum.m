function cdf = csum(hnorm)
   cdf=zeros(1,length(hnorm));
   for k = 1:256
       cdf(k)=sum(hnorm(1:k));
   end
end