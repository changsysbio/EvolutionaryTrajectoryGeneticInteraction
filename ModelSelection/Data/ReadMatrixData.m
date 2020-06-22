function [passage, abundance, mutantId] = ReadMatrixData(input)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    mutantStartId = '0';
    mutantIdPattern = '\d';
    splitPattern = '\t';

    fid = fopen(input);

    headerline = fgetl(fid);
    headers = regexp(headerline, splitPattern, 'split');
    genomeStartPosition = find(strcmp(headers, mutantStartId));
    for index = genomeStartPosition : length(headers)
        if regexp(headers{index}, mutantIdPattern)
            genomeEndPosition = index;
        else
            break;
        end
    end

    data = textscan(fid, [repmat(['%f' splitPattern], 1, genomeEndPosition)], ...
        'headerlines', 1);
    passage = data{1};
    abundance = data(genomeStartPosition:genomeEndPosition);
    mutantId = headers(genomeStartPosition:genomeEndPosition);
    
end
