function [fitting gof] = FitBeneficial(T, Tp, repeat)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    functionLS = 'Beneficial(0, mutation_rate, fitness, x)';
    coefficients = {'fitness', 'mutation_rate'};
    options = fitoptions('method', 'NonlinearLeastSquares', 'Robust', 'on', ...
        'MaxIter', 1000, 'TolX', 1e-8, 'TolFun', 1e-8, 'Lower', [1.001 1e-6], ...
        'Upper', [1.6 2.5e-4], 'Startpoint', [1.05 1e-6]);
    [fitting, gof] = ModelFittingMultipleInitialization(T, Tp, functionLS, ...
        coefficients, options, repeat);

end
