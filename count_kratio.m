function kratio = count_kratio(dataDir, negR, negC)

cd(dataDir);
survnum = nan(8, 12);
treatment = tdfread('plate_design.tsv');

first_row = treatment.well(1, 1);
last_row = treatment.well(end, 1);

first_col = min(str2num(treatment.well(:, 2:end)));
last_col = max(str2num(treatment.well(:, 2:end)));

for row = first_row : last_row
    for col = first_col : last_col
        packname = sprintf([row, '%02d.mat'], col);
        load(packname);
        survnum(row - 'A' + 1, col) = res_num;
        
    end
end
disp(survnum);
imagesc(survnum);
save('survnum', 'survnum');

kratio = nan(8, 12);
kratioSd = nan(8, 12);

keyboard;
negCtrl = survnum(negR, negC);
negAvg = mean(negCtrl(~isnan(negCtrl)));
negSd = std(negCtrl(~isnan(negCtrl)));


for row = first_row : last_row
    for col = first_col : last_col
        kratio(row - 'A' + 1, col) = (negAvg - survnum(row - 'A' + 1, col))./negAvg;
        kratioSd(row - 'A' + 1, col) = survnum(row - 'A' + 1, col) * negSd / negAvg^2;
    end
end

disp(kratio)
figure
imagesc(kratio)
save('kratio', 'kratio', 'kratioSd');