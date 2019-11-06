function status = update_ages(dt)
    status = -1;
    global system
    
    system.age = system.age + dt;
    
    status = 1;
end