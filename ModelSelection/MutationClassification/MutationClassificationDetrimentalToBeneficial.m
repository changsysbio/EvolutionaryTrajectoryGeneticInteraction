function [classification] = MutationClassificationDetrimentalToBeneficial(gof, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b < 1);
	assert(cf.fitness_ab > 1);
	
    establishmentThreshold = 1e-5;
    beneficialThreshold = 1.05;
    detrimentalThreshold = 0.9;
    epistasisThreshold = 0.15;
	assert(beneficialThreshold - detrimentalThreshold ...
		<= epistasisThreshold + 0.001 );

    classification.fitness_b = cf.fitness_b;
    classification.fitness_ab = cf.fitness_ab;
    classification.gof = gof;

    if (cf.fitness_ab - cf.fitness_b <= epistasisThreshold)

		% including the situation that
		% cf.fitness_ab <= beneficialThreshold
        %     & cf.fitness_b >= detrimentalThreshold

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

    else

        % check establishment        
        balance_level_b = cf.mutation_rate_b / ( 1 - cf.fitness_b);
        if( balance_level_b <= establishmentThreshold ) 

            classification.epistasis_type = 'no epistasis';
            classification.type = 'establishment';
            classification.fitness_b = classification.fitness_ab;
            return;

        end

        if ( cf.fitness_ab > beneficialThreshold)

            classification = MutationClassificationDetrimentalPositiveEpistasisBeneficial(...
                classification, cf);
            assert( ~ isempty(classification) );
            return;

        else

        	assert(cf.fitness_ab <= beneficialThreshold);
			assert(cf.fitness_b <= detrimentalThreshold);

            classification = MutationClassificationCompensatedMutation(...
                classification, cf);
            assert( ~ isempty(classification) );
            return;

        end

    end

end
