function [classification] = MutationClassificationOneLocus(gof, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    if ( ~isempty(find(strcmp(argnames(cf), 'fitness'))) )
        classification.fitness_b = cf.fitness;
        classification.fitness_ab = cf.fitness;
    elseif ( ~isempty(find(strcmp(argnames(cf), 'fitness_b'))) )
        classification.fitness_b = cf.fitness_b;
        classification.fitness_ab = cf.fitness_b;
    else
        error('wrong');
    end

    classification.gof = gof;
	fitnessType = FitnessType(classification.fitness_b);
	classification.epistasis_type = 'no epistasis';
	classification.type = [fitnessType '; without epistasis'];

end
