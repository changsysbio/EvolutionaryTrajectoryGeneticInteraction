function [classification] = MutationClassificationDetrimentalNegativeEpistasis(classification, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b < 1.05);
	assert(cf.fitness_b > cf.fitness_ab);

    mutationRateThreshold = 5e-5;
    thresholdForHighMutationRate = 0.15;
    thresholdForLowMutationRate = 0.2;
    balanceThreshold = 2;
    detrimentalFitnessThreshold = 0.98;

    balance_level_b = cf.mutation_rate_b / ( 1 - cf.fitness_b);
    balance_level_ab = cf.mutation_rate_b / ( 1 - cf.fitness_ab);

    fitnessType = FitnessType(cf.fitness_b);

    if (balance_level_b / balance_level_ab > balanceThreshold ...
        | cf.fitness_b > 1)

        if ( cf.mutation_rate_b > mutationRateThreshold & ...
            cf.fitness_b - cf.fitness_ab > thresholdForHighMutationRate)

            classification.epistasis_type = 'negative epistasis';
            if ( strcmp(fitnessType, 'detrimental') )
                classification.type = 'detrimental; with negative epistasis';
            else
                classification.type = [fitnessType ' to detrimental'];
            end
            return;

        elseif ( cf.mutation_rate_b <= mutationRateThreshold & ...
            cf.fitness_b - cf.fitness_ab > thresholdForLowMutationRate)

            classification.epistasis_type = 'negative epistasis';
            if ( strcmp(fitnessType, 'detrimental') )
                classification.type = 'detrimental; with negative epistasis';
            else
                classification.type = [fitnessType ' to detrimental'];
            end
            return;

        else

			classification = ActuallyNotEpistasis(classification);
			assert( ~ isempty(classification) );
			return;

        end

    else

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

    end
end
