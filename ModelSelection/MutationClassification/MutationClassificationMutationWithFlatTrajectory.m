function [classification] = MutationClassificationMutationWithFlatTrajectory(gof)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    classification.type = 'mutation with flat trajectory';
    classification.epistasis_type = 'no epistasis';
    classification.gof = gof;
    classification.fitness_b = 0;
    classification.fitness_ab = 0;

end
