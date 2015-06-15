%%
close all, clear all;
cd('/Volumes/HOME/MATLAB/MedImmune');

%%
rowoffset = 1;
coloffset = 2;

for row = 1 : 6
     parfor col = 1 : 8 
        
        res_F_cyt = [];
        res_F_nuc = [];
        for fld = 1 : 9
        
            fmt_str = [sprintf('/Users/yh136/Desktop/20140616_FL_FS_G6T8_SKT_lowdoses__2014-06-16T13_27_08-Measurement1/Images/r%02dc%02df%02d', row + rowoffset, col + coloffset, fld), ...
                'p01-ch%01dsk1fk1fl1.tiff'];
            [F_cyt, F_nuc] = cyclinsNew(fmt_str);
            res_F_cyt = [res_F_cyt; F_cyt];
            res_F_nuc = [res_F_nuc; F_nuc];

            fprintf('processed row %d, col %d, field %d \n', row, col, fld);
        end
       iSave(row + rowoffset, col + coloffset, res_F_cyt, res_F_nuc);
    end
    
end