function [classification] = MutationClassificationBeneficialToDetrimental(gof, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(cf.fitness_b > 1);
	assert(cf.fitness_ab < 1);

    beneficialThreshold = 1.05;
    detrimentalThreshold = 0.9;
    epistasisThreshold = 0.15;
	assert(beneficialThreshold - detrimentalThreshold ...
		<= epistasisThreshold + 0.001 );

    classification.fitness_b = cf.fitness_b;
    classification.fitness_ab = cf.fitness_ab;
    classification.gof = gof;

	if( cf.fitness_b - cf.fitness_ab <= epistasisThreshold)

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

	elseif ((cf.fitness_b > beneficialThreshold) ...
		& (cf.fitness_ab > detrimentalThreshold))

		classification = ActuallyNotEpistasis(classification);
		assert( ~ isempty(classification) );
		return;

    elseif ((cf.fitness_b <= beneficialThreshold) ...
    	& (cf.fitness_ab <= detrimentalThreshold))

		classification = MutationClassificationDetrimentalNegativeEpistasis(...
			classification, cf);
		assert( ~ isempty(classification) );
		return;

    else

    	assert(cf.fitness_ab < detrimentalThreshold);

		classification.epistasis_type = 'negative epistasis';
		classification.type = 'beneficial to detrimental';
		return;

	end
end

