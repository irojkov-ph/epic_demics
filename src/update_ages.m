function system = update_ages(sys,dt)
    sys.age = sys.age + dt;
    system = sys;
end