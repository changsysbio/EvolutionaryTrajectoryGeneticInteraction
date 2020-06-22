function y = NeutralDelay(mutation_rate_a, fitness_a, mutation_rate_b, delay, t)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    % parameters
    % a: the major one
    % b: the minor one
    % ab: double mutation

    a = Beneficial(0, mutation_rate_a, fitness_a, t);
    WT = 1 - a;
    b = Neutral(mutation_rate_b, 0, t);

    ab_time = t - delay;
    establishment = find( ab_time > 0 );
    ab = mutation_rate_b .* ones(size(a));
    ab(establishment) = max( ab(establishment), ...
        Neutral(mutation_rate_b, 0, ab_time(establishment)) );

    y = b .* WT + ab .* a;
end
