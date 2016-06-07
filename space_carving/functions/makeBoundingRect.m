function [lims] = makeBoundingRect(voxels)
    mins = min(voxels);
    maxs = max(voxels);
    xSize = maxs(1) - mins(1);
    ySize = maxs(2) - mins(2);
    zSize = maxs(3) - mins(3);
    lims = [xSize, ySize, zSize]; 
end