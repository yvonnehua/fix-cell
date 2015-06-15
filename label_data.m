function treatment = label_data(folder)

treatment = tdfread([folder, 'plate_design.tsv']);
raw_data = [folder, 'kratio.mat'];
pack = load(raw_data);
n_treat = length(treatment.time);
kr = zeros(n_treat, 1);

first_row = min(treatment.well(:, 1));
first_col = 12;
for i = 1 : n_treat
    col = str2double(treatment.well(i, 2:3));
    if col < first_col
        first_col = col;
    end
end

for i = 1 : n_treat
    row = treatment.well(i, 1) - 'A' + 1;
    col = str2num(treatment.well(i, 2:3));
      kr(i) = pack.kratio(row, col);
end
treatment.kratio(:, 1) = kr(:);
items = fieldnames(treatment);
%%
exclude_drug = {'well', 'time', 'date', 'kratio', 'cell_line'};
drug_names = setdiff(items, exclude_drug);
drug = drug_names{1};
for i = 2 : length(drug_names)
    drug = [drug, '_', drug_names{i}];
end
cellline = unique(treatment.cell_line, 'rows');
cell_type = cellline(1, :);
if size(cellline,1) > 1
    for i = 2 : size(cellline,1)
        cell_type = [cell_type, '_', cellline(i,:)];
    end
end
treatmenttime = num2str(treatment.time(1, 1));
expdate = treatment.date(1, 1);

datafilename = sprintf('%d_%s_%s_%sh.mat', expdate, cell_type, drug, treatmenttime);
save(datafilename, 'treatment');
