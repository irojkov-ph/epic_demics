function mu = mu_age(k,l)
    % Gives the mortality rate mu at a certain age
    
    global system;
    
    % Age classes (we give the top bound starting from 0 i.e 0 to 4, 4 to 9 ...)
    class_ages = [4,9,14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,89,94,100];
    
    M = max(system.mortality);
    
    A = system.age;
    
    n = size(A,1);
    mu = zeros(n);
    
    
    n_sys = size(system.age,1);
    
    [id_lin,id_col]=nearest_neighbours(k,l,n_sys,n_sys);
    
    for i=1:size(id_lin,2)
        for j=1:size(id_col,2)
            a = 1;
            while(A(i,j)>class_ages(k) && a<=size(class_ages,1))
                %finds the age class in which the person is
                a = a+1;
            end
            if(a>size(class_ages,1))
                %if the person is older than 100 we put a large value to
                %mortality
                mu(i,j)= 10*M;
            else
                mu(i,j)= system.mortality(a);
            end
        end
    end
    
    
end