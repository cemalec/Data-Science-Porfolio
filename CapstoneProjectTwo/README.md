# This is a project that segments mitochondria from publicly available SEM/FIB imaging data.

## The [Docs](https://github.com/cemalec/Data-Science-Porfolio/tree/master/Capstone%20ProjectTwo/Docs) folder leads to explanatory documents including a slidedeck while
## The [Code](https://github.com/cemalec/Data-Science-Porfolio/tree/master/Capstone%20ProjectTwo/Code) folder leads to annotated Jupyter notebooks containing the code used to build the models

Using Data from the the [Computer Vision Lab at EPFL](https://www.epfl.ch/labs/cvlab/), I built a convolutional neural net model to segment mitochondria from images of neuron cells. In other words, given a microscopy image, the algorithm determines which pixels represent mitochondria and which do not. Hyperparameters were tuned to improve model fit and data augmentation was used to improve the performance on unseen data. The model efficacy was evaluated using the Dice Coefficient, a measure of overlap between two binary images. 
