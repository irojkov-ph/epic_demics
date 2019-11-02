function tests = switch_cells_test
    addpath('../src/')
    global system
    system.state = ["S","S","S","S"; ...
                    "S","I","S","S"; ...
                    "S","S","S","S"; ...
                    "S","S","S","S"      ];
    system.vaccinated = [0,0,0,0; ...
                        0,1,0,0; ...
                        0,0,0,0; ...
                        0,0,0,0      ];
    system.reward = [0,0,0,0; ...
                    0,10,0,0; ...
                    0,0,0,0 ; ...
                    0,0,0,0      ];
    system.age = [0,0,0,0; ...
                  0,5,0,0; ...
                  0,0,0,0; ...
                  0,0,0,0;      ];
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    % test out of range
    verifyError(testCase, @() switch_cells(1,0,2,2), 'ID:invalid_input');
end

function test_good_execution(testCase)
    global system
    % test switch cells (2,2) and (3,4) 
    % verify status
    actSolution = switch_cells(2,2,3,4);
    expSolution = 1;
    verifyEqual(testCase,actSolution,expSolution)
    
    % verify state
    actSolution = strcmp(system.state(3,4),"I");
    expSolution = true;
    verifyEqual(testCase,actSolution,expSolution)
    
    % verify vaccinated
    actSolution = (system.vaccinated(3,4)==1);
    expSolution = true;
    verifyEqual(testCase,actSolution,expSolution)
    
    % verify reward
    actSolution = (system.reward(3,4)==10);
    expSolution = true;
    verifyEqual(testCase,actSolution,expSolution)
    
    % verify age
    actSolution = (system.age(3,4)==5);
    expSolution = true;
    verifyEqual(testCase,actSolution,expSolution)
end