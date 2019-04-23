% Data on average speed for light stim versus no light
% type is a 1D vector listing the stim status light =1 no light  = 0 
% averagespeed is calculated from the tail speed calculated in 
% data_from_tail.m, swimpersec reports the amount of time the tail was movin over 1 mm/s  

function [averagespeed,swimpersec, controlspeed, controlswim, stimspeed,stimswim] = swimquant(speed,type) % can also put in type file
    leng = size(speed,1);
    time = (0:0.005:((leng-1)/200))';
    num = size(speed,2);
    averagespeed = zeros(num,1);
    swimpersec = zeros(num,1);
    swimminess = zeros(size(speed,1),num);
    indy = 1;
    windex = 1;
    for j=1:num       % calculates points in the speed vs time vector where speed > 1 cm/s
        index= 1;
        tempsp = speed(:,j);
        numpnts = size(tempsp,1);
        for k = 1:numpnts
            check = tempsp(k);
            if check > 1
                swimminess(k,j) = check;
                index = index+1;
            else
                swimminess(k,j) = NaN; 
            end    
        end
        averagespeed(j) = nanmean(swimminess(:,j),1);
        swimpersec(j) = index/time(end);           %these arent swim bouts, its tail movements...
        if type(j)==0
            controlspeed(indy) = nanmean(swimminess(:,j),1);
            controlswim(indy) = 100*index/numpnts; 
            indy = indy + 1;
        elseif type(j)==1
            stimspeed(windex) = nanmean(swimminess(:,j),1);
            stimswim(windex) = 100*index/numpnts; 
            windex = windex + 1;
        end

    end
        controlspeed = (controlspeed)';
        stimspeed = stimspeed';
        controlswim = controlswim';
        stimswim = stimswim' ;
        %plot_stimvcont(controlspeed, controlswim, stimspeed,stimswim,type);
   
   
   


