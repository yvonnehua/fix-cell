function kratio = count_kratio_notlastr(folder)

cd(folder);
survnum = nan(8, 12);
treatment = tdfread('plate_design.tsv');

row_idx = unique(treatment.well(:, 1));
col_idx = unique(str2num(treatment.well(:, 2:end)));

well_num = length(row_idx) * length(col_idx);
for i = 1 : well_num
    row = treatment.well(i, 1);
    col = str2num(treatment.well(i, 2:end));
        packname = sprintf([row, '%02d.mat'], col);
        load(packname);
%          keyboard
%         h_cutoff = prctile(res_nuc_area, 95);
%         l_cutoff = prctile(res_nuc_area, 5);
%         num = sum(res_nuc_area >= l_cutoff & res_nuc_area <= h_cutoff);
%         survnum(row - 'A', col-2) = num;
        survnum(row - 'A' + 1, col) = res_num;
        
end
disp(survnum);
imagesc(survnum);
save('survnum', 'survnum');

kratio = nan(8, 12);

% row_offset = first_row - 'A';
% col_offset = first_col - 1;

negCtrl = survnum(4, :);
for i = 1 : well_num
    row = treatment.well(i, 1);
    col = str2num(treatment.well(i, 2:end));
    kratio(row - 'A' + 1, col) = (negCtrl(col) - survnum(row - 'A' + 1, col))./negCtrl(col);       
end
kratio(kratio<0)= 0;
disp(kratio)
figure
imagesc(kratio)
save('kratio', 'kratio');