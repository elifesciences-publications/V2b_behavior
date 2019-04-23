% This function calculates the average tail beat frequency (TBF) from the Y data of the furthest tail point. 
% E.g. > tailbeat(m.allTAIL(:,11,1,1)). To accurately calculate a TBF select sequential max and min values with the cursor. 


function tailbeat(file)
%choose at least three points to determine frequency 
h = figure;
plot(file);
[x,y] = ginput();
close(h)
diffs = zeros(size(x)-1);
for k=2:size(x)
    diffs(k) = x(k) - x(k-1);
end
avedif = mean(diffs);
interval = avedif*2; % in frame number
time = interval*0.005;
invtime = 1/time

maxy = max(y);
miny = min(y);
diff= maxy-miny;
