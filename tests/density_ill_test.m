function tests = density_ill_test
    addpath('../src/')
    [~,~]=evalc('system_init(4)');
    global system
    system.state = ["S","S","S","I"; ...
                    "I","S","I","I"; ...
                    "I","S","S","I"; ...
                    "S","S","S","I"      ];
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    i = [-1,5,2];
    % test out of range
    for k=1:3
        verifyWarning(testCase, @() density_ill(i(k),-i(k)), 'ID:invalid_input');
    end
end

function test_good_execution(testCase)
    % test that density of (2,2) is equal to 3/8
    actSolution = density_ill(2,2);
    expSolution = 3/8;
    verifyEqual(testCase,actSolution,expSolution)
    
    % test that density of (4,4) is equal to 1/3
    actSolution = density_ill(4,4);
    expSolution = 1/3;
    verifyEqual(testCase,actSolution,expSolution)
end