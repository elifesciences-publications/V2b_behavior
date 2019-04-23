%  This code uploades videos saved as .tif files. 
% 1) chose recording/folder
% 2) import files for a recording and save with trial number
% 3) process image
% 4) save xy, speed, and binary image (200 frame)

function [allTAIL,partMovie]=all_together_imaging_allatonce2()  % 
    d = uigetdir(pwd, 'Select a folder');
    value = input('How many recordings to evaluate?');
    counter = input('How many images import ("all" or integer)?');
    f_fold = dir(fullfile(d, 'Autosave*'));
    numberOfRecs = value;
    h = waitbar(0,'Please wait...');
    % get name from selected folder
    nameoffolder = f_fold(1).folder;
    star = strfind(nameoffolder, 'fish');
    fishname = nameoffolder(star:end);
    for j=1:numberOfRecs  
        j
        fpath=strcat((f_fold(j).folder),"/",(f_fold(j).name),"/");
        fnamechar = char(fpath);
        f_tif = dir(fullfile(fnamechar, '*.tif'));
        last_name = f_tif(end).name;
        if counter == 'all'
            val_last = char(last_name((end-8:end-4)));
            numberOfImages = str2num(val_last)+1;
        else
            numberOfImages = counter;
        end
        numbtot = numberOfImages;
        index = 1;
        for jj=1:numbtot  
            fname = strcat((f_tif(jj).folder),"/",(f_tif(jj).name));
            fnamechar = char(fname);
            dottest= char(f_tif(jj).name);
          
            if dottest(1)~= '.'
                currentImage = imread(fnamechar);
                b = imresize(currentImage, 0.5); % this is to downsample points and decrease the overall image size, may be able to further downsample
                if j==1&&index==1
                    imageStack = zeros(size(b,1),size(b,2),numberOfImages,'uint8');
                    allTAIL = zeros(numberOfImages,11,2,numberOfRecs);
                end
                imageStack(:,:,index) = b(:,:);
                index=index+1;
            end
        end
        if j == 1
            [TAIL,imagetester,base_point,tip_point] = tail_tracking3(imageStack);
        else
            [TAIL,imagetester] = tail_tracking4(imageStack,base_point,tip_point);
        end

        if j == 1
            im_test = struct('vid',{imagetester},'dummy',{0});
        else
            im_test(j) = struct('vid',{imagetester},'dummy',{0});
        end
        allTAIL(:,:,1:2,j) = TAIL(:,:,1:2);

        waitbar(j/numberOfRecs,h);

    end
    filename = strcat('tester',fishname) % replace tester with an identifying name eg. genotype and date
    save(filename, '-v7.3');
    





