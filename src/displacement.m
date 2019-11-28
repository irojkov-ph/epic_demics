% Function status = displacement(k,l)
%
% This function checks and displaces the cell at the position (k,l)
% to another one depending on the following conditions: 
%   - If the cell is "I" (Infected) or "R" (Recovered) then it displaces 
%     the cell randomly in its neighbourhood (random walk) but with a
%     probability to stay at its place
%   - If the cell is "S" (Susceptible) then it checks the density of 
%     "I" state cells around it and displaces it in the direction where 
%     such density is minimised.
% 
% The function retuns 1 whenever it ended without error and -1 otherwise.
% 

function status = displacement(k,l)
    status = -1;
    global system epic_demics_path
    
    N_lin = size(system.age,1);
    N_col = size(system.age,2);
    
    if nargin<2 || k<1 || k>N_lin || l<1 || l>N_col
       warning('ID:invalid_input',['The specified indices are out of range.\n', ...
                                   'The function returned without performing any displacement.'])
       return
    end
    

    N_cell = count_nearest_neighbours(k,l);
    
    state_ = system.state(k,l);
    
    [id_lin,id_col] = nearest_neighbours(k,l);

    
    N_lin_nn = size(id_lin,2);
    N_col_nn = size(id_col,2);
    
    moved = false;
    
    if(state_ == 'I' || state_ == 'R')
        
        p = rand;
        
        %probability to change cell
        q = 0.5/N_cell;
        
        n=1;
        
        for i = 1:N_lin_nn
            for j = 1:N_col_nn
              if((i~=2 || j~=2))
                if(p<=(q*n) && p>(q*(n-1)))
                    try
                        switch_cells(k,l,id_lin(i),id_col(j));

                        % Write in logs
                        %fileID = fopen([epic_demics_path,filesep,'logs',filesep,'displacements.txt'],'a+');
                        %fprintf(fileID,['Displacement switching cells(',num2str(k),',',num2str(l),') and (',num2str(id_lin(i)),',',num2str(id_col(j)),')!\n']);
                        %fclose(fileID);
                        
                        moved = true;
                    catch
                        error('ID:switch_fail','The execution of ''switch_cells'' function failed.')
                    end
                    n = n + 1;
                  end  
                end
            end

        end
        
    elseif(state_ == 'S')
        
        if(density_ill(k,l)~=0) %if the person is not safe
            
            dens_tot = 0;
            
            for i = 1:N_lin_nn
                for j = 1:N_col_nn
                    dens_tot = dens_tot + (1-density_ill(id_lin(i),id_col(j)));
                end
            end
            
            p = rand;
            
            density = 0;
            
            for i = 1:N_lin_nn
                for j = 1:N_col_nn
                    if( p>density && p<=(density + (1-density_ill(id_lin(i),id_col(j)))/dens_tot) && ~moved)
                        try
                            switch_cells(k,l,id_lin(i),id_col(j));
                            
                            % Write in logs
%                             fileID = fopen([epic_demics_path,filesep,'logs',filesep,'displacements.txt'],'a+');
%                             fprintf(fileID,['Displacement switching cells(',num2str(k),',',num2str(l),') and (',num2str(id_lin(i)),',',num2str(id_col(j)),')!\n']);
%                             fclose(fileID);

                            moved = true;
                        catch EM
                            EM
                            error('ID:switch_fail','The execution of ''switch_cells'' function failed.')
                        end
                        density = density + (1-density_ill(id_lin(i),id_col(j)))/dens_tot;

                    end
                    
                end

            end
            
        end 
    else
        error('ID:no_state',strcat("Error! There exist no state '", state_ , "' in this model! It can not be displaced!"))
    end
    
    status = 1;
end