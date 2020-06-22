function y = Beneficial(initial_y, mutation_rate, fitness, t)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    % There are several different analytical approximations for the trajectory
    % of a one-locus beneficial beneficial mutation but their performance in
    % simulation is similar. Here we use the one with simplest form: zero-order
    % approximation.
    %
    
    approximationFunction = 'BeneficialZeroOrder';

	selection = fitness - 1;
    threshold = ThresholdInBeneficialModel(mutation_rate, selection);

	if (initial_y < threshold)

		shift = ShiftBasedOnBeneficialFirstPart(initial_y, mutation_rate, selection);

		y1 = BeneficialFirstPart(mutation_rate, selection, t + shift);
		c = mutation_rate / selection;
    	y2 = eval([approximationFunction '(mutation_rate, selection, c, t + shift)']);

    	y = CombineBeneficialTwoParts(y1, y2, t, threshold);
    	
    	return;
	else
		c = CoefficientOfSecondPartForLargeInitialValue(...
			approximationFunction, initial_y, selection);
    	y = eval([approximationFunction '(mutation_rate, selection, c, t)']);
    	return;
	end

end

function threshold = ThresholdInBeneficialModel(mutation_rate, selection)
	threshold = sqrt(mutation_rate / selection);
end

function y = CombineBeneficialTwoParts(y1, y2, t, threshold)

    y1_index = find ( y1 < threshold );

    if ( length(y1_index) == length(t) )

        y = y1;

    elseif ( length(y1_index) ~= 0 )

        y = y2;
        y(y1_index) = y1(y1_index);

    elseif ( length(y1_index) == 0 )

        y = y2;

    end

end
