function system = update_ages(sys,dt)
    for i=1:size(sys,1)
        for j=1:size(sys,2)
            sys(i,j).age = sys(i,j).age + dt;
        end
    end
    system = sys;
end