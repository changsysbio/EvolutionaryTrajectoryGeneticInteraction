function c = CoefficientOfSecondPartForLargeInitialValue(functionName, initial_y, selection)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	assert(initial_y < 1);

	switch functionName
		case 'BeneficialZeroOrder'
			c = initial_y / (1 - initial_y);
			return;
		case 'BeneficialFirstOrderMinusS'
			c = initial_y * (1 + selection * initial_y) / (1 - initial_y);
			return;
		case 'BeneficialFirstOrderPlusS'
			c = initial_y  / ( (1 - initial_y) * (1 - selection * initial_y) );
			return;
		otherwise
			error(['Wrong function name: ' functionName]);
	end
end
