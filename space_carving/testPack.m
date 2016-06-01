[container, size] = formInitialVoxels([0,100], [0,100], [0,100], 10000);
[object1, size1] = formInitialVoxels([20,40],[20,40],[20,40],10000);
[object2,size1] = formInitialVoxels([20,80],[20,50],[20,40],10000);
[object3,size1] = formInitialVoxels([20,40],[20,60],[20,40],10000);
[object4,size1] = formInitialVoxels([20,80],[0,90],[20,60],10000);
[object5,size1] = formInitialVoxels([20,40],[20,40],[20,40],10000);
objectRect1 = makeBoundingRect(object1);
objectRect2 = makeBoundingRect(object2);
objectRect3 = makeBoundingRect(object3);
objectRect4 = makeBoundingRect(object4);
objectRect5 = makeBoundingRect(object5);
objs = [objectRect1;objectRect2;objectRect3;objectRect4;objectRect5];
[values, order] = sort(objs(:,3), 'descend');
%sort in order of z value
objs = objs(order, :);
[locations, couldPack] = spacePacking(container, objs, size);
illustrate(locations, objs, container, 10000);

%obj = formInitialVoxels([20,30],[20,30],[20,30],10000);
%locations = packSingleObject(container,obj,size);
%illustrateSingle(locations, obj, container, 10000);
