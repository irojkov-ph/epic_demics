function new_season()
    global system;
    n = size(system.state,1);
    system.age = system.age + 1;
    state = string(ones(n));
    state(:,:) = "S";
    system.state = state;
    x = randi([1,n]);
    y = randi([1,n]);
    system.state(x,y) = 'I';
    system.reward(x,y) = system.reward(x,y) - 10;
    evolution_vaccination();
    %system.reward = zeros(n);
end