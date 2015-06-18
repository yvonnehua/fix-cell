function n = countnucs(mode, in)
% COUNTNUCS  Count nuclei by non-maximum suppression of blurred DAPI image.
%   N = COUNTNUCS('file', FILE) returns the number of nuclei in image file
%   FILE.
%   N = COUNTNUCS('image', IM) returns the number of nuclei in image IM.
%   This function has been developed against images from a PE Operetta
%   microscope using its 10x high NA objective. Tested cell lines include
%   A549, ACHN, H1703, H2170, HCT116, Panc-1, colo357 seeded at a density
%   of ~5000 cells and cultured for 24 hours. Yvonne and Sam.
if strcmp(mode, 'file')
    im = double(imread(in));
elseif strcmp(mode, 'image')
    im = in;
else
    error('First argument must be ''file'' or ''image''.');
end
ismax = @(x) all(x(2, 2) > x([1 : 4, 6 : 9]));
flt_blur = fspecial('gaussian', [10, 10], 3.5);
thres = 2.5 * prctile(im(:), 30);
msk = bwmorph(im > thres, 'erode', 2);
im(~msk) = 0;
im = conv2(im, flt_blur, 'same');
immax = nlfilter(im, [3, 3], ismax);
imagesc(im);
n = sum(immax(:));
