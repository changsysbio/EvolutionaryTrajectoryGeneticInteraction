function [classification] = MutationClassificationBeneficialToBeneficial(gof, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b > 1);
	assert(cf.fitness_ab > 1);

    beneficialEpistasisThreshold = 0.05;

    classification.fitness_b = cf.fitness_b;
    classification.fitness_ab = cf.fitness_ab;
    classification.gof = gof;

    if ( abs( cf.fitness_ab - cf.fitness_b) <= beneficialEpistasisThreshold ) 

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

    else 

        if ( cf.fitness_ab > cf.fitness_b )

            classification = ...
                MutationClassificationBeneficialPositiveEpistasis(...
                classification, cf);
            assert( ~ isempty(classification) );
            return;

        else

            classification = ...
                MutationClassificationBeneficialNegativeEpistasis(...
                classification, cf);
            assert( ~ isempty(classification) );
            return;

        end

    end
end

