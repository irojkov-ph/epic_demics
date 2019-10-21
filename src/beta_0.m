function y = beta_0(t)
    
    %values of the gaussian distribution (or wathever distribution) to
    %modelise the seasonal variation of the infectivity
    
    m=10;
    sigma=2;
    T=30;
    tmp = t;
    
    for i=1:max(size(tmp))
        while(tmp(i)>T)
            tmp(i)=tmp(i)-T;
        end
    end
    
    y = gaussmf(tmp,[sigma,m]);
    
end