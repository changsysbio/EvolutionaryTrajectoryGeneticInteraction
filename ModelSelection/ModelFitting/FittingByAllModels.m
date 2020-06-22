function [output cf gof] = FittingByAllModels(T, data, repeat)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    [cf{6} gof{6}] = FitNeutral(T, data, repeat);
    gof{6}.classificationFunction = 'MutationClassificationNeutral';

    [cf{12} gof{12}] = FitNeutralDelay(T, data, repeat);
    gof{12}.classificationFunction = 'MutationClassificationNeutral';

    [cf{23} gof{23}] = FitNeutralInitial2(T, data, repeat);
    gof{23}.classificationFunction = 'MutationClassificationNeutral';

    [cf{1} gof{1}] = FitBeneficial(T, data, repeat);
    gof{1}.classificationFunction = 'MutationClassificationBeneficial';

    [cf{9} gof{9}] = FitBeneficialDelay(T, data, repeat);
    gof{9}.classificationFunction = 'MutationClassificationBeneficial';

    [cf{21} gof{21}] = FitBeneficialInitial2(T, data, repeat);
    gof{21}.classificationFunction = 'MutationClassificationBeneficial';

    [cf{2} gof{2}] = FitDetrimental(T, data, repeat);
    gof{2}.classificationFunction = 'MutationClassificationDetrimental';

    [cf{11} gof{11}] = FitDetrimentalDelay(T, data, repeat);
    gof{11}.classificationFunction = 'MutationClassificationDetrimental';

    [cf{22} gof{22}] = FitDetrimentalInitial2(T, data, repeat);
    gof{22}.classificationFunction = 'MutationClassificationDetrimental';

    [cf{4} gof{4}] = FitBeneficialToBeneficial(T, data, repeat);
    gof{4}.classificationFunction = 'MutationClassificationBeneficialToBeneficial';

    [cf{8} gof{8}] = FitBeneficialToDetrimental(T, data, repeat);
    gof{8}.classificationFunction = 'MutationClassificationBeneficialToDetrimental';

    [cf{7} gof{7}] = FitDetrimentalToBeneficial(T, data, repeat);
    gof{7}.classificationFunction = 'MutationClassificationDetrimentalToBeneficial';

    [cf{5} gof{5}] = FitDetrimentalToDetrimental(T, data, repeat);
    gof{5}.classificationFunction = 'MutationClassificationDetrimentalToDetrimental';

    [cf{10} gof{10}] = FitMutationWithFlatTrajectory(T, data);

    % to ensure the existence of cf and gof
    cf{24} = [];
    gof{24} = [];

    output = '';
    for ( i = 1:23)
        if (~isempty(gof{i}))
            output = strcat(output, num2str(gof{i}.rsquare), ',', num2str(gof{i}.linearR2));
        end
        output = [output, ','];
    end

    gof{1}.output = OneLocusFittingOutput(cf{1});
    output = [gof{1}.output, ','];    
    gof{2}.output = OneLocusFittingOutput(cf{2});
    output = [output, gof{2}.output, ','];  
    gof{4}.output = TwoLociFittingOutput(cf{4});
    output = [output, gof{4}.output, ',']; 
    gof{5}.output = TwoLociFittingOutput(cf{5});
    output = [output, gof{5}.output, ',']; 
    gof{6}.output = NeutralFittingOutput(cf{6});
    output = [output, gof{6}.output, ',']; 
    gof{7}.output = TwoLociFittingOutput(cf{7});
    output = [output, gof{7}.output, ',']; 
    gof{8}.output = TwoLociFittingOutput(cf{8});
    output = [output, gof{8}.output, ',']; 
    gof{9}.output = ClonalInterferenceFittingOutput(cf{9});
    output = [output, gof{9}.output, ',']; 
    gof{10}.output = SecondFormMutationSelectionBalanceFittingOutput(gof{10});
    output = [output, gof{10}.output, ',']; 
    gof{11}.output = ClonalInterferenceFittingOutput(cf{11});
    output = [output, gof{11}.output, ',']; 
    gof{12}.output = ClonalInterferenceFittingOutput(cf{12});
    output = [output, gof{12}.output, ',']; 
    gof{21}.output = OneLocusInitial2FittingOutput(cf{21});
    output = [output, gof{21}.output, ','];
    gof{22}.output = OneLocusInitial2FittingOutput(cf{22});
    output = [output, gof{22}.output, ','];
    gof{23}.output = OneLocusInitial2FittingOutput(cf{23});
    output = [output, gof{23}.output];
end

function output = OneLocusFittingOutput(cf)

    output = '';
    if ( ~isempty(cf) )
        output = strcat('fitness=', num2str(cf.fitness), ...
            '; mutation_rate=', num2str(cf.mutation_rate));
    end

end

function output = NeutralFittingOutput(cf)

    output = '';
    if ( ~isempty(cf) )
        output = strcat('u_plus=', num2str(cf.u_plus));
    end

end

function output = SecondFormMutationSelectionBalanceFittingOutput(gof)

    output = '';
    if ( ~isempty(gof) )
        output = strcat('decision=', num2str(gof.decision), ...
            '; p-value=', num2str(gof.p_value));
    end

end

function output = TwoLociFittingOutput(cf)

    output = '';
try %TODO
    if ( ~isempty(cf) )
        output = strcat('mutation_rate_a=', num2str(cf.mutation_rate_a), ...
            '; fitness_a=', num2str(cf.fitness_a), ...
            '; mutation_rate_b=', num2str(cf.mutation_rate_b), ...
            '; fitness_b=', num2str(cf.fitness_b), ...
            '; fitness_ab=', num2str(cf.fitness_ab));
    end 
end

end

function output = ClonalInterferenceFittingOutput(cf)

    output = '';
    if ( ~isempty(cf) )
        if ( ~isempty(find(strcmp(argnames(cf), 'fitness_b'))) ) % CI(B), CI(D)
            output = strcat('mutation_rate_a=', num2str(cf.mutation_rate_a), ...
                '; fitness_a=', num2str(cf.fitness_a), ...
                '; mutation_rate_b=', num2str(cf.mutation_rate_b), ...
                '; fitness_b=', num2str(cf.fitness_b), ...
                '; delay=', num2str(cf.delay));
        else % CI(N)
            output = strcat('mutation_rate_a=', num2str(cf.mutation_rate_a), ...
                '; fitness_a=', num2str(cf.fitness_a), ...
                '; mutation_rate_b=', num2str(cf.mutation_rate_b), ...
                '; fitness_b=', num2str(1), ...
                '; delay=', num2str(cf.delay)); 
        end           
    end 

end

function output = TwoLociDelayFittingOutput(cf)

    output = '';
    if ( ~isempty(cf) )
        output = strcat('mutation_rate_a=', num2str(cf.mutation_rate_a), ...
            '; fitness_a=', num2str(cf.fitness_a), ...
            '; mutation_rate_b=', num2str(cf.mutation_rate_b), ...
            '; fitness_b=', num2str(cf.fitness_b), ...
            '; fitness_ab=', num2str(cf.fitness_ab), ...
            '; delay=', num2str(cf.delay)); 
    end 

end

function output = OneLocusInitial2FittingOutput(cf)

    output = '';
    if ( ~isempty(cf) )
        if ( ~isempty(find(strcmp(argnames(cf), 'fitness_b'))) )
            output = strcat('mutation_rate_a=', num2str(cf.mutation_rate_a), ...
                '; fitness_a=', num2str(cf.fitness_a), ...
                '; mutation_rate_b=', num2str(cf.mutation_rate_b), ...
                '; fitness_b=', num2str(cf.fitness_b), ...
                '; initial2=', num2str(cf.initial2)); 
        else
            output = strcat('mutation_rate_a=', num2str(cf.mutation_rate_a), ...
                '; fitness_a=', num2str(cf.fitness_a), ...
                '; mutation_rate_b=', num2str(cf.mutation_rate_b), ...
                '; initial2=', num2str(cf.initial2));
        end
    end 

end

function output = TwoLociInitial2FittingOutput(cf)

    output = '';
    if ( ~isempty(cf) )
        output = strcat('mutation_rate_a=', num2str(cf.mutation_rate_a), ...
            '; fitness_a=', num2str(cf.fitness_a), ...
            '; mutation_rate_b=', num2str(cf.mutation_rate_b), ...
            '; fitness_b=', num2str(cf.fitness_b), ...
            '; fitness_ab=', num2str(cf.fitness_ab), ...
            '; initial2=', num2str(cf.initial2)); 
    end 

end
