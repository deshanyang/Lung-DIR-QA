# Dataset Tutorial
To help researchers introduce get started with the dataset, we included this tutorial to help with loading data into and using MatchGui. For more specific questions, please message us or email at deshan.yang@duke.edu.

## Matchgui installation
The source code for MatchGui is located in the matchgui folder of this Github repository. Download the folder to a desired location, unzip and add it to the Matlab path either by using the command addpath(foldername) or by going to Home->Set Path-> Add Folder. MatchGui should be compatible with Matlab R2022a, provided other dependencies are met. It is currently not stable on Matlab2019a or Matlab2017a.

If you would like to easily follow along with this tutorial, download the "example_img1.mat", "example_img2.mat", "landmark_visualize.m" and "example_landmarks.mat" to the same local folder in your system. Due to file size limitations on github, the images are saved individually and separately from the landmarks, unlike the .mat files from the full zenodo dataset. They must therefore be loaded individually into Matlab, but once in the workspace the workflow should function the same as it would for any of the full sized .mat files. 

## Load in Images
### Using Tutorial Image
For this tutorial, it is easiest to load in the image and landmarks using the function provided, called "landmark_visualze". For more general instructions on using MatchGui with any images in the dataset, refer to the next section. To use the function provided, make sure the Matlab working directory is set to the folder containing the image data and the function. To do this, type the command cd(path/to/folder) into the command window within Matlab. Then, type landmark_visualize() into the command line. It may take some time to load the data and display the images. If utilizing the tutorial image and this approach, skip the following section.

### Using any Image in the Dataset
Beyond this tutorial, to load in any of the images from the dataset into Matchgui, make sure you download the desired images or the full dataset from zenodo. Then, set the folder containing the .mat data to the current working directory in Matlab (cd path/to/folder). Load in the desired .mat case file by either calling (load(filename)) or dragging and dropping the file into your workspace. Once the data is loaded into Matlab, MatchGui accepts images and landmarks in the command line by the following structure: matchgui(img1,img2,'landmarks',landmark_pairs). The landmark_pairs argument should be structured as

landmark_pairs= [(1:num_landmarks)' landmarks1 ones(num_landmarks,1) landmarks2 ones(num_landmarks,1) ones(num_landmarks,1)];
where num_landmarks=length(landmarks1);

The order of the landmarks (landmarks1 vs landmarks2) from left to right in this argument should be the same as the order of the images in the call of matchgui. If the order is switched, the landmarks will occur on the wrong image. This likely will be visually apparent, and the adjustment can be made by calling the matchgui function again with the order of the images flipped (or flip the landmark pair order).

If the user desires, they can include a number of other arguments in their initial call of MatchGui, including 'windowcenter' and 'windowwidth', to help in the display of the images. These parameters can also be adjusted in the MatchGui inteface. For more parameters, please see the miscellaneous instructions below.  

---

If the images and landmarks were loaded properly, you should see an interface like such

![image](https://github.com/deshanyang/Lung-DIR-QA/assets/50779449/4b20f7e2-ea91-4084-ac7c-f979179fc69b)



**NOTE**: Due to the way images are loaded into MatchGui, they must be the same size, otherwise they will not properly display. To account for this, images with different dimensions that are loaded into MatchGui are resized automatically by adding the respective number of slices to each dimension needed. These slices are simply repeats of the maximum value of the image, so won't show up unless the window level is significantly altered. This should not affect the presentation of the landmarks, but is worth noting. This is a feature that may be updated in future versions. 



## Looking at landmarks
In this display, you should see each landmark pair both on CT1 and CT2. The order of the images from left to right will be in the same order as they were called by the user (you can double check the order by looking at the top left of the window, it should say the order next to ViewMatch3d). In the tutorial example, image2 is on the left, and image1 is on the right. Landmarks were detected on image2 and projected onto image1. This is not the case for all of the scans in the dataset, please reference the dataset paper or the excel file in the zenodo dataset for more information on this. In most cases, the user will likely need to use the zoom factor slider to view the landmark pair accurately. In addition, many of the landmark pairs occur on vessel anatomy that is too small to be clearly identified without the upsampling feature in MatchGui. If the user desires, they can turn this on and off using the checkbox on the right side of the interface.

The user can toggle which landmark they are looking at by using the slider at the top right, or by left clicking on one of the display windows and hitting the right and left arrow keys. The order of the landmarks is randomized, so there is no physical association with a landmark occurring earlier or later. Play around with the zoom factor and landmark sliders to visualize some of the landmark pairs in the dataset. One can also try adjusting the window level settings by using the text box inputs or by right clicking on any of the images and selecting "Window Levels"-> and desired organ.



<img src="https://github.com/deshanyang/Lung-DIR-QA/assets/50779449/a268ea2c-c353-4d00-8894-26582c411222" width="400"> <img src="ttps://github.com/deshanyang/Lung-DIR-QA/assets/50779449/50e52312-f802-4093-8902-589ead58e772" width="400"> 

**LEFT: A landmark in this case with good window level settings and upsampling. RIGHT: The same landmark without upsampling and different window level settings.**

Some of the landmarks may not appear to occur on bifurcations at first glance. To get a better picture of what vessel anatomy looks like at a particular point, we recommend looking at the slices around a particular point. To do this, keep the landmark slider at the same landmark, and hover the mouse over the desired view window. The user can then change the slice by using the scroll wheel on their mouse. An alternative is to left click on the desired window and use the up and down arrow keys to toggle the slice. Doing this should provide more context for where the bifurcation is occurring.

The user can also toggle the "Vector" checkbox to visualize where the each landmark in a pair occurs relative to the other image. This can give the user some perspective on the amount of deformation at each landmark. The position of and distance between the two landmarks is also displayed in the upper right as "Distance".
![image](https://github.com/deshanyang/Lung-DIR-QA/assets/50779449/7567d545-08c4-447e-b5e0-4374d38973fa)


**What the vectors look like for the landmarks showing displacement. The vector in red is the currently selected landmark, while those in green are other landmarks happening to occur on the same slice (these can be toggled through the use of the "Other Features" checkbox). The endpoint of the arrow is where the landmark occurs in the other image.**


**NOTE 1**: If one uses MatchGui for an extended period of time, or cycles through landmarks too rapidly, the interface can slow down significantly. Closing and restarting the program should remedy this, as well as taking time before moving to the next landmark.

**NOTE 2:** Some landmarks may seem like they are slightly misaligned with the true "center" of a vessel bifurcation. To highlight why this occurs, toggle the upsampling to get a clearer picture of the true voxelsize of the image. MatchGui uses interpolation to place landmark points at non-integer pixelvalues. However, during the landmark detection pathway, the landmarks were rounded to the nearest integer voxel. As such, their position may not align perfectly with the center of the bifurcation. This same rounding was not performed on the projected bifurcation, however, and as such there should be no accuracy lost in the correspondance between the two. This correspondance is the important parameter for registration verification. However, future versions of the dataset may resolve this issue.

### Flagging landmarks or manual adjustments
If a user wants to flag a landmark pair as being inaccurate, they can uncheck the checkbox "This is a good match", or by hitting the "t" button on your keyboard. This info can be saved for a future session by right clicking on any image and hitting "save manual confirmation flags". The "Match Quality" textbox in the top right of the interface is currently not functional, but future versions of MatchGui may allow users can assign an arbitrary quality value to organize the landmarks according to their own needs.

One can also apply their own manual adjustments to a particular landmark using the MatchGui software. To do so, make sure you currently have the desired landmark selected (the number on the slider). Click on one of the slice views in the exact desired location of the new position of the landmark, and hit "a" on the keyboard. The manual landmark should appear in cyan. To toggle between the original position and the new manually placed position, hit the "G" key. If the manual correction was placed in the wrong spot, either hit the "d" key or right click on any image window and select "Delete the Manual Position"

The flagging and manual adjustment can be done for any number of landmarks in each MatchGui session. Once the desired landmarks are adjusted, right click on any image and click "save manual confirmation flags". These can be loaded for a later session by right clicking and using the menu item "load manual confirmation flags".

## Miscellaneous MatchGui Instructions
There are some features included in the MatchGui program that are not a part of this tutorial either because they are incomplete or likely not useful for this specific dataset. This tutorial is included just so researchers can get started with the data, and is not meant to be a comprehensive guide on MatchGui. However, if there are any questions, please reach out to us at deshan.yang@duke.edu. 

### Matchgui Keyboard shortcuts

-	T = to toggle the flag “This is a good match”
-	F = to automatically re-assign the current feature position
-	Shift-d or “D”= to delete the re-assign the positions of the current feature pair (cannot be undone for now. A undo feature is not available.)
-	1, 2, 3 = the set the feature size scale for automatic position re-assigning
-	A = the manual re-assign the feature positions at the position of the last mouse click for the image which was clicked the last.
-	Left/right = to go to the previous / next feature pair
-	Shift-left/right = to jump to the previous / next feature pair in a step of 10
-	Shift-ctrl-left/right = to jump to the previous / next feature pair in a step of 100
-	Up/down = to go to the previous/next slice on the view which was mouse clicked the last
-	Shift-up/down = to go to the previous/next slice on the view on both images together
-	G = toggle between the original and the re-assigned positions
-	U = toggle up-sampling

