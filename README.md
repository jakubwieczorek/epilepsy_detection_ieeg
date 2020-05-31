# Epilepsy detection basing on deep feed forward neural networks and iEEG signals

## About 
The main point of the project is to create detection system for epileptic drug resistant cases, basing on the machine learning and intracranial electroencephalography signals. Consecutive research will be taking advantage of the detection, thereby preventing the epilepsy by brain stimulation, hence significantly improving people's life.

## Introduction
Project consists of several parts were the main one is a deep feed forward neural network written in pure Python 3, with the help of Tensorflow 2.2 in the backpropagation process. The idea is to prepare data in MATLAB, consume them by deep feedforward network in Tensorflow, perform training, save model along with weights and biases in csv format, load weights and biases by feedforward network of the same topology written in pure Python, perform prediction process and check the results in MATLAB by ploting the actual prediction with a target prediction. The reason to use pure Python without even numpy library for a prediction process is the fact that in the future improvement feedforward neural network will be rewritten to vhdl, synthesized and placed in the chip, which will perform the prediction and prevention in the real time.

## Dataset
Dataset used in this paper consists of 2656 hours of iEEG records gathered from 18 anonymous patients with pharmacoresistant epilepsy at Sleep-Wake-Epilepsy-Center (SWEC) of the
University Department of Neurology at the Inselspital in Bern. Each recording was performed
by dozen of electrodes, resulting in 116 seizures detection by qualified neurological experts. Pure
iEEG was digitised, filtered and written in the MATLAB format with frequency of 512 or 1024Hz. Dataset can be found on 
http://ieeg-swez.ethz.ch/

## Table of contents
Epilepsy detection system consists of the following parts:

| **Neural Network**     | **MATLAB pre and postprocessing**     | **Documentation**  |
|-------------------------------------|-------------------------------|-----------------------------------|
|Deep Feed Forward neural network under neural_network subfolder, with many test of several network variants, which varies on layers amount from 2 to 4 and nodes number in the particular layers| MATLAB scripts producing .csv files for testing and training purposes, basing on raw data, local binary patterns and FIR filter. Postprocessing neural network prediction |Documentation under doc subfolder in Latex|

## Requirements
1.  Tensorflow 2.2
2.  Python3.6.9

## Questions or need help?
Don't hesitate to send me an email on jakub.wieczorek0101@gmail.com

## Copyright and license
Epilepsy detection project is copyright to EPFL and Jakub Wieczorek under the [MIT License](https://opensource.org/licenses/MIT).
