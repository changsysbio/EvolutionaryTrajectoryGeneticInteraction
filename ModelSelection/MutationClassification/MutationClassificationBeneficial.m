function [classification] = MutationClassificationBeneficial(gof, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
	[classification] = MutationClassificationOneLocus(gof, cf);
	assert(classification.fitness_b > 1);

end
