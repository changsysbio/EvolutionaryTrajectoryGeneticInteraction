function [fitting, gof] = FitMutationWithFlatTrajectory(T, Tp)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    functionLS = 'mean(x) + 0 * k * x';
    coefficients = {'k'};
    options = fitoptions('method', 'NonlinearLeastSquares', 'Robust', 'on', ...
        'MaxIter',1000, 'Lower',[1e-6], 'Upper', [2.5e-4], 'TolX', 1e-8, ...
        'TolFun', 1e-8, 'Startpoint', [1e-6]);
    [fitting, gof] = ModelFitting(T, Tp, functionLS, coefficients, options);
    if ( var(Tp) > 1e-12 ) % not all Tp are equal
        [gof.decision, gof.p_value] = ttest(log(Tp), log(mean(Tp)));
    else
        gof.decision = 0;
        gof.p_value = 1;
    end   

    functionLS = ['0 * k * x + ' num2str(mean(Tp))];
    coefficients = {'k'};
    linearFunction = fittype(functionLS, 'coefficients', coefficients);
    gof.correspondingFitInLS = cfit(linearFunction, 0);

end
