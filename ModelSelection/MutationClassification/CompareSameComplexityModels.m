function [classification winner] = CompareSameComplexityModels(gof, cf, modelIndices, threshold)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    classification = [];
    winner = [];

    INITIAL_VALUE = -10; % a small enough number to initialize
    averageR2(modelIndices) =  INITIAL_VALUE;

    for ( i = modelIndices )
        if (gof{i}.averageR2 >= threshold(i) )
            c{i} = eval([gof{i}.classificationFunction '(gof{i}, cf{i})']);
            averageR2(i) = c{i}.gof.averageR2;
        end
    end

    c{max(modelIndices) + 1} = []; % ensure not empty

    [r2Sort, r2Index] = sort(averageR2, 'descend');
    r2Max = r2Index(1);
    if (r2Sort(1) ~= INITIAL_VALUE)
        classification = c{r2Max};
        winner = r2Max;
        return;
    end

end
