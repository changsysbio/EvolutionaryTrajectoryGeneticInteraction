function [classification] = MutationClassificationDetrimentalPositiveEpistasis(classification, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b < cf.fitness_ab);
	assert(cf.fitness_ab < 1);

    mutationRateThreshold = 3e-5;
    thresholdForHighMutationRate = 0.1;
    thresholdForLowMutationRate = 0.2;

    % Given it would be checked by whether it is detrimental mutation 
    % with positive epistasis by detrimental-to-detrimental model
	assert(cf.fitness_b < cf.fitness_ab);

    if ( cf.mutation_rate_b > mutationRateThreshold & ...
        cf.fitness_ab - cf.fitness_b > thresholdForHighMutationRate )

        classification.epistasis_type = 'positive epistasis';
        classification.type = 'detrimental; with positive epistasis';
        return;

    elseif ( cf.mutation_rate_b <= mutationRateThreshold & ...
        cf.fitness_ab - cf.fitness_b > thresholdForLowMutationRate )

        classification.epistasis_type = 'positive epistasis';
        classification.type = 'detrimental; with positive epistasis';
        return;

    else 

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

    end
end
