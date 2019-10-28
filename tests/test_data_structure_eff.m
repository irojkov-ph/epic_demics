% Simple code to test the efficiency between array of structures and
% structure of matrices

pers.state = 'S'; pers.vaccin = 1; pers.r = 0; pers.age = 2;
sys(1,1) = pers;
pers.state = 'S'; pers.vaccin = 0; pers.r = 0; pers.age = 17;
sys(2,1) = pers;
pers.state = 'I'; pers.vaccin = 1; pers.r = 0; pers.age = 25;
sys(1,2) = pers;
pers.state = 'S'; pers.vaccin = 1; pers.r = 0; pers.age = 58;
sys(2,2) = pers;

tic
for i=1:1e4
    age_tmp = reshape([sys.age],size(sys));
    age_tmp = age_tmp + 1;
    age = num2cell(age_tmp);
    sys_bis = cell2struct([reshape({sys.state},[numel(sys) 1]),reshape({sys.vaccin},[numel(sys) 1]),reshape({sys.r},[numel(sys) 1]),reshape(age,[numel(sys) 1])],{'state','vaccin','r','age'},2);
    sys_bis = reshape(sys_bis,[2 2]);
    sys = sys_bis;
    clear sys_bis
end
toc

pers.state = 'S'; pers.vaccin = 1; pers.r = 0; pers.age = 2;
sys2(1,1) = pers;
pers.state = 'S'; pers.vaccin = 0; pers.r = 0; pers.age = 17;
sys2(2,1) = pers;
pers.state = 'I'; pers.vaccin = 1; pers.r = 0; pers.age = 25;
sys2(3,1) = pers;
pers.state = 'S'; pers.vaccin = 1; pers.r = 0; pers.age = 58;
sys2(4,1) = pers;

tic
for i=1:1e4
    age_tmp = [sys2.age];
    age_tmp = age_tmp + 1;
    age = num2cell(age_tmp);
    sys_bis = cell2struct([{sys2.state}.',{sys2.vaccin}.',{sys2.r}.',age.'],{'state','vaccin','r','age'},2);
    sys2 = sys_bis;
    clear sys_bis
end
toc


sys3.state = ["S","S";"I","S"];
sys3.vaccin = [1, 0; 1, 1];
sys3.r = [0,0;0,0];
sys3.age = [2,17;25,58];

tic
for i=1:1e4
    sys3.age = sys3.age+1;
end
toc


% We conclude that it is easier and more efficient to use the last option
% i.e. a structure with matrices as fields