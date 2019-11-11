function new_season()
    global system;
    n = size(system.age,1);
    system.age = system.age + 1;
    state = string(ones(n));
    state(:,:) = "S";
    system.state = state;
    evolution_vaccination();
    system.reward = zeros(n);
end