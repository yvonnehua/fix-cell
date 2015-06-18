function plateproc(imgpath)
if imgpath(end) ~= '/'
    imgpath = [imgpath, '/'];
end 
n = countnucs('plate', imgpath);
save([imgpath, 'counts.mat'], 'n');
