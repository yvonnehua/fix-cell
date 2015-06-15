function [num, I_dapi_var, nuc_area] = count(fmt_str)
% generate cytosolic mask and nuclear mask
% L will be a label matrix with positive and negative integers x, where
% the nucleus and cytosol that belong together are x and -x. idea: get
% whole cell area by dilating nucleus, then remove slightly dilated
% nucleus to obtain cytosolic mask (donut) with safety zone. 
dapi_file = fmt_str;
im_dapi = double(imread(dapi_file));

bg = prctile(im_dapi(:), 30);

msk = bwmorph(bwmorph(im_dapi > 3 * bg, 'erode', 2), 'dilate', 1);

im_blur = conv2(im_dapi, fspecial('gaussian', [12, 12], 5), 'same');
ws = watershed(-im_blur);
msk(ws == 0) = 0;

[L, num] = bwlabel(msk);

% matrix claim is used to count dilaetd single cell masks claiming the
% same pixel.
claim = zeros(size(L));
for k = 1 : num
    ss_nuc_msk = L == k;
    msk_not_cyt = bwmorph(ss_nuc_msk, 'dilate', 2);
    msk_all = bwmorph(msk_not_cyt, 'dilate', 3);
    claim = claim + msk_all;
    msk_cyt = msk_all & ~msk_not_cyt;
    L(msk_cyt) = -k;
    
end
% now we can remove all those areas where masks would overkap.
L(claim > 1) = 0;
num = max(L(:));

L_nuc = L;
L_nuc(L < 0) = 0;

rp = regionprops(L_nuc, 'area');
% I_dapi_spike = zeros(num, 1);
I_dapi_var = zeros(num, 1);
nuc_area = [rp.Area];
for k = 1 : num
    ss_dapi = im_dapi(L == k);
    I_dapi_var(k) = var(ss_dapi(:));
    % I_dapi_spike(k) = prctile(ss_dapi(:), 90);
end

imagesc(L)