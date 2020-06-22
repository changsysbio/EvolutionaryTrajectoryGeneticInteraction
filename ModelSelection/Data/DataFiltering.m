function [T, data] = DataFiltering(T, data)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    % Filtering data
    index = isfinite(T) & isfinite(data) & (data ~= 0);

    T = T(index);
    data = data(index);

end
