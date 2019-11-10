function tests = count_nearest_neighbours_test
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    verifyError(testCase, @() count_nearest_neighbours(2,3), 'ID:invalid_input');
end

function test_good_execution(testCase)
    actSolution = count_nearest_neighbours(5,5,8,8);
    expSolution = 8;
    verifyEqual(testCase,actSolution,expSolution)
    
    actSolution = count_nearest_neighbours(5,5,6,5);
    expSolution = 5;
    verifyEqual(testCase,actSolution,expSolution)
    
    actSolution = count_nearest_neighbours(5,5,5,5);
    expSolution = 3;
    verifyEqual(testCase,actSolution,expSolution)
end