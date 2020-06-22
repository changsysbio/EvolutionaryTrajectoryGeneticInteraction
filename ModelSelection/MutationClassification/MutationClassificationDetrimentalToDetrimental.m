function [classification] = MutationClassificationDetrimentalToDetrimental(gof, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b < 1);
	assert(cf.fitness_ab < 1);

    establishmentThreshold = 1e-5;
    compensatedThreshold = 0.9;
    detrimentalPositiveEpistasisThreshold = 0.1;
    detrimentalNegativeEpistasisThreshold = 0.15;

    classification.fitness_b = cf.fitness_b;
    classification.fitness_ab = cf.fitness_ab;
    classification.gof = gof;

    balance_level_b = cf.mutation_rate_b / ( 1 - cf.fitness_b);
    balance_level_ab = cf.mutation_rate_b / ( 1 - cf.fitness_ab);

    if ( (cf.fitness_ab < cf.fitness_b - detrimentalNegativeEpistasisThreshold))

        classification = MutationClassificationDetrimentalNegativeEpistasis(...
            classification, cf);
        assert( ~ isempty(classification) );
        return;

    elseif (cf.fitness_b < cf.fitness_ab - detrimentalPositiveEpistasisThreshold)

        if( balance_level_b <= establishmentThreshold ...
            & balance_level_ab > establishmentThreshold ) 

            classification.epistasis_type = 'no epistasis';
            classification.type = 'establishment';
            classification.fitness_b = classification.fitness_ab;
            return;

        elseif( balance_level_b > establishmentThreshold ...
            & balance_level_ab <= establishmentThreshold ) 

            classification.epistasis_type = 'no epistasis';
            classification.type = 'extinction';
            return;

        elseif( balance_level_b <= establishmentThreshold ...
            & balance_level_ab <= establishmentThreshold ) 

            classification.epistasis_type = 'no epistasis';
            classification.type = 'under establishment';
            return;

        else

            if( cf.fitness_ab >= compensatedThreshold )
                classification = MutationClassificationCompensatedMutation(...
                    classification, cf);
                assert( ~ isempty(classification) );
                return;
            else
                classification = ...
                    MutationClassificationDetrimentalPositiveEpistasis(...
                    classification, cf);
                assert( ~ isempty(classification) );
                return;
            end
        end

    else

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

    end

end

