# EvolutionaryTrajectoryGeneticInteraction

## Publication

When using this code for research purposes, please cite:

Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino. Genetic interactions shaping evolutionary trajectories in an RNA virus population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129

## General description

A very general description of this scientific research is available at http://cqb.pku.edu.cn/tanglab/News/shownews.php?id=211&lang=en

In short, the purpose of the algorithm is to determine the best interaction model for each mutant trajectory: no epistasis, epistasis, clonal interference, hitchhiking, etc., and infer the impact of the evolutionary factors based on the best interaction model.

## Sample datasets and input file format

* Sample dataset 1 (without epistasis): [simulation_neutral_3.trajectory](https://drive.google.com/file/d/1wyZXGlcmAlb8psQW3mCU_916yfCruMGd/view?usp=sharing)

In this simulation, the length of the genome is 1000, the number of mutations with large fitness is 3 (fitness=1.5; id=0,1,2), and all remaining mutations are neutral (fitness=1.0; id=3,...,999). The per locus mutation rate is 10^-4. See Supplementary Fig. 18 for more information.

* Sample dataset 2 (with epistasis): [simulation_epistasis_38.trajectory](https://drive.google.com/file/d/1IkElA9bsF6B8QQVxBQa8WJLKt6aoNU2C/view?usp=sharing)

In this simulation, the length of the genome is 1000, the number of mutations with large fitness is 3 (fitness=1.5; id=0,1,2), roughly half of the remaining mutations are under negative epistasis (0.9 to 0.6; id=3,...,499), and another half are under positive epistasis (0.6 to 0.9; id=500,...,999). The pairs of the ids of interacting mutations are: 0-3, 1-4, 2-5, 0-6, 1-7, 2-8, ... The per locus mutation rate is 10^-4. See Supplementary Fig. 19 for more information.

* Input file format:

The first column gives the passage number or the generation number (i.e., time), followed by columns of additional information such as population size, and the remaining columns are the frequencies of the mutation changing with time (id=0,1,2, ...).

If the input file format is different to the above description, an user can customize the code at [/ModelSelection/Data/ReadMatrixData.m](https://github.com/changsysbio/EvolutionaryTrajectoryGeneticInteraction/blob/master/ModelSelection/Data/ReadMatrixData.m)

## Install

Download all files and add them to the search path of MATLAB.

## Tutorial

Running the program is quite simple. Enter:

```matlab
DetermineMutationInteractionModel(inputFilename);
```

in the terminal of MATLAB, where *inputFilename* is the filename/path of the input file. There are two types of outcome:

* A figure with multiple panels representing the fitting of different models to each mutation trajectory (See Supplementary Fig. 12 as a reference)

[Mutation 2 from Sample data set 1, fitness=1.5, with clonal interference](https://drive.google.com/file/d/1J1cJvgI1DB4qZMdkDCbXCLXpAm2VfYGh/view?usp=sharing)

[Mutation 32 from Sample data set 1, fitness=1.0, one-locus model](https://drive.google.com/file/d/1oY6eKJDfsJfLEQ1AIKAau7SHhq2eRa6w/view?usp=sharing)

[Mutation 16 from Sample data set 1, fitness=1.0, with clonal interference](https://drive.google.com/file/d/1jegNG0wCgZFHWAxTbdocwyCyOwGlbA7R/view?usp=sharing)

[Mutation 50 from Sample data set 1, fitness=1.0, with hitchhiking](https://drive.google.com/file/d/1URKrHTJdcSAdm-2YXGuRq0BhXU8y9sHH/view?usp=sharing)

* A txt file with the mutation classification information.

Example mutation classification information for Sample dataset 1: simulation_neutral_3.trajectory.classification_summary.txt

Example mutation classification information for Sample dataset 2: simulation_epistasis_38.trajectory.classification_summary.txt

Since the initialization of the parameters are random, the outcome of different runs might be slightly different but will be very similar.

