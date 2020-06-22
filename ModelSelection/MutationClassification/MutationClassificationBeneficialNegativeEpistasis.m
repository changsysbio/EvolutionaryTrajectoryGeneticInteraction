function [classification] = MutationClassificationBeneficialNegativeEpistasis(classification, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b > cf.fitness_ab);
	assert(cf.fitness_ab > 1);

    mutationRateThreshold = 8e-6;
    thresholdForHighMutationRate = 1.1;
    thresholdForLowMutationRate = 1.15;

    if ( cf.mutation_rate_b > mutationRateThreshold & ...
        cf.fitness_ab > thresholdForHighMutationRate )

        classification.epistasis_type = 'negative epistasis';
        classification.type = 'beneficial; with negative epistasis';

    elseif ( cf.mutation_rate_b <= mutationRateThreshold & ...
        cf.fitness_ab > thresholdForLowMutationRate )

        classification.epistasis_type = 'negative epistasis';
        classification.type = 'beneficial; with negative epistasis';

    else
        classification = ActuallyNotEpistasis(classification);
    end

end
