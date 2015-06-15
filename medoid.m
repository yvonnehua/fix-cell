function m = medoid(tr)
% tr is t x n matrix with t time points and n traces
traces = tr(:, find(isnan(tr), 1) > 100);
keyboard()
dist = squareform(pdist(traces'));
tot_dist = sum(dist);
[~, idx_med] = min(tot_dist);
m = tr(:, idx_med);