function [F_casp8_nuc] = caspase(fmt_str)
% format string describes file naming convention, with everything fixed
% except the channel, e.g. r04c04f04p01rc%d-ch1sk1fk1fl1.tif

% prepare single cell nuclear mask L
dapi_file = sprintf(fmt_str, 1);
im_dapi = double(imread(dapi_file));

[L, num] = cytonuc(im_dapi);

% read out cytosolic and nuclear intensities
caspase8_file = sprintf(fmt_str, 2);
im_cas = double(imread(caspase8_file));
F_casp8_nuc = nan(num, 1);
for k = 1 : num
    msk_nuc = L == k;
    px = im_cas(msk_nuc);
    if ~isempty(px)
        F_casp8_nuc(k) = median(px);
    end
end

%  clean up
 bad = isnan(F_casp8_nuc);
 F_casp8_nuc(bad) = [];
