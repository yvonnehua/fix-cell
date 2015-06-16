close all, clear all;
saveName = '20141119_HeLaBcl2OE_DR4_cas8';
%%

res = struct('cyt_ch1', {}, 'cyt_ch2', {});

for row = [3, 5]
    for col = 3 : 10
        res(row, col).cyt_ch1 = [];
        res(row, col).cyt_ch2 = [];
        for fld = 1 : 25        
            fmt_str = [sprintf('/Volumes/ImStor/sorger/data/Operetta/Yvonne/20141119_HeLaBcl2OE_DR4_cas8__2014-11-19T22_12_40-Measurement1/images/r%02dc%02df%02d', row, col, fld), ...
                'p01-ch%01dsk1fk1fl1.tiff'];
            [cyt_ch1, cyt_ch2] = double_cyt(fmt_str);
            res(row, col).cyt_ch1 = [res(row, col).cyt_ch1; cyt_ch1];
            res(row, col).cyt_ch2 = [res(row, col).cyt_ch2; cyt_ch2];

            fprintf('processed row %d, col %d, field %d \n', row, col, fld);
        end
    end
    
end

save(saveName, 'res');