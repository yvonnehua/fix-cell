function [F_nuc_1, F_nuc_2, num] = double_nuc(fmt_str)
% format string describes file naming convention, with everything fixed
% except the channel, e.g. r04c04f04p01rc%d-ch1sk1fk1fl1.tif

% prepare single cell nuclear mask L
dapi_file = sprintf(fmt_str, 1);
im_dapi = double(imread(dapi_file));

[L, num] = cytonuc(im_dapi);
% keyboard

% read out cytosolic and nuclear intensities
% GFP_file = sprintf(fmt_str, 3);
RFP_file = sprintf(fmt_str, 2);%mcherry file

% im_RFP = double(imread(RFP_file));
im_RFP = double(imread(RFP_file));
im_GFP = im_dapi;

F_nuc_1 = nan(num, 1);
F_nuc_2 = nan(num, 1);

for k = 1 : num
    ss_nuc_msk = L == k;
    
    px_RFP = im_RFP(ss_nuc_msk);
    px_GFP = im_GFP(ss_nuc_msk);

    if ~isempty(px_RFP)
        F_nuc_1(k) = median(px_RFP);
    end
    if ~isempty(px_GFP)
        F_nuc_2(k) = median(px_GFP);
    end
end

% ...
imagesc(L);

% clean up
% bad = isnan(F_cyclin_cyt) | isnan(F_cyclin_nuc);
 bad = isnan(F_nuc_1);
 F_nuc_1(bad) = [];
 F_nuc_2(bad) = [];
 num = length(F_nuc_1);
