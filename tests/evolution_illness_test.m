function tests = evolution_illness_test
    addpath('../src/')
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    % no input
    verifyError(testCase, @() evolution_illness(), 'ID:invalid_input');
    % negativ time interval
    verifyError(testCase, @() evolution_illness(1,-2,1), 'ID:invalid_input');
end

function test_good_execution(testCase)
    global system
    for i=0:40
        [~,~]=evalc('system_init(5)');
    
        sys = system;
        % check dynamic option every even i
        dynamic = mod(i,2);
        
        % check if the function executes correctly
        actSolution = evolution_illness(0.1*i,0.1,dynamic);
        expSolution = 0.1*i+0.1;
        verifyEqual(testCase,actSolution,expSolution)
        
        % check if the system changed
        state = ismember(1,sys.state~=system.state);
        vaccin = ismember(1,sys.vaccinated~=system.vaccinated);
        reward = ismember(1,sys.reward~=system.reward);
        age = ismember(1,sys.age~=system.age);
        actSolution = state + vaccin + reward + age;
        minexpSolution = 1;
        
        verifyGreaterThanOrEqual(testCase,actSolution,minexpSolution)
    end
end