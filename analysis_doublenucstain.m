%%
close all, clear all;
cd('/Volumes/HOME/MATLAB/MedImmune');

%%
rowoffset = 1;
coloffset = 2;

for row = 1 : 6
%     parfor col = 1 : 8
    for col = 1 : 8
        res_num = 0;
        res_F_mCherry = [];
        res_F_dapi = [];
        for fld = 1 : 9
            fmt_str = [sprintf('/Volumes/ImStor/sorger/data/Operetta/Yvonne/20150119_HeLaICRP_KD_rhT_Dynasore__2015-01-19T23_18_15-Measurement1/Images/r%02dc%02df%02d', row + rowoffset, col + coloffset, fld), ...
                'p01-ch%01dsk1fk1fl1.tiff'];
            [F_nuc_1, F_nuc_2, num] = double_nuc(fmt_str);
            res_num = res_num + num;
            res_F_mCherry = [res_F_mCherry; F_nuc_1];
            res_F_dapi = [res_F_dapi; F_nuc_2];

            fprintf('processed row %d, col %d, field %d \n', row, col, fld);
        end
       iSave(row + rowoffset, col + coloffset, res_num, res_F_mCherry, res_F_dapi);
    end
    
end