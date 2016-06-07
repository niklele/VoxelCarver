function [initialVoxel] = findInitial(voxels)
    mins = min(voxels);
    lowZ = mins(3);
    indices = find(voxels(:,3)==lowZ);
    lowZPlane = voxels(indices, :);
    if size(lowZPlane,1) ==1
        initialVoxel = lowZPlane;
        return
    end
    mins = min(lowZPlane);
    lowY = mins(2);
    indices = find(lowZPlane(:,2)==lowY);
    lowZYLine = lowZPlane(indices,:);
    if size(lowZYLine,1) ==1
        initialVoxel = lowZYLine;
    else
        [~,I] = min(lowZYLine);
        initialVoxel = lowZYLine(I(1),:);
    end
end