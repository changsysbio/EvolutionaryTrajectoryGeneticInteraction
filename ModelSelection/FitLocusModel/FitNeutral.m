function [fitting, gof] = FitNeutral(T, Tp, repeat)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    functionLS = 'Neutral(u_plus, 0, x)';
    coefficients = {'u_plus'};
    options = fitoptions('method', 'NonlinearLeastSquares', 'Robust', 'on', ...
        'MaxIter',1000, 'Lower',[1e-6], 'Upper', [2.5e-4], 'TolX', 1e-8, ...
        'TolFun', 1e-8, 'Startpoint', [1e-6]);
    [fitting, gof] = ModelFittingMultipleInitialization(T, Tp, functionLS, ...
        coefficients, options, repeat);

end
