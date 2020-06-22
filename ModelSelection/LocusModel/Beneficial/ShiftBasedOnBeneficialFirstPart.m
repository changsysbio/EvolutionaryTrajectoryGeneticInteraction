function shift = ShiftBasedOnBeneficialFirstPart(initial_y, mutation_rate, selection)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	shift = log(initial_y * selection / mutation_rate + 1) / selection;
end
