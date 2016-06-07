function [  ] = saveVoxels( voxels, outfile )
%SAVEVOXELS Summary of this function goes here
%   Detailed explanation goes here
    dlmwrite(outfile, voxels, ' ');

end

