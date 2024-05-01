# Data_Science_cw2

Coursework 2 of Data Science Module at Imperial College London

This project is part of the Data Science module at Imperial College London, MSc in Statistics programme. The project aims to produce a professional statistical analysis report. 

The project will work on the dataset concerning the CHURN of telecom customers from Iranian companies, available on the UCI website maintained by (Dua and Graff 2019). This project will focus on investigating:

- Exploratory Data Analysis of the dataset
- Regression Modelling by different regressor methods
- Compare model performance and further discussions


## Software and packages Used

All the code is written in **R**, and run in the Rstudio. The final statistical analysis report is created by .tex document using **LaTeX**, knitted by the online editing platform Overleaf. 

Notice that though running the source scripts and/or the .tex document by other software/platforms should give the same result, the output might be slightly affected if different software/platform is used. To ensure the best reproducibility please run all documents as the software/platforms stated above. 

### Pakages Used

R Packages used in this project include: `readr`, `sm`, `tidyr`, `dplyr`, `corrplot`,  `Stat2Data`, `plyr`, `gglasso`, `glmnet`, `caret`, `e1017`.

## Folder Structure

The code and analysis are structured as follows: 

### data 

- Sub-directory: raw, derived

This directory contains all raw and derived datasets used in this project. 

Raw data (unzipped to .csv file) can be found on [this website](https://archive.ics.uci.edu/dataset/563/iranian+churn+dataset). Time collected of raw data from the above website: April 2024. 


More information and background can be found in [this paper](https://scirp.org/reference/referencespapers?referenceid=2607575). 

### scr 

The scourse folder contains the definitions/scripts for the pre-defined functions used in the analysis. 

### analyses
- Sub-directory: data_processing, exploratory_data_analysis, modelling, evaluation

The analyses directory contains all code used to analyse the data and/or to produce the contents in the "outputs" folder, all scripts are stored in the corresponding named folder. 

### outputs

- Sub-directory: figures

Contains all figures output from the R code. 

### reports

This folder contains all documents to produce the final report to submit, it contains mainly the .tex documents which writes the report in LaTeX, and the reflective pieces in pdf. Notice the LaTeX document needs the output tables/figures from the "output" folder. 

## Author

Author: Grace Huang
Institution: Imperial College London, Mathematics department. 
Contact information: [grace.huang23@imperial.ac.uk](grace.huang23@imperial.ac.uk)


