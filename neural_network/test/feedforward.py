#!/usr/bin/python3

import numpy

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
    
    x = [1,1,1]
    
    neuralNetwork = FeedForward(w1, b1, w2, b2, 1)

    #in 1000 epochs 366th gives the smallest squared error
    for i in range(0, 366): 
        neuralNetwork.e = 0
        d1 = [0,0,1]
        o1 = [0]
        neuralNetwork.learn(d1,o1)
        d2 = [0,1,1]
        o2 = [0.3]
        neuralNetwork.learn(d2,o2)
        d3 = [1,0,1]
        o3 = [0.5]
        neuralNetwork.learn(d3,o3) 
        d4 = [1,1,1]
        o4 = [0.9]
        neuralNetwork.learn(d4,o4)
        d5 = [1,1,0]
        o5 = [0.7]
        neuralNetwork.learn(d5,o5)
        print(i)
        print(neuralNetwork.e)

    print(neuralNetwork.think([0,0,1]))
    print(neuralNetwork.think([0,1,1]))
    print(neuralNetwork.think([1,0,1]))
    print(neuralNetwork.think([1,1,1]))
    print(neuralNetwork.think([1,1,0]))
