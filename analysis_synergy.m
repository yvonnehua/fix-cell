%%
% clear all, close all
key = [1, 5, 3, 6, 4, 2];
load kratio

%% reorder the plate layout - from dose high to low
dose1 = [500, 100, 20, 4, .8, 0];
dose2 = [500, 100, 20, 4, .8, 0];
kr_r = zeros(6, 6);
for row = 1 : 6
   for col = 1 : 6
       kr_r(row, col) = kr(key == row, key == col);
   end
end

%%
subplot(2, 1, 1)
imagesc(kr_r);

%%
load kratio
dose1 = [500, 100, 20, 4, .8, 0];
dose2 = [500, 100, 20, 4, .8, 0];
kr_r2 = zeros(6, 6);
for row = 1 : 6
   for col = 1 : 6
       kr_r2(row, col) = kr(key == row, key == col);
   end
end

%%
subplot(2, 1, 2)
imagesc(kr_r2);

