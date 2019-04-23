# V2b_behavior
Matlab code used in Callahan et. al. publication "Spinal V2b neurons reveal a role for ipsilateral inhibition in speed control" to track tail movements in head embedded animals. 

Image acquisition and data file structuring:

Images for our paper were recorded at 200 Hz with a HiSpec camera at increments of 2gb per recording using their autosave parameters. Each recording was saved as a folder containing .tif images (~ 3000). The data folders were placed in a folder named for the fish name and date (e.g. "181219_RC_fish1") and each individual recording folder was given a unique name starting with "Autosave0_.." and containing the time of recording. 

This Matlab code is written so that it will iteratively input sequential recordings saved in the way described above. 

all_together_imaging_allatonce2.m run in Matlab will be used to open your data, track the tail, and save the imaging output.  Make sure to change the specific filename so your analysis will be saved in a unique and identifiable location.

    filename = strcat('tester',fishname)

all_together_imaging_allatonce2.m will call a data browser where you should select the master folder containing all the recordings for one animal (e.g. "181219_RC_fish1"). 
You will be prompted to give the number of recordings and the total number of images to import (e.g. 1000 for 5 seconds of video).

    >> all_together_imaging_allatonce2();
    How many recordings to evaluate? 6
    How many images import ("all" or integer)? 1000
    
Each recording will be read and analyzed sequentially. 

Once the first recording is read into Matlab an interactive window will appear where the point of the rostral tail is first selected and then the caudalmost point. These locations will be used for the subsequent recordings using that animal. 

all_together_imaging_allatonce2 uses tail_tracking3.m, tail_tracking4.m and Tail_tracker3.m 

Once the tail has been tracked further analysis can be made with data_from_tail.m , swimquant.m , and tailbeat.m 
