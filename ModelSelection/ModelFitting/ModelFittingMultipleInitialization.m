function [fitting gof] = ModelFittingMultipleInitialization...
    (T, Tp, functionLS, coefficients, options, numInitialization)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	IMPOSSIBLE_SMALL_R2_NUM = -100;
    maxAverageR2 = IMPOSSIBLE_SMALL_R2_NUM;
    maxAverageR2Position = 1;

    f = [];
    g = [];
    for (i = 1 : numInitialization + 1)

        [f{i} g{i}] = ModelFitting(T, Tp, functionLS, coefficients, options);
        if (g{i}.averageR2 > maxAverageR2)
			maxAverageR2 = g{i}.averageR2;
        	maxAverageR2Position = i;
        end

        seed = rand(1, length(options.StartPoint));
        interval = options.Upper - options.Lower;
        options.StartPoint = options.Lower + seed .* interval;
    end

    fitting = f{maxAverageR2Position};
    gof = g{maxAverageR2Position};
    assert( xor(maxAverageR2 == gof.averageR2, ...
    	maxAverageR2 == IMPOSSIBLE_SMALL_R2_NUM ));
end
