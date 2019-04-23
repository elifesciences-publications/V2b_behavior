% mod from Severi et al. 


function [TAIL,mm]=Tail_tracker3(segment_length,number_segments,movie,frameInterval,file,base_point,start_angle)
tic
%create movie object
movobj =  file; %VideoReader(vidpath);

%preallocate space
numFrames = size(movobj,3);    %frameInterval(2) - frameInterval(1) + 1;
TAIL=zeros(numFrames,number_segments + 1, 2);

mask = zeros([180 1]);

TAIL(:,1,1)=base_point(2);
TAIL(:,1,2)=base_point(1);

%Find tail points and calculate positions
h=waitbar(0,'calculating angles...');
init_start = start_angle;
mm = [];
frm_count = 1;
for k = 1:numFrames

        frm = movobj(:,:,k);

        frm(:) = 255-frm;       % 
        d = diff(frm,1,3);
        m = squeeze(max(max(d,[],1),[],2));
        mm = cat(1,mm,m);
    %end
    
    waitbar(k/numFrames,h);
    if exist('bgimage','var')
        x = double(frm(:,:));

    else
        x = frm(:,:);
    end
   
    for j=1:number_segments
        x_point = round(TAIL(k,j,2)+cosd((1:180)-90+start_angle)*segment_length); %x
        y_point = round(TAIL(k,j,1)+sind((1:180)-90+start_angle)*segment_length); %y
        for i=1:180
            mask(i) = x(y_point(i),x_point(i));

        end
        
        RC1=0;
        RC2=0;
         
        v_mean=mean(mask);
        v_std=std(mask);
        
        for q=1:length(mask)
            if mask(q)<(v_mean+v_std)
                mask2(q)=0;
            else
                mask2(q)=255-mask(q);
            end
            RC1=RC1+q*mask2(q);
            RC2=RC2+mask2(q);
        end
        
        if ~isnan((RC1/RC2))
            ang = round(RC1/RC2);
        end
        TAIL(k,j+1,2)=x_point(ang);
        TAIL(k,j+1,1)=y_point(ang);
        
        start_angle=start_angle + ang - 90;
    end
    start_angle  = init_start;
    
    % Movie reconstruction with tracked tail
    if movie==1
        imshow(x,[]);
        hold on
        scatter(TAIL(k,:,2),TAIL(k,:,1),3,'filled');
        text(5,5,num2str(k));
        pause(0.01);
        hold off
    end
end
close(h)
toc