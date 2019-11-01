%% test beta_0

t = 1:200;
y = beta_0(t);

figure
plot(t,y)
grid on
xlabel('t')
ylabel('\beta_0')

%% test count_nearest_neighbours

N_lin=5;
N_col=5;

A = ones(N_lin,N_col);
spy(A)
for i=1:N_lin
    for j=1:N_col
        A(i,j) = count_nearest_neighbours(i,j,N_lin,N_col);
    end
end

disp(A)

%% test density_ill

N_lin=8;
N_col=8;

C = zeros(N_lin,N_col);
D = zeros(N_lin,N_col);

for i=1:N_lin
    for j=1:N_col
        if(i<j)
            B(i,j) = struct('state','S','age',i+j+i*j);
            C(i,j) = ('S');
        else
            B(i,j) = struct('state','I','age',i+j+i*j);
            C(i,j) = ('I');
        end
    end
end

for i=1:N_lin
    for j=1:N_col
        D(i,j) = density_ill(B,i,j);
    end
end

disp(C)
disp(D)

%% test switch_cells

N_lin=8;
N_col=8;

k = 8;
l = 7;
m = 1;
n = 2;


for i=1:N_lin
    for j=1:N_col
        if(i<j)
            B(i,j) = struct('state','S','age',i+j+i*j);
        else
            B(i,j) = struct('state','I','age',i+j+i*j);
        end
    end
end

disp('Before switching')
disp(B(m,n))
disp(B(k,l))

B = switch_cells(k,l,m,n,B);

disp('After switching once')
disp(B(m,n))
disp(B(k,l))

B = switch_cells(k,l,m,n,B);

disp('After switching twice')
disp(B(m,n))
disp(B(k,l))

B = switch_cells(m,n,k,l,B);

disp('Is the operation symmetric?')
disp(B(m,n))
disp(B(k,l))


%% test update_ages

N_lin=8;
N_col=8;

dt = 10;

for i=1:N_lin
    for j=1:N_col
        if(i<=j)
            B(i,j) = struct('state','S','age',i+j);
        else
            B(i,j) = struct('state','I','age',i-j);
        end
        A(i,j) = B(i,j).age;
    end
end

disp(A)

B = update_ages(B,dt);

for i=1:N_lin
    for j=1:N_col
        A(i,j) = B(i,j).age;
    end
end

disp(A)


%% test evolve cell

Nlin = 5;
Ncol = 5;

for i=1:Nlin
    for j=1:Ncol
        if(i<=j)
            system(i,j) = struct('state','S','age',i+j);
        else
            system(i,j) = struct('state','I','age',i-j);
        end
        states(i,j) = system(i,j).state;
    end
end

disp(states);

for u=1:10

k = floor(rand.*(Nlin)+1);
l = floor(rand.*(Ncol)+1);


disp(k);
disp(l);

system = displacement(system,k,l);

for i=1:Nlin
    for j=1:Ncol
        states(i,j) = system(i,j).state;
    end
end

disp(states);

end

%% test evolve_cell

Nlin = 10;
Ncol = 10;

t_now = 0;
dt = 1;

for i=1:N_lin
    for j=1:N_col
        if(i<=j)
            system(i,j) = struct('state','S','age',i+j);
        else
            system(i,j) = struct('state','I','age',i-j);
        end
        states(i,j) = system(i,j).state;
    end
end

disp(states);

k = floor(rand.*(Nlin+1));
l = floor(rand.*(Ncol+1));

for i=1:N_lin
    for j=1:N_col
        states(i,j) = system(i,j).state;
    end
end

disp(states(k,l));

[t_now,system] = evolve_cell(t_now,dt,system,k,l);

%% test evolution_illness

%% test step

