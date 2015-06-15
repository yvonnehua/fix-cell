function [F_cyt_1, F_cyt_2] = double_cyt(fmt_str)
% format string describes file naming convention, with everything fixed
% except the channel, e.g. r04c04f04p01rc%d-ch1sk1fk1fl1.tif

% prepare single cell nuclear mask L
dapi_file = sprintf(fmt_str, 1);
im_dapi = double(imread(dapi_file));

[L, num] = cytonuc(im_dapi);

% read out cytosolic and nuclear intensities
RFP_file = sprintf(fmt_str, 3);
GFP_file = sprintf(fmt_str, 4);

im_RFP = double(imread(RFP_file));
im_GFP = double(imread(GFP_file));

F_cyt_1 = nan(num, 1);
F_cyt_2 = nan(num, 1);


for k = -num : -1
    ss_cyt_msk = L == k;
    
%     keyboard
    px_RFP = im_RFP(ss_cyt_msk);
    px_GFP = im_GFP(ss_cyt_msk);

    if ~isempty(px_RFP)
        F_cyt_1(-k) = median(px_RFP);
    end
    if ~isempty(px_GFP)
        F_cyt_2(-k) = median(px_GFP);
    end
end

% ...
imagesc(L);

% clean up
% bad = isnan(F_cyclin_cyt) | isnan(F_cyclin_nuc);
 bad = isnan(F_cyt_2);
 F_cyt_1(bad) = [];
 F_cyt_2(bad) = [];
