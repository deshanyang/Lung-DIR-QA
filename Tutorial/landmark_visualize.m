function varagout=landmark_visualize()
%this function prepares data for visualization in matchgui. 
%It is for use only to for the data published by Criscuolo et al., it is not meant to be generalized for other registration applications
if isfile('example_img1.mat')==0 ||isfile('example_img2.mat')==0 ||isfile('example_landmarks.mat')==0
    error(['Please make sure the working directory is set to the folder containing the tutorial data. ' ...
        'To load any image pair from the dataset, please refer to the instructions on our GitHub'])
else
    load('example_img1.mat');
    load('example_img2.mat');
    load('example_landmarks.mat');
end


    
    num_landmarks=length(landmarks1);
    landmark_pairs= [(1:num_landmarks)' landmarks2 ones(num_landmarks,1) landmarks1 ones(num_landmarks,1) ones(num_landmarks,1)];
    matchgui(img2,img1,'landmarks',landmark_pairs,'windowcenter',400,'windowwidth',800);
end
