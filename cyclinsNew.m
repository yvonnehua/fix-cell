function [F_cyclin_cyt, F_cyclin_nuc] = cyclinsNew(fmt_str)
% format string describes file naming convention, with everything fixed
% except the channel, e.g. r04c04f04p01rc%d-ch1sk1fk1fl1.tif

% prepare single cell nuclear mask L
dapi_file = sprintf(fmt_str, 1);
im_dapi = double(imread(dapi_file));

[L, num] = cytonuc(im_dapi);

% read out cytosolic and nuclear intensities
cyclin_file = sprintf(fmt_str, 2);
im_cyclin = double(imread(cyclin_file));
F_cyclin_nuc = nan(num, 1);
F_cyclin_cyt = nan(num, 1);
for k = 1 : num
    ss_nuc_msk = L == k;
    px = im_cyclin(ss_nuc_msk);
    if ~isempty(px)
        F_cyclin_nuc(k) = median(px);
    end
    msk_cyt = L == -k;
    px = im_cyclin(msk_cyt);
    if ~isempty(px)
        F_cyclin_cyt(k) = prctile(px, 80);
    end
end

% ...
imagesc(L);

% clean up
% bad = isnan(F_cyclin_cyt) | isnan(F_cyclin_nuc);
 bad = isnan(F_cyclin_nuc);
 F_cyclin_cyt(bad) = [];
 F_cyclin_nuc(bad) = [];
