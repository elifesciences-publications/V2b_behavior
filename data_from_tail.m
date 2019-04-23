
function [allspeed, swimtot,taildis] = data_from_tail(tottail)
% This function uses the tracked tail location endpoint and calculates the
% instantaneous tail speed, amount of time tail was moving during
% recording, and the total tail displacement 

recs = size(tottail,4);
frameT = 1/200;  % 200 Hz recording

% This is the analysis section of the code, which will calculate:
    % 1) the tail speed in cm/s
    % 2) the swimminess, number of bouts/ total time
    % 3) the max tail displacement 
    % 4) the TBF of the tail 
taildis = zeros(recs,1);
    for r= 1:recs
        tail = tottail(:,:,:,r);
        %fit_tail = tailanalysis(tail);  % spline fit
        %if tail(1,1,2) < tail(1,11,2)   % determine which side is the end of the tail
        num = size(tail,2);
        %elseif tail(1,11,2) < tail(1,1,2)
           %num = 1;
        %end
        manypnts = tail(:,num,1);   % y axis plot of tail movement
        
        % 1) tail speed
        speed = zeros(size(tail,1)-1,1);
        for w = 1:(size(tail,1)-1)
            delta = abs(manypnts(w+1) - manypnts(w));
            delta = delta * 2*14/4;     % 14x14 microns is the pixel, 4 is obj mag and 2 is bc pixel downsampling
            delta = delta/10000;        % micron to cm conversion
            speed(w) = delta/frameT;
        end
        index = 0;
        % 2 swimminess
        swimminess = zeros(size(speed,1),1);
        for k = 1:size(speed)
            check = speed(k);
            if check > 0.5
                swimminess(k) = check;
                index = index+1;
            else
                swimminess(k) = NaN;
            end
        end
        
        % 3) the max tail displacement
        
        taildis(r) = abs(max(manypnts) - min(manypnts));
        taildis(r) = taildis(r) * 2*14/4/1000; % converts tail displacement into mm value

        swimtot(:,r) = swimminess;
        allspeed(:,r) = speed;
    end
        
