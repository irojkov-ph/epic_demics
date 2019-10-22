function system = displacement(sys,k,l)
    
    N_cell = count_nearest_neighbours(k,l,size(sys,1),size(sys,2));
    
    N_lin = size(sys,1);
    N_col = size(sys,2);
    
    id_lin = [k-1,k,k+1];
    id_col = [l-1,l,l+1];
    
    if(state_ == 'I' || state_ == 'R')
        
        p = rand;
        q = 0.5/N_cell;
        
        n=1;
        
        for i = 1:3

            for j = 1:3
                if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col && (i~=2 || j~=2) )
                    if(p<=(q*n) && p>(q*(n-1)))
                        system = switch_cells(k,l,id_lin(i),id_col(j),sys);
                    end
                    n = n + 1;
                    
                end
            end

        end
        
    elseif(state_ == 'S')
        
        if(density_ill(sys,k,l)~=0) %if the person is not safe
            
            for i = 1:3
                
                for j = 1:3
                    if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col )
                        
                        dens_tot = dens_tot + density_ill(sys,id_lin(i),id_lin(j));
                        
                    end
                end

            end
            
            p = rand;
            
            density = 0;
            
            for i = 1:3
                
                for j = 1:3
                    if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col )
                        if( p>density && p<=(density + density_ill(sys,id_lin(i),id_lin(j))/dens_tot) )
                            system = switch_cells(k,l,id_lin(i),id_col(j),sys);
                        end
                        density = density + density_ill(sys,id_lin(i),id_lin(j))/dens_tot;
                    end
                end

            end
            
        end
        
    else
        disp(['Error! There exist no state "', state_ , ' " in this model! It can not be displaced!'])
    end
    
end