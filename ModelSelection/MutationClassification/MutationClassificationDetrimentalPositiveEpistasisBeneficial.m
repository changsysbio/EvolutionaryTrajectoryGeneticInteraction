function [classification] = MutationClassificationDetrimentalPositiveEpistasisBeneficial(classification, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b < 1);
	assert(cf.fitness_ab > 1);

    mutationRateThreshold = 5e-6;
    thresholdForHighMutationRate = 0.15;
    thresholdForLowMutationRate = 0.25;

    fitnessType = FitnessType(cf.fitness_b);

    if ( cf.mutation_rate_b > mutationRateThreshold & ...
        cf.fitness_ab - cf.fitness_b > thresholdForHighMutationRate )

        classification.epistasis_type = 'positive epistasis';
        classification.type = [fitnessType ' to beneficial'];
        return;

    elseif ( cf.mutation_rate_b <= mutationRateThreshold & ...
        cf.fitness_ab - cf.fitness_b > thresholdForLowMutationRate )

        classification.epistasis_type = 'positive epistasis';
        classification.type = [fitnessType ' to beneficial'];
        return;

    else

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

    end
end
