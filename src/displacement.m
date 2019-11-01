function status = displacement(k,l)
    status = -1;
    global system

    state_ = system.state(k,l);
    
    N_cell = count_nearest_neighbours(k,l,size(system.age,1),size(system.age,2));
    
    N_lin = size(system.age,1);
    N_col = size(system.age,2);
    
    id_lin = [k-1,k,k+1];
    id_col = [l-1,l,l+1];
    
    moved = false;
    
    if(state_ == 'I' || state_ == 'R')
        
        p = rand;
        q = 0.5/N_cell;
        
        n=1;
        
        for i = 1:3

            for j = 1:3
                if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col && (i~=2 || j~=2) )
                    if(p<=(q*n) && p>(q*(n-1)))
                        try
                            switch_cells(k,l,id_lin(i),id_col(j)); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            
                            % Write in logs
                            fileID = fopen(['..',filesep,'logs',filesep,'displacements.txt'],'a+');
                            fprintf(fileID,['Displacement switching cells(',num2str(k),',',num2str(l),') and (',num2str(id_lin(i)),',',num2str(id_col(j)),')!']);
                            fclose(fileID);

                            moved = true;
                        catch
                            error('ID:switch_fail','The execution of ''switch_cells'' function failed.')
                        end
                    end
                    n = n + 1;
                    
                end
            end

        end
        
    elseif(state_ == 'S')
        
        if(density_ill(k,l)~=0) %if the person is not safe
            
            dens_tot = 0;
            
            for i = 1:3
                
                for j = 1:3
                    if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col )
                        
                        dens_tot = dens_tot + density_ill(id_lin(i),id_lin(j));
                        
                    end
                end

            end
            
            p = rand;
            
            density = 0;
            
            for i = 1:3
                
                for j = 1:3
                    if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col )
                        if( p>density && p<=(density + density_ill(id_lin(i),id_lin(j))/dens_tot) && ~moved)
                            try
                                switch_cells(k,l,id_lin(i),id_col(j));

                                % Write in logs
                                fileID = fopen(['..',filesep,'logs',filesep,'displacements.txt'],'a+');
                                fprintf(fileID,['Displacement switching cells(',num2str(k),',',num2str(l),') and (',num2str(id_lin(i)),',',num2str(id_col(j)),')!']);
                                fclose(fileID);

                                moved = true;
                            catch
                                error('ID:switch_fail','The execution of ''switch_cells'' function failed.')
                            end
                        end
                        density = density + density_ill(id_lin(i),id_lin(j))/dens_tot;
                    end
                end

            end
            
        end
        
    else
        error('ID:no_state',['Error! There exist no state "', state_ , ' " in this model! It can not be displaced!'])
    end
    
    status = 1;
end