%%
close all, clear all;
%%
rowoffset = 1;
coloffset = 1;

for row = 1 : 6
    for col = 1 : 10
        res = struct('num', {}, 'I_dapi_var', {}, 'nuc_area', {});
        
        res_num = 0;
        res_I_dapi_var = [];
        res_nuc_area = [];
        for fld = 1 : 9
        
            fmt_str = [sprintf('/Volumes/ImStor/sorger/data/Operetta/Yvonne/20150308_SKOV3_rh_AMG655_Apo_Mapa_DAPI__2015-03-08T20_54_39-Measurement1/Images/r%02dc%02df%02d', row + rowoffset, col + coloffset, fld), ...
                'p01-ch1sk1fk1fl1.tiff'];
            [num, I_dapi_var, nuc_area] = count(fmt_str);
            res_num = res_num + num;
            res_I_dapi_var = [res_I_dapi_var; I_dapi_var];
            res_nuc_area = [res_nuc_area; nuc_area'];

            fprintf('processed row %d, col %d, field %d \n', row, col, fld);
        end
       iSave(row + rowoffset, col + coloffset, res_num, res_I_dapi_var, res_nuc_area);
    end
    
end
