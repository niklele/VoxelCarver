function[] = illustrate(locations, objs, container, numVoxels)
    %totalNumVox = size(objs,1)*numVoxels;
    %allVox = zeros(totalNumVox, 3);
    %try not to dynamically size later
    allVox = [];
    for i=1:size(locations,1)
        start = locations(i,:);
        sizes = objs(i,:);
        x = start(1);
        y = start(2);
        z = start(3);
        xp = sizes(1) + x;
        yp = sizes(2) + y;
        zp = sizes(3) + z;
        vox = formInitialVoxels([x,xp],[y yp],[z zp],numVoxels);
        allVox = [allVox; vox];
    end
    figure();
    plotSurface( allVox );
    title( 'Object arrangement' );
end