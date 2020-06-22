function classification = ModelSelection(T, Tp, cf, gof)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    classificationLevel{1} = ModelComplexityLevelOne(gof, cf);
    classificationLevel{2} = ModelComplexityLevelTwo(gof, cf);
    classificationLevel{3} = ModelComplexityLevelThree(gof, cf);
    classificationLevel{4} = ModelComplexityLevelFour(gof, cf);
    classificationLevel{5} = ModelComplexityLevelFive(gof, cf);
    classificationLevel{6} = ModelComplexityLevelSix(gof, cf);

    classification = [];
    for ( i = 1 : (length(classificationLevel) - 1) )

		% find the model that is better than predefined threshold
        if ( ~ isempty(classificationLevel{i}) )

            choice = i;
            check_next = false;

			% Check if any of the following models is significantly better than
			% i-th model.
			%
			% if no, then choose i-th model
			%
			% if yes, then continue go to i-th model and repeat the process
			%

            for ( j = (i + 1) : (length(classificationLevel) - 1) )

                if( isempty(classificationLevel{j}))
                    continue;
                end

                if ( (classificationLevel{j}.gof.bic <= ...
                        classificationLevel{choice}.gof.bic - 10) ...
                    & classificationLevel{j}.gof.averageR2 >= ...
                        classificationLevel{choice}.gof.averageR2 + 0.01 )

                     check_next = true;
                     break;
                end
            end

            % if no complexer model is better than current choice, choice it.
            if (~ check_next)
                break;
            end

        end
    end

	% if find out a model
    if ( exist('choice') )
        classification = classificationLevel{choice};
        return;
    end

	% if none of the levels 1-5 is OK, check mutation with flat trajectory
    if ( ~isempty(classificationLevel{end}) )
        classification = classificationLevel{end};
        return;
    end

    for ( i = 1:length(gof) )
        if (~isempty(gof{i}))
            if (gof{i}.rsquare >= 0.8 & gof{i}.linearR2 >= 0.8 )

                classification.type = 'R2 check';
                classification.epistasis_type = 'other';
                classification.fitness_b = 0;
                classification.fitness_ab = 0;
                classification.gof.output = '';
                return;

            end
        end
    end

    classification.type = 'other';
    classification.epistasis_type = 'other';
    classification.fitness_b = 0;
    classification.fitness_ab = 0;
    classification.gof.output = '';
end

function classification = ModelComplexityLevelOne(gof, cf)

    N = 6;
    modelIndices = [N];
    threshold(modelIndices) = [0.8];
    classification = CompareSameComplexityModels(gof, cf, modelIndices, threshold);

end

function classification = ModelComplexityLevelTwo(gof, cf)

    B = 1;
    D = 2;
    modelIndices = [B D];
    threshold(modelIndices) = [0.8 0.8];
    classification = CompareSameComplexityModels(gof, cf, modelIndices, threshold);

end

function classification = ModelComplexityLevelThree(gof, cf)

    NC = 12;
    NI = 23;
    modelIndices = [NC NI];
    threshold(modelIndices) = [0.8 0.8];
    [classification winner] = ...
        CompareSameComplexityModels(gof, cf, modelIndices, threshold);
    if ( ~isempty(classification) )
        if ( winner == NC )
            classification.type = [classification.type ' (delay)'];
        else
            classification.type = [classification.type ' (hitchhiking)'];
        end
    end
end

function classification = ModelComplexityLevelFour(gof, cf)

    DC = 11; 
    DI = 22;
    BC = 9; 
    BI = 21;

    modelIndices = [DC DI BC BI];
    threshold(modelIndices) = [0.8 0.8 0.8 0.8];
    [classification winner] = ...
        CompareSameComplexityModels(gof, cf, modelIndices, threshold);
    if ( ~isempty(classification) )
        if ( winner == DC | winner == BC )
            classification.type = [classification.type ' (delay)'];
        else
            classification.type = [classification.type ' (hitchhiking)'];
        end
    end

end

function classification = ModelComplexityLevelFive(gof, cf)

    BB = 4;
    BD = 8;
    DB = 7;
    DD = 5;

    modelIndices = [BB BD DB DD];
    threshold(modelIndices) = [0.9 0.9 0.9 0.9];
    classification = CompareSameComplexityModels(gof, cf, modelIndices, threshold);

end

function classification = ModelComplexityLevelSix(gof, cf)

    classification = [];

    try
        if ( gof{10}.p_value > 0.1 )
            classification = MutationClassificationMutationWithFlatTrajectory(gof{10});
        end
    end
end
