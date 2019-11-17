function update_betas(i,j)
    global system
    
    n = size(system.age,1);
    
    if(i==1)
        if(j==1)
            system.beta(i+1,j+1) = density_ill(i+1,j+1);
            system.beta(i+1,j) = density_ill(i+1,j);
            system.beta(i,j+1) = density_ill(i,j+1);
        elseif(j==n)
            system.beta(i,j-1) = density_ill(i,j-1);
            system.beta(i+1,j) = density_ill(i+1,j);
            system.beta(i+1,j-1) = density_ill(i+1,j-1);
        else
            system.beta(i,j+1) = density_ill(i,j+1);
            system.beta(i,j-1) = density_ill(i,j-1);
            system.beta(i+1,j+1) = density_ill(i+1,j+1);
            system.beta(i+1,j) = density_ill(i+1,j);
            system.beta(i+1,j-1) = density_ill(i+1,j-1);
        end
    elseif(i==n)
        if(j==1)
            system.beta(i,j+1) = density_ill(i,j+1);
            system.beta(i-1,j) = density_ill(i-1,j);
            system.beta(i-1,j+1) = density_ill(i-1,j+1);
        elseif(j==n)
            system.beta(i,j-1) = density_ill(i,j-1);
            system.beta(i-1,j) = density_ill(i-1,j);
            system.beta(i-1,j-1) = density_ill(i-1,j-1);
        else
            system.beta(i,j+1) = density_ill(i,j+1);
            system.beta(i,j-1) = density_ill(i,j-1);
            system.beta(i-1,j+1) = density_ill(i-1,j+1);
            system.beta(i-1,j) = density_ill(i-1,j);
            system.beta(i-1,j-1) = density_ill(i-1,j-1);
        end
    else
        if(j==1)
            system.beta(i-1,j+1) = density_ill(i-1,j+1);
            system.beta(i,j+1) = density_ill(i,j+1);
            system.beta(i+1,j+1) = density_ill(i+1,j+1);
            system.beta(i-1,j) = density_ill(i-1,j);
            system.beta(i+1,j) = density_ill(i+1,j);
        elseif(j==n)
            system.beta(i,j-1) = density_ill(i,j-1);
            system.beta(i-1,j-1) = density_ill(i-1,j-1);
            system.beta(i+1,j-1) = density_ill(i+1,j-1);
            system.beta(i-1,j) = density_ill(i-1,j);
            system.beta(i+1,j) = density_ill(i+1,j);
        else
            system.beta(i-1,j-1) = density_ill(i-1,j-1);
            system.beta(i-1,j) = density_ill(i-1,j);
            system.beta(i-1,j+1) = density_ill(i-1,j+1);
            system.beta(i,j-1) = density_ill(i,j-1);
            system.beta(i,j+1) = density_ill(i,j+1);
            system.beta(i+1,j-1) = density_ill(i+1,j-1);
            system.beta(i+1,j) = density_ill(i+1,j);
            system.beta(i+1,j+1) = density_ill(i+1,j+1);
        end
    end
    
    

end