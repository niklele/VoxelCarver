function [ count ] = findPackCount( container_dir, object_dir, num_samples )
%FINDPACKCOUNT Summary of this function goes here
%   Detailed explanation goes here
    container_d = rdir([container_dir, '*.voxels']);
    object_d = rdir([object_dir, '*.voxels']);
    
    locations = [];
    for i = 1:num_samples
        container_file = container_d(randsample(length(container_d), 1)).name;
        object_file = object_d(randsample(length(object_d), 1)).name;
        
        container = dlmread(container_file, ' ');
        object = dlmread(object_file, ' ');
        
        container_voxel_size = 0.0;
        idx = 1;
        while container_voxel_size == 0.0
            container_voxel_size = container(2,idx) - container(1,idx);
            idx = idx + 1;
        end
        object_box = makeBoundingRect(object);
        packing = packSingleObject(container,object_box,container_voxel_size);
        locations = [locations size(packing, 1)];
           %illustrateSingle(locations, obj, container, 10000);
    end
    
    count = mean(locations);
end

