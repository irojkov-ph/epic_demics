function dt = interval(lambda)
    
    %lambda is 1/mean of times
    
    x=rand;
    
    dt = -log(x)./lambda;
    
    
end