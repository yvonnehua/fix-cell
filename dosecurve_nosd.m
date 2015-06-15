function[] = dosecurve_nosd(dose_lo, res)
% close all
n_treatment = size(dose_lo, 1);
% n_doses = size(dose_lo, 2);
names = ['Monomer ';'Dimer   ';'Tetramer';'Octamer '];
drugnames = cellstr(names);

figure;
for j = 1 : n_treatment
   subplot(2, 2, j) 
    m = mean(res([1,3],:,j));
    sd = std(res([1,3],:,j));
%     m = mean(res(:,:,j));
%    sd = std(res(:,:,j));
%     errorbar(log10(dose_lo(j,:)), fliplr(m), fliplr(sd),'.-');
    plot(log10(dose_lo(j,:)), fliplr(m), '*-');
    xlim([0, 2.6]);
    ylim([.1, .46]);
    xlabel('log(nM)');
    ylabel('Fractional killing');
    title(drugnames(j));

end

figure
for j = 1 : n_treatment
%    subplot(2, 2, j) 
    m = mean(res([1,3],:,j));
    sd = std(res([1,3],:,j));
%     m = mean(:,:,j);
%    sd = std(:,:,j);
%    errorbar(log10(dose_lo(1,:)), fliplr(m), fliplr(sd),'.-');
     plot(log10(dose_lo(1,:)), fliplr(m), '*-');
    hold all
end
xlim([.9, 2.6]);
ylim([.1, .46]);
hold off
xlabel('log(equivalent nM to monomers)');
ylabel('Fractional killing');
legend(drugnames);

