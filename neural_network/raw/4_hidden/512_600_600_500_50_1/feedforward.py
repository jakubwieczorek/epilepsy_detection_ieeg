#!/usr/bin/python3

import math
from random import random
import numpy as np
import csv

def parse_csv(a_file_name, rows_number, output=True):
    with open(a_file_name, "rU") as csv_file:
        content = csv.reader(csv_file, delimiter=",")

        inputs = []
        outputs = []

        for row in content:
            inputs.append([float(i) for i in row[0:rows_number]])

            if output:
                outputs.append(float(row[rows_number]))
    if output:
        return (inputs, outputs) # outputs are just one array!
    else:
        return (inputs)

class FeedForward:
    def __init__(self, w1, b1, w2, b2, w3, b3, w4, b4, w5, b5):
        self.w1 = w1
        self.b1 = b1
        self.w2 = w2
        self.b2 = b2
        self.w3 = w3
        self.b3 = b3
        self.w4 = w4
        self.b4 = b4
        self.w5 = w5
        self.b5 = b5

    @classmethod
    def load(cls, path):
        w1 = np.loadtxt(path + '/w1.txt', dtype=float).tolist()
        b1 = np.loadtxt(path + '/b1.txt', dtype=float).tolist()
        w2 = np.loadtxt(path + '/w2.txt', dtype=float).tolist()
        b2 = np.loadtxt(path + '/b2.txt', dtype=float).tolist()
        w3 = np.loadtxt(path + '/w3.txt', dtype=float).tolist()
        b3 = np.loadtxt(path + '/b3.txt', dtype=float).tolist()
        w4 = np.loadtxt(path + '/w4.txt', dtype=float).tolist()
        b4 = np.loadtxt(path + '/b4.txt', dtype=float).tolist()
        w5 = np.loadtxt(path + '/w5.txt', dtype=float).tolist()
        b5 = np.loadtxt(path + '/b5.txt', dtype=float).tolist()

        if not isinstance(w5[0], list): # if only one output, then wrap it into an array
                                        # so [1,2,3] -> [[1],[2],[3]]            
            w5 = [[w5[i]] for i in range(len(w5))]

        if not isinstance(b5, list): # if only one output, then wrap it into an array
            b5 = [b5]
        
        return cls(w1, b1, w2, b2, w3, b3, w4, b4, w5, b5)

    def feedForward(self, inputs, weights_matrix, biases, activationFunction):
        """
        weights_matrix should be [i][o]
            o
        i
            o
        i
            o
        i
            o
        biases should be [o_length]
        inputs should be [i_length]
        """
        input_length  = len(weights_matrix)
        output_length = len(weights_matrix[0])
        x = inputs
        y = []
        z = [] # without activation

        for o in range(0, output_length): # calculate each output in order
            y.append(0);
            z.append(0);
            for i in range(0, input_length): # take ith weights from every input node
                y[o] += weights_matrix[i][o]*x[i]
             
            z[o] = y[o] + biases[o]
            y[o] = activationFunction(z[o])

        return y, z

    def think(self, x):
        (self.l1_output, self.l1_z)  = self.feedForward(x, self.w1, self.b1, self.ReLU)
        (self.l2_output, self.l2_z)  = self.feedForward(self.l1_output, self.w2, self.b2, self.ReLU)
        (self.l3_output, self.l3_z)  = self.feedForward(self.l2_output, self.w3, self.b3, self.ReLU)
        (self.l4_output, self.l4_z)  = self.feedForward(self.l3_output, self.w4, self.b4, self.ReLU)
        (self.output, self.output_z) = self.feedForward(self.l4_output, self.w5, self.b5, self.sigmoid)
        return self.output
    
    def sigmoid(self, x):
        if x < -710: # to prevent overflow in math.exp
            return 0
        return 1 / (1 + math.exp(-x))
    
    def dSigmoid(self, sigm):
        return sigm*(1-sigm)

    def ReLU(self, x): # it is actually LeakyReLU to tuckle with dying gradient
        #return max(0.1*x, x)
        return max(0, x)

    def dReLU(self, x):
        #return 0.1 if x<0 else 1
        return 0 if x<0 else 1

if __name__ == "__main__":
    
    nn2 = FeedForward.load('./model')
    
    data = parse_csv("../../dataset/ID02/train_data.csv", 512)

    test_images = data[0]
    test_labels = data[1] 
    
    print('predicted: ' + str(nn2.think(test_images[0])))
    print('expected:  ' + str(test_labels[0]))
    print('predicted: ' + str(nn2.think(test_images[15])))
    print('expected:  ' + str(test_labels[15]))

    print('predicted: ' + str(nn2.think(test_images[227])))
    print('expected:  ' + str(test_labels[227]))

    predicted = []
    images_num = len(test_images)
    for image in test_images:
        predicted.append(nn2.think(image)[0])

    #print(predicted)
    
    with open("result.csv", "w") as f:
        writer = csv.writer(f)
        writer.writerows(zip(predicted, test_labels))
