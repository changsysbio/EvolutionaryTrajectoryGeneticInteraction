function y = Detrimental(initial_y, mutation_rate, fitness, t)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    balance_level = mutation_rate / (1 - fitness);
    y = balance_level - (balance_level - initial_y) .* exp( - ( 1 - fitness) * t );
end
