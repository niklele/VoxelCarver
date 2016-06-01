function [initialVoxel] = findInitial(voxels)
    mins = min(voxels);
    lowZ = mins(3);
    indices = find(voxels(:,3)==lowZ);
    lowZPlane = voxels(logical(indices), :);
    mins = min(lowZPlane);
    lowY = mins(2);
    indices = find(lowZPlane(:,2)==lowY);
    lowZYLine = lowZPlane(logical(indices),:);
    [~,I] = min(lowZYLine);
    initialVoxel = lowZYLine(I);
end