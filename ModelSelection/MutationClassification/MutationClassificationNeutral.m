function [classification] = MutationClassificationNeutral(gof, cf)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    classification.type = 'neutral; without epistasis';
    classification.epistasis_type = 'no epistasis';
    classification.fitness_b = 1;
    classification.fitness_ab = 1;
    classification.gof = gof;

end
