function classification = ActuallyNotEpistasis(classification)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    classification.fitness_b = classification.fitness_ab;
	fitnessType = FitnessType(classification.fitness_b);
	classification.epistasis_type = 'no epistasis';
	classification.type = [fitnessType '; without epistasis'];

end
