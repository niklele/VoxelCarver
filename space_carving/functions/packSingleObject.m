function[locations] = packSingleObject(container, obj, voxel_size)
    %most basic packing algorithm, assuming box. also assume objs sorted by
    %z value
    originalCandidate = findInitial(container);
    candidate = originalCandidate;
    yBound = 0;
    locations = [];
    while 1==1
        [errX, errY, errZ] = testFit(container, obj, candidate, voxel_size);
        objSize = obj;
        while errX ~= 0 || errY ~= 0
            if errZ ~= 0
                break
            elseif errY ~= 0
                candidate(3) = candidate(3) + objSize(3);
                candidate(1) = originalCandidate(1);
                candidate(2) = originalCandidate(2); %box assumption
                yBound = 0;
            elseif errX ~= 0
                candidate(1) = originalCandidate(1); %box assumption
                candidate(2) = candidate(2) + yBound;
                yBound = 0;
            end
            [errX, errY, errZ] = testFit(container, obj, candidate, voxel_size);
        end
        if errZ ~= 0
            break
        end
        locations = [locations; candidate];
        candidate(1) = candidate(1) + objSize(1);
        if objSize(2) > yBound
            yBound = objSize(2);
        end
    end
end