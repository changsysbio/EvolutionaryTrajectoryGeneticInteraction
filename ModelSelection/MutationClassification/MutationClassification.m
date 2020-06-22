function [classification fitResults] = MutationClassification(T, data, titleString)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    repeat = 5;

    [T, data] = DataFiltering(T, data);
    [fitResults cf gof] = FittingByAllModels(T, data, repeat);
    classification = ModelSelection(T, data, cf, gof);
    if ~ exist('titleString', 'var')
        titleString = classification.type;
    end
    PlotsForAllModels(T, data, gof, titleString);
end
