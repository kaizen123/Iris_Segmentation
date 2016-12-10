function [rutas] = direcciones(pc_name, folder_name)
dir1 = 'C:\Users\';
dir2 = '\Desktop\';
start_path = fullfile(dir1,pc_name,dir2,folder_name,'\RGB Images');
topLevelFolder = start_path;

if topLevelFolder == 0
	return;
end

% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end

numberOfFolders = length(listOfFolderNames);
rutas = {};

for i=2:numberOfFolders
    sujeto = strjoin(listOfFolderNames(i));
    a = genpath(sujeto);
    largo = length(a);
    imagenes = a(1:largo-1);
    c = dir(imagenes);
    n_images = length(c);
    for k=3:n_images
        name = c(k).name;
        if (~strcmp(name,'Thumbs.db'))
            name = strcat('\',name);
            direccion = strcat(sujeto,name);
            rutas = [rutas direccion];
        end
    end
end

end

