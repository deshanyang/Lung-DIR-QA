# Lung-DIR Validation
Dataset of CT image pairs with landmarks for deformable image registration (DIR) algorithm verfication and quality assurance (QA).


<img src="https://github.com/deshanyang/Lung-DIR-QA/assets/50779449/8acd6473-4254-4268-86d0-c638ceb8c2e1" width="400">

<img src="https://github.com/deshanyang/Lung-DIR-QA/assets/50779449/d28fb553-15a3-4bd1-a9b4-a25062a3de87" width="350"> 



## Dataset Overview
This dataset contains 30 different cases of CT image pairs, with a high number of vessel bifurcation landmark pairs identified in each case. These landmarks can be used for DIR algorithm validation and quality assurance. Images are obtained from several publicly available image repositories as well as clinical scans from Barnes Jewish Hospital.

We hope to publish the results of this study in a dataset article. Due to the size of the image files, the full dataset is saved on our publicly available Zenodo repository at https://doi.org/10.5281/zenodo.8200423. However, one example image pair with landmarks is included within this Github repository, along with a tutorial in loading and processing this data, to assist researchers in getting started with the dataset. Please see the tutorial folder in this GitHub for more information.

## Landmark Identification
Landmarks were identified using a semi-automatic pathway visualized below
![image](https://github.com/deshanyang/Lung-DIR-QA/assets/50779449/222c7d0c-7854-4a12-b060-605a1a6eff05)


Denoising was done using FFDNet, a flexible deep learning based denoiser (Zhang et al, [2018]). Vascular tree segmentation is accomplished using the Frangi vesselness filter and thresholding methods (Frangi et al. [1998]), and automatic segmentation of the lungs and airways was done using the pulmonary toolkit (Doel et al.). Bifurcations are detected directly on the skeleton of the vessel tree. The approximate registration is done using PTVReg (Vishnevskiy et al., [2017]). Links to the sources listed are provided at the bottom of this document.



## Use of Dataset
### Dataset Organization
The full dataset, available on zenodo, is organized into two formats. The first is a folder containing 30 .mat files. In each of these files is the imaging data for both CT images in a pair, the landmark locations for each image, and the voxelsizes for each image. The imaging data in the .mat files is organized in the dimensions [coronal, sagittal, axial], with the order of the slices in accordance with DICOM formatting [anterior:posterior,right:left,inferior:superior]. Landmark locations are saved as 3 columns of pixel indices, with each column corresponding to the dimensions of the image, in the same order. Image intensity values are saved as Hounsfield units shifted by 1000.

The second format is a folder containing the imaging data in the NIfTI file format, with the landmarks stored in a text file. Each image and its landmarks are stored in its own file, and are labeled by each case. Imaging and landmark data dimensions are in the order [sagittal, coronal, axial], with slice order also in accordance with the DICOM coordinate system. Landmark locations are saved as 3 columns of pixel indices, with each column corresponding to the dimensions of the image, in the same order. Image intensity values are still Hounsfield units shifted by 1000.
### Visualizing Landmarks
For those interested in looking at the landmark pairs available in this dataset, we recommend the use of MatchGui (Deshan Yang, 2017). MatchGui is a Matlab based tool, and allows the user to load in both CT images as well as the landmark locations for each image. In this way, users can visualize each landmark pair invidually, with upsampling tools that can help inform the user if the dataset is right for their purposes. There are also functions allowing the user to flag certain landmarks and adjust them if they feel necessary.

![image](https://github.com/deshanyang/Lung-DIR-QA/assets/50779449/65ab5db5-247e-4def-8510-244f4862ff31)

A screenshot from the MatchGUI interface showing a landmark pair from the dataset.

For more extensive instructions on how to use matchgui, please refer to the tutorial folder in our Github.

### Citing
The results of this study are publicly available for use in DIR algorithm verification. If you used our work in any way, please cite our paper at .

If you have any further questions about the dataset, please reach out to us at teddy.criscuolo@duke.edu. Thank you!

## Sources
FFDNet- https://arxiv.org/abs/1710.04026

Pulmonary Toolkit (PTK)- https://github.com/tomdoel/pulmonarytoolkit

PTVReg - https://doi.org/10.1109/TMI.2016.2610583
