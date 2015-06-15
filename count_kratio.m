function kratio = count_kratio(folder)

cd(folder);
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
%          keyboard
%         h_cutoff = prctile(res_nuc_area, 95);
%         l_cutoff = prctile(res_nuc_area, 5);
%         num = sum(res_nuc_area >= l_cutoff & res_nuc_area <= h_cutoff);
%         survnum(row - 'A', col-2) = num;
        survnum(row - 'A' + 1, col) = res_num;
        
    end
end
disp(survnum);
imagesc(survnum);
colormap('Jet')
save('survnum', 'survnum');

kratio = nan(8, 12);
nrow = last_row - first_row + 1;
ncol = last_col - first_col + 1;

% row_offset = first_row - 'A';
% col_offset = first_col - 1;

negCtrl = survnum(last_row - 'A' + 1, :);
% negCtrl = median(survnum(last_row - 'A' + 1, first_col:last_col));
% keyboard
for row = first_row : last_row
    for col = first_col : last_col
        kratio(row - 'A' + 1, col) = (negCtrl(col) - survnum(row - 'A' + 1, col))./negCtrl(col);       
%           kratio(row - 'A' + 1, col) = (negCtrl - survnum(row - 'A' + 1, col))./negCtrl;       
    end
end
kratio(kratio<0)= 0;
disp(kratio)
figure
imagesc(kratio)
colormap('Jet')
save('kratio', 'kratio');