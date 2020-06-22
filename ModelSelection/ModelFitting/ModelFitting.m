function [fitting gof] = ModelFitting(T, Tp, functionLS, coefficients, options)
 
    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    % fitting functions
    linearFunction = fittype(functionLS, 'dependent', {'y'}, 'independent', {'x'}, ...
        'coefficients', coefficients);
    functionLog = [ 'log(' functionLS ')'];
    logFunction = fittype(functionLog, 'dependent',{'y'}, 'independent',{'x'}, ...
        'coefficients', coefficients);

    % fitting in log space and get its corresponding R2 in linear space
    [fitting gof] = fit(T,log(Tp), logFunction, options);
    gof.correspondingFitInLS = CorrespondingFunctionInLinearSpace(fitting, ...
        linearFunction, coefficients);
    predictedTp = gof.correspondingFitInLS(double(T));

    % There is a bug for calculating r2 and sse in fit.m of MATLAB, and we
    % amend the values using function rsqaure.
    [gof.rsquare gof.sse] = rsquare(log(Tp), log(predictedTp));
    
    [gof.linearR2 gof.linearSse] = rsquare(Tp, predictedTp);
    gof.averageR2 = (gof.rsquare + gof.linearR2) / 2;

    % model selection criteria
    sampleSize = length(Tp);
    dimension = length(coefficients);
    gof.aic = 2 * dimension + sampleSize * log(gof.sse);
    gof.bic = sampleSize * log(gof.sse / sampleSize) + dimension * log(sampleSize);
    gof.linearAic = 2 * dimension + sampleSize * log(gof.linearSse);
    gof.linearBic = sampleSize * log(gof.linearSse / sampleSize) + dimension * log(sampleSize);
end
