function[mdl_fk] = fit_dosersp(dose, data, guess)

baseline = data(:, 1);
max = data(:, end);

fractionKilled = (data - baseline)/(max - baseline);
logdose = log10(dose + 10E-6);
ds_fk = dataset({logdose, 'x'},{fractionKilled, 'y'});

model = 'y ~ x ./ (b1 + x)';
mdl_fk = NonLinearModel.fit(ds_fk,model,log10(guess));
