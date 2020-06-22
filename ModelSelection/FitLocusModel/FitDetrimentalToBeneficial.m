function [fitting, gof] = FitDetrimentalToBeneficial(T, Tp, repeat)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    functionLS = ['DetrimentalToBeneficial(mutation_rate_a, fitness_a,'...
        ' mutation_rate_b, fitness_b, fitness_ab, x)'];
    coefficients = {'mutation_rate_a', 'mutation_rate_b', 'fitness_a', 'fitness_b', ...
        'fitness_ab'};
    options = fitoptions('method', 'NonlinearLeastSquares', 'Robust', 'on', ...
        'MaxIter', 1000, 'Lower', [1e-5 1e-6 1.25 0 1.001], ...
        'Upper', [2.5e-4 2.5e-4 1.6 0.999 1.6], 'TolX', 1e-8, 'TolFun', 1e-8, ...
        'Startpoint', [1e-5 1e-6 1.25 0.8 1.05]);
    [fitting, gof] = ModelFittingMultipleInitialization(T, Tp, functionLS, ...
        coefficients, options, repeat);

end
