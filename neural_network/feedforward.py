#!/usr/bin/python3

import numpy
import csv

def parse_csv(a_file_name):
    with open(a_file_name, "rU") as csv_file:
        content = csv.reader(csv_file, delimiter=",")

        inputs = []
        outputs = []

        for row in content:
            inputs.append([float(i) for i in row[0:3]])
            outputs.append([float(row[3])])

    return (inputs, outputs)

class FeedForward:
    """
    3 inputs 4 nodes in hidden layer and 1 output
    """
    def __init__(self, w1, b1, w2, b2, lr):
        self.w1 = w1
        self.b1 = b1
        self.w2 = w2
        self.b2 = b2
        self.lr = lr
        self.e  = 0

    def think(self, x):
        self.l1_output = self.feedForward(x, self.w1, self.b1)
        self.output    = self.feedForward(self.l1_output, self.w2, self.b2)
        return self.output

    def backPropagation(self, inputs, weights_matrix, biases, e, z):
        input_length  = len(weights_matrix)
        output_length = len(weights_matrix[0])
        x = inputs

        for o in range(0, output_length): # calculate each output in order
            sigm_dev = z[o]*(1-z[o])
            for i in range(0, input_length): # take ith weights from every input node
                weights_matrix[i][o] += self.lr * e * sigm_dev * x[i]
            
            biases[o] += self.lr * e * sigm_dev * 1
        

    def learn(self, x, y_desired):
        y = self.think(x)
        e = 2*(y_desired-y[0]);

        self.backPropagation(self.l1_output, self.w2, self.b2, e, self.output)
        self.backPropagation(x, self.w1, self.b1, e, self.l1_output)
       
        self.e += pow(0.5*e, 2)
    def feedForward(self, inputs, weights_matrix, biases):
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

        for o in range(0, output_length): # calculate each output in order
            y.append(0);
            for i in range(0, input_length): # take ith weights from every input node
                y[o] += weights_matrix[i][o]*x[i]
            
            y[o] = self.activationFunction(y[o] + biases[o])

        return y

    def activationFunction(self, x):
        return 1 / (1 + numpy.exp(-x))
    
    def lossFunction(self, y_desired, y):
        return (y_desired - y)^2

    def dLossFunctionWb(self, e, x):
        return 2*e * (numpy.exp(-x) / pow((1+numpy.exp(-x)),2))

if __name__ == "__main__":

    w1 = [[1,1,1,1], [1,1,1,1], [1,1,1,1]] # 3 inputs 4 outputs
    b1 = [1,1,1,1]

    w2 = [[1], [1], [1], [1]] # 1 output from 4 sources
    b2 = [1]
    
    neuralNetwork = FeedForward(w1, b1, w2, b2, 1)
    
    # training
    data = parse_csv("./dataset/ID08/6026_6040.csv")
    x = data[0]
    y = data[1]
    data_num = len(data[0])
    
    for i in range(0, 100): 
        neuralNetwork.e = 0
        
        for j in range(0, data_num):
            neuralNetwork.learn(x[j], y[j])
        
        print(i)
        print(neuralNetwork.e)

    # testing
    print(neuralNetwork.think([0.781918471785434,0.82502750133407,0.833782303751735])) #ictal
    print(neuralNetwork.think([0.754916643917382,0.79069464087982,0.856130785716045])) #interactal
