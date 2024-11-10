function [result] = longestWord( inputFile )
%
% inputFile specifies the file whose characters should
% be analyzed.
%
% Periods, commas, apostrophes, and other punctuation
% marks DO NOT count towards the length of a word.
% For example, in the sentence “The quick red fox
% jumped over the lazy brown dog.” the last word is
% considered to have a length of three (ignoring the
% period).
%
% If inputFile cannot be opened, the function will
% print a descriptive error message and return the
% value -1.
%
function [result] = longestWord(inputFile)
    fid = fopen(inputFile, 'r');
    if fid == -1
        fprintf('Error: Unable to open the file %s\n', inputFile);
        result = -1;
        return;
    end
    
    longestStreak = 0;
    currentStreak = 0;
    while ~feof(fid)
        char = fread(fid, 1, '*char');
        if isletter(char)
            currentStreak = currentStreak + 1;
        elseif any(char == [' ', '.', ',', '!', '?'])
            if currentStreak > longestStreak
                longestStreak = currentStreak;
            end
            currentStreak = 0;
        end
    end
    % Final check for the longest streak at the end of file
    if currentStreak > longestStreak
        longestStreak = currentStreak;
    end
    fclose(fid);
    result = longestStreak;
end
