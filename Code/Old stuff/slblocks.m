function blkStruct = slblocks
% This function specifies that the library 'mylib'
% should appear in the Library Browser with the 
% name 'Skripsie Library'

    Browser.Library = 'skripsie_lib';
    % 'skripsie_lib' is the name of the library

    Browser.Name = 'Skripsie Library';
    % 'Skripsie Library' is the library name that appears
    % in the Library Browser

    blkStruct.Browser = Browser;