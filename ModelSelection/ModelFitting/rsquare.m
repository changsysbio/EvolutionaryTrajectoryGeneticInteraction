function [r2 sse] = rsquare(y, f)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    sse = sum((y - f).^2);
    r2 = max(0.0, 1 - sse / sum( (y-mean(y)).^2));
end
