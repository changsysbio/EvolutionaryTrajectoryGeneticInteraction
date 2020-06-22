function DetermineMutationInteractionModel(input)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    [passage, abundance, mutantId] = ReadMatrixData(input);

    outputDir = [input '_classification'];
    if ( exist(outputDir, 'dir') ~= 7 )
        mkdir(outputDir);
    end
    outputFile = [input '.classification_summary.txt'];

    fitOutput = fopen(outputFile, 'at');
    fprintf(fitOutput, ['mutant_id\t' 'epistasis\t' 'type\t', 'f_b\t', ...
        'f_ab\t', 'parameters\t', 'parameters_of_all_models\n']);
    for ( i = 1 : length(abundance) )

        outputEps = [outputDir '/' mutantId{i} '.eps'];
        outputFig = [outputDir '/' mutantId{i} '.fig'];

        if ( exist(outputEps, 'file') == 2 )
            fprintf([outputEps, ' exists. Skip.\n']);
            continue;
        else
            system(['touch ' outputEps]);
        end

        [classification fitResults] = MutationClassification(...
            passage, abundance{i});
        
        fprintf(fitOutput, '%s\t%s\t%s\t%f\t%f\t%s\t%s\n', mutantId{i}, ...
            classification.epistasis_type, classification.type, ...
            classification.fitness_b, classification.fitness_ab, ...
            classification.gof.output, fitResults);

        saveas(1, outputEps, 'psc2');
        saveas(1, outputFig, 'fig');

        close 1;
    end
end
