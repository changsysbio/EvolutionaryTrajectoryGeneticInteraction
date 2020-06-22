function y = BeneficialZeroOrder(mutation_rate, selection, c, t)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    y = c .* exp(selection .* t) ./ (c .* exp(selection .* t) + 1);
end
