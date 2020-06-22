function PlotsForAllModels(T, data, gof, titleString)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0,2,8,8.5]);
    
    zoom = 0.25;

    subplot(4, 4, 1);
    ModelFittingPlot('N', T, data, gof{6}, '', '', zoom);

    subplot(4, 4, 2);
    ModelFittingPlot('N(D)', T, data, gof{12}, '', '', zoom);

	subplot(4, 4, 3);
	ModelFittingPlot('N(I)', T, data, gof{23}, '', '', zoom);

	subplot(4, 4, 5);
	ModelFittingPlot('B', T, data, gof{1}, '', '', zoom);

	subplot(4, 4, 6);
	ModelFittingPlot('B(D)', T, data, gof{9}, '', '', zoom);

	subplot(4, 4, 7);
	ModelFittingPlot('B(I)', T, data, gof{21}, '', '', zoom);

	subplot(4, 4, 9);
	ModelFittingPlot('D', T, data, gof{2}, '', '', zoom);

	subplot(4, 4, 10);
	ModelFittingPlot('D(D)', T, data, gof{11}, '', '', zoom);

	subplot(4, 4, 11);
	ModelFittingPlot('D(I)', T, data, gof{22}, '', '', zoom);

	subplot(4, 4, 12);
	ModelFittingPlot('F', T, data, gof{10}, '', '', zoom, ...
	    strcat('(F, {\itp-value} =', {32}, num2str(roundn(gof{10}.p_value, -3)), ')'));

	subplot(4, 4, 13);
	ModelFittingPlot('BB', T, data, gof{4}, '', '', zoom);

	subplot(4, 4, 14);
	ModelFittingPlot('BD', T, data, gof{8}, '', '', zoom);

	subplot(4, 4, 15);
	ModelFittingPlot('DB', T, data, gof{7}, '', '', zoom);

	subplot(4, 4, 16);
	ModelFittingPlot('DD', T, data, gof{5}, '', '', zoom);

    if ~ isempty(titleString)
        mySuptitle = suptitle(titleString);
        set(mySuptitle, 'FontSize', 22);
    end
    
end
