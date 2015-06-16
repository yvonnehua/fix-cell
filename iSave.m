function iSave(row, col, res_num, res_F_mCherry, res_F_dapi)
    save(name_of_well(row, col), 'res_num', 'res_F_mCherry', 'res_F_dapi');
end