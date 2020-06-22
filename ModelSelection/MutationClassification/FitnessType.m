function fitnessType = FitnessType(fitness)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(fitness >= 0);

    if (fitness <= 0.98)
        fitnessType = 'detrimental';
    elseif (fitness >= 1.01)
        fitnessType = 'beneficial';
    else
        fitnessType = 'neutral';
    end
end
