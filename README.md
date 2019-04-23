# V2b_behavior
Code used in Callahan et. al. publication "Spinal V2b neurons reveal a role for ipsilateral inhibition in speed control"

Our Image acquisition and data file structuring
Images for our paper were recorded at 200 Hz with a HiSpec camera at increments of 2gb per recording using their autosave parameters. Each recording was saved as a folder containing .tif images (~ 3000). The data folders were placed in a folder named for the fish name and date (e.g. "111119_RC_fish1") and each individual recording folder was given a unique name starting with "Autosave0_.." and containing the time of recording. 

This Matlab code is written so that it will iteratively input sequential recordings saved in the way described above. 

alltogether
