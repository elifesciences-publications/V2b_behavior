
%Mod from Kris Severi, this uses the tail point established for the first
%image sequence 
function [TAIL,imagetester] = tail_tracking4(file,base_point,tip_point)

number_segments = 10;
% define framerate
frate=200;
% read first frame to define fish orientation

frm = imcomplement(file(:,:,1)); 

frm = double(frm);
% calculate direction of the tail
tail_vect = [(tip_point(1) - base_point(1)) (base_point(2) - tip_point(2))];
tail_length = sqrt(tail_vect(1)^2 + tail_vect(2)^2);
% calculate segment length
segment_length = floor(tail_length./number_segments);
% calculate the starting angle relative to a fish that is oriented 
% anterior right, posterior left (using cross product of two vectors)
start_angle = acosd(dot(tail_vect, [1 0])./(tail_length));
c = cross([tail_vect 0],[1 0 0]);
start_angle = start_angle.*sign(c(3));
%run the tail tracking
nan = NaN;
[TAIL,mm] = Tail_tracker3(segment_length,number_segments,0,nan,file,base_point,start_angle);
 
 
imagetester = combine_plots(file,TAIL);
