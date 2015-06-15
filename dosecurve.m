function[] = dosecurve(dose_lo, res)
 close all
n_treatment = size(dose_lo, 1);
% n_doses = size(dose_lo, 2);
names = ['Monomer ';'Dimer   ';'Tetramer';'Octamer '];
drugnames = cellstr(names);

figure(1);
for j = 1 : n_treatment
   subplot(2, 2, j) 
   m = mean(res([1,3],:,j));
   sd = std(res([1,3],:,j));
   errorbar(log10(dose_lo(j,:)), fliplr(m), fliplr(sd));
   xlim([0, 2.6]);
    ylim([.1, .46]);
    xlabel('log(nM)');
    ylabel('Fractional killing');
    title(drugnames(j));
end

figure(2)
for j = 1 : n_treatment
   m = mean(res([1,3],:,j));
   sd = std(res([1,3],:,j));
   errorbar(log10(dose_lo(1,:)), fliplr(m), fliplr(sd));
   hold all
end
xlim([.9, 2.6]);
ylim([.1, .46]);
hold off
xlabel('log(equivalent nM to monomers)');
ylabel('Fractional killing')
legend(drugnames);

