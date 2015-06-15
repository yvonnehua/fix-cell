%% get kratio matfiles from MedImmune directory
% files = dir('/Volumes/HOME/MATLAB/MedImmune/*.mat');
% for i = 1 : length(files)
% %     load(files(i).name, '-ascii');
%     load(files(i).name);
% end

%%
clear all, close all

load 20140802_DU145_SKT_rhT_12h
[idx_rhT, ~] = find(treatment.rhT~=0 & treatment.SKT==0);
[idx_SKT, ~] = find(treatment.rhT==0 & treatment.SKT~=0);
% keyboard
ds_1 = dataset({treatment.rhT(idx_rhT),'x'},{treatment.kratio(idx_rhT),'y'});
ds_2 = dataset({treatment.SKT(idx_SKT),'x'},{treatment.kratio(idx_SKT),'y'});
ds_1.x = log10(ds_1.x);
ds_2.x = log10(ds_2.x);

simpleBindingModel = 'y ~ 1/(1 + (10^b1 / 10^x)^h)';
md_1 = fitnlm(ds_1,simpleBindingModel,[1, 1]);
md_2 = fitnlm(ds_2,simpleBindingModel,[1, 1]);

%% plot raw data and fitted curve
funsbm1 = md_1.Formula.ModelFun;
b1 = md_1.Coefficients.Estimate;
funsbm2 = md_2.Formula.ModelFun;
b2 = md_2.Coefficients.Estimate;

figure(1)
h1 = plot(ds_1.x, ds_1.y, 'r*');
hold on

% ds_1.x = -5 : 10;

plot(unique(ds_1.x), funsbm1(b1, unique(ds_1.x)), 'r', 'lineWidth', 1);
h2 = plot(ds_2.x, ds_2.y, 'b*');

hold on
plot(unique(ds_2.x), funsbm2(b2, unique(ds_2.x)), 'b', 'lineWidth', 1);
legend([h1, h2], 'rhT', 'SKT');
xlabel('log[dose]');
ylabel('killing ratio');
