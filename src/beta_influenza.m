% function y = beta_influenza(t)
%     
% 
%     %values of the gaussian distribution (or wathever distribution) to
%     %modelise the seasonal variation of the infectivity
%     
%     %ATTENTION the function should be such that max beta_0 <= 1 and min >=0
%     
%     %parameters for the variation of infectivity in time
%     m=10;
%     sigma=2;
%     %period of the variation
%     T=30;
%     
%     tmp = t;
%     
%     for i=1:max(size(tmp))
%         while(tmp(i)>T)
%             tmp(i)=tmp(i)-T;
%         end
%     end
%     
%     y = gaussmf(tmp,[sigma,m]);
%     
% end


influenza_stat = readmatrix('../../influenza_stat.csv');


ind_start = find((influenza_stat(:,1) == 2017) & (influenza_stat(:,3) == 26));

ind_end = find((influenza_stat(:,1) == 2018) & (influenza_stat(:,3) == 25));

ill_2017_2018 = influenza_stat(ind_start:ind_end,5);

x_start = 1:28;
ill_2017_2018_start = ill_2017_2018(1:28);
% beta =      0.4874  (0.4478, 0.527)

x_end = 37:52;
ill_2017_2018_end = ill_2017_2018(37:52);
% gamma =      -0.339  (-0.402, -0.2759)

R_0_2017_2018 = 0.4874/0.339


% f_ill_2017_2018_start = fit(x_start,ill_2017_2018_start,'exp1');
% f_ill_2017_2018_end = fit(x_end,ill_2017_2018_end,'exp1');

ind_start = find((influenza_stat(:,1) == 2018) & (influenza_stat(:,3) == 26));

ind_end = find((influenza_stat(:,1) == 2019) & (influenza_stat(:,3) == 25));

ill_2018_2019 = influenza_stat(ind_start:ind_end,5);

x_start_2 = 1:33;
ill_2018_2019_start = ill_2018_2019(1:33);
% beta =      0.2686  (0.2461, 0.291)

x_end_2 = 40:52;
ill_2018_2019_end = ill_2018_2019(40:52);
% gamma =     -0.4616  (-0.5697, -0.3535)

R_0_2018_2019 = 0.2686/0.4616


% f_ill_2018_2019_start = fit(x_start_2,ill_2018_2019_start,'exp1');
% f_ill_2018_2019_end = fit(x_end_2,ill_2018_2019_end,'exp1');




figure
plot(1:52,ill_2017_2018)
hold on
plot(1:52,ill_2018_2019)
% plot(f_ill_2017_2018_start)
% plot(f_ill_2017_2018_end)
% plot(f_ill_2018_2019_start)
% plot(f_ill_2018_2019_end)



