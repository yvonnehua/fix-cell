function n = countnucs(mode, im)
% COUNTNUCS  Count nuclei by non-maximum suppression of blurred DAPI image.
%   N = COUNTNUCS('file', FILE) returns the number of nuclei in image file
%   FILE.
%   N = COUNTNUCS('image', IM) returns the number of nuclei in image IM.
%   This function has been developed against images from a PE Operetta
%   microscope using its 10x high NA objective. Tested cell lines include
%   A549, ACHN, H1703, H2170, HCT116, Panc-1, colo357 seeded at a density
%   of ~5000 cells and cultured for 24 hours. Yvonne and Sam.
MAX_SITES = 9;
if strcmp(mode, 'file')
    n = countnucs('image', double(imread(im)));
elseif strcmp(mode, 'image')
    ismax = @(x) all(x(2, 2) > x([1 : 4, 6 : 9]));
    flt_blur = fspecial('gaussian', [10, 10], 3.5);
    thres = 2.5 * prctile(im(:), 30);
    msk = bwmorph(im > thres, 'erode', 2);
    im(~msk) = 0;
    im = conv2(im, flt_blur, 'same');
    immax = nlfilter(im, [3, 3], ismax);
    imagesc(im);
    n = sum(immax(:));
elseif strcmp(mode, 'plate')
    imgpath = im;
    if imgpath(end) ~= '/'
        imgpath = [imgpath, '/'];
    end
    files = dir([imgpath, '*.tiff']);
    n = nan(8, 12, MAX_SITES);
    for k = 1 : length(files)
        tok = regexp(files(k).name, '^r(\d\d)c(\d\d)f(\d\d)', 'tokens');
        if files(k).isdir || length(tok) ~= 1
            continue
        end
        site = str2double(tok{1}{3});
        if site > MAX_SITES
	    error('Exceeding maximum number of sites per well (%d).', ...
                MAX_SITES);
        end
	row = str2double(tok{1}{1});
        col = str2double(tok{1}{2});
	n(row, col, site) = countnucs('file', [imgpath, files(k).name]);
        fprintf('File %d / %d processed.\n', k, length(files));
    end
else
    error('First argument must be ''file'', ''plate'', or ''image''.');
end
