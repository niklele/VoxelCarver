function[errX, errY, errZ] = testFit(voxels, dims, candidate, voxel_size)
    %assuming a box, for now
    x = candidate(1);
    y = candidate(2);
    z = candidate(3);
    errX = 1;
    errY = 1;
    errZ = 1;
    xLength = dims(1);
    yLength = dims(2);
    zLength = dims(3);
    pt1 = [x+xLength,y,z];
    pt2 = [x, y+yLength,z];
    pt3 = [x, y, z+zLength];
    pt1Dists = pdist2(pt1,voxels);
    pt2Dists = pdist2(pt2,voxels);
    pt3Dists = pdist2(pt3,voxels);
    if min(pt1Dists) < sqrt(2).*voxel_size./2
        errX = 0;
    end
    if min(pt2Dists) < sqrt(2).*voxel_size./2
        errY = 0;
    end
    if min(pt3Dists) < sqrt(2).*voxel_size./2
        errZ = 0;
    end
    
    %have to round these distances somehow to get everything right
    %if we want to not assume a box we will have to check points on all the
    %sides

end