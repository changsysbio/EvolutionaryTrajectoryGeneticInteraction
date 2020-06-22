function ModelFittingPlot(model, T, Tp, gof, xtitle, ytitle, zoom, titleString)

    %
    % Chang Chang, Simone Bianco, Ashley Acevedo, Chao Tang, Raul Andino.
    % Genetic interactions shaping evolutionary trajectories in an RNA virus
    % population. bioRxiv, 2020, https://doi.org/10.1101/2020.01.16.908129
    %
    
    % Plot this fit
    %set (gcf, 'Position', [400,100,600,600]);
    set(gca, 'YScale', 'log');  
    set(gca, 'YMinorTick', 'off', 'LineWidth', 0.8);  
    set(gca,'Fontname', 'Arial', 'FontSize', 38 * zoom);
    box on;
    hold all;
    xlim([0 50]);
    if ( zoom < 0.75)
        set(gca,'XTick', [0 25 50]) 
    else
        set(gca,'XTick', [0 10 20 30 40 50])
    end
    if ( max(Tp > 1e-2 ))
        ylim([1e-5 1]);
        set(gca,'YTick', [1e-5 1e-4 1e-3 1e-2 1e-1 1]);
    else
        ylim([1e-5 1e-2]);
        set(gca,'YTick', [1e-5 1e-4 1e-3 1e-2]);
    end

    semilogy(T, Tp, 'k.', 'MarkerSize', 21 * zoom);
    myCurve = plot(gof.correspondingFitInLS, 'fit', 0.95);
    set(myCurve, 'color', 'b', 'LineWidth', 3 * zoom);
    legend off;
    xlabel(xtitle);
    ylabel(ytitle);
    if ( ~ exist('titleString') )
        title(strcat('(', model, ', {\itl} =', {32}, num2str(roundn(gof.rsquare, -2)), ...
            ', {\itn} = ', {32}, num2str(roundn(gof.linearR2, -2)), ')' ));
    else
        title(titleString);
    end
    set(get(gca,'TITLE'),'FontSize', 34 * zoom);
    set(get(gca,'Xlabel'),'FontSize', 38 * zoom);
    set(get(gca,'Ylabel'),'FontSize', 38 * zoom);
end
