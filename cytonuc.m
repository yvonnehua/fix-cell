function [L, num] = cytonuc(im_dapi)
% generate cytosolic mask and nuclear mask
% L will be a label matrix with positive and negative integers x, where
% the nucleus and cytosol that belong together are x and -x. idea: get
% whole cell area by dilating nucleus, then remove slightly dilated
% nucleus to obtain cytosolic mask (donut) with safety zone. 
bg = prctile(im_dapi(:), 30);

msk = bwmorph(bwmorph(im_dapi > 3 * bg, 'erode', 3), 'dilate', 1);

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
