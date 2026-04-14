'batch_export.m'
function batch_export()
    % Get current date and time
    dateTimeStr = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    
    % Create screenshots directory if it doesn't exist
    outputDir = fullfile(pwd, 'screenshots');
    if ~exist(outputDir, 'dir')
        mkdir(outputDir);
    end
    
    % Get all open figures
    figHandles = findobj('Type', 'figure');
    if isempty(figHandles)
        disp('No open figures to export.');
        return;
    end

    % Export each figure
    for i = 1:length(figHandles)
        fig = figHandles(i);
        % Create a unique filename
        filename = fullfile(outputDir, sprintf('figure_%s_%d.png', dateTimeStr, i));
        
        % Save the figure as PNG
        saveas(fig, filename);
    end
    
    disp(['Exported ' num2str(length(figHandles)) ' figures to ' outputDir]);
end
