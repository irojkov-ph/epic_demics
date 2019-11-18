function y=nearest_beta(i,j)
    
    global system
    
    n = size(system.age,1);
    y = system.beta(i,j);
    
    [id_lin,id_col]=nearest_neighbours(i,j,n,n);
    
    for k=1:size(id_lin,2)
        for m=1:size(id_col,2)
            y = y + system.beta(id_lin(k),id_col(m));
        end
    end
    
    
%     if(i==1)
%         if(j==1)
%             y = y + system.beta(i+1,j+1);
%             y = y + system.beta(i+1,j);
%             y = y + system.beta(i,j+1);
%         elseif(j==n)
%             y = y + system.beta(i,j-1);
%             y = y + system.beta(i+1,j);
%             y = y + system.beta(i+1,j-1);
%         else
%             y = y + system.beta(i,j+1);
%             y = y + system.beta(i,j-1);
%             y = y + system.beta(i+1,j+1);
%             y = y + system.beta(i+1,j);
%             y = y + system.beta(i+1,j-1);
%         end
%     elseif(i==n)
%         if(j==1)
%             y = y + system.beta(i,j+1);
%             y = y + system.beta(i-1,j);
%             y = y + system.beta(i-1,j+1);
%         elseif(j==n)
%             y = y + system.beta(i,j-1);
%             y = y + system.beta(i-1,j);
%             y = y + system.beta(i-1,j-1);
%         else
%             y = y + system.beta(i,j+1);
%             y = y + system.beta(i,j-1);
%             y = y + system.beta(i-1,j+1);
%             y = y + system.beta(i-1,j);
%             y = y + system.beta(i-1,j-1);
%         end
%     else
%         if(j==1)
%             y = y + system.beta(i-1,j+1);
%             y = y + system.beta(i,j+1);
%             y = y + system.beta(i+1,j+1);
%             y = y + system.beta(i-1,j);
%             y = y + system.beta(i+1,j);
%         elseif(j==n)
%             y = y + system.beta(i,j-1);
%             y = y + system.beta(i-1,j-1);
%             y = y + system.beta(i+1,j-1);
%             y = y + system.beta(i-1,j);
%             y = y + system.beta(i+1,j);
%         else
%             y = y + system.beta(i-1,j-1);
%             y = y + system.beta(i-1,j);
%             y = y + system.beta(i-1,j+1);
%             y = y + system.beta(i,j-1);
%             y = y + system.beta(i,j+1);
%             y = y + system.beta(i+1,j-1);
%             y = y + system.beta(i+1,j);
%             y = y + system.beta(i+1,j+1);
%         end
%     end
end