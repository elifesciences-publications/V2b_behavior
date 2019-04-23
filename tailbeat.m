function tailbeat(file)
%choose points three points to average 
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
