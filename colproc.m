function colproc(imgpath, col)
if imgpath(end) ~= '/'
    imgpath = [imgpath, '/'];
end 
n = countnucs('col', imgpath, col);
save([imgpath, 'counts.mat'], 'n');
