#!/usr/bin/python3

import math
from random import random
import numpy as np

class FeedForward:
    def __init__(self, w1, b1, w2, b2, lr):
        self.w1 = w1
        self.b1 = b1
        self.w2 = w2
        self.b2 = b2
        self.lr = lr
        self.e  = 0
        
        #print(self.w1)
        #print(self.w2)
        #print(self.b1)
        #print(self.b2)

    @classmethod
    def load(cls, path):
        w1 = np.loadtxt(path + '/w1.txt', dtype=float).tolist()
        b1 = np.loadtxt(path + '/b1.txt', dtype=float).tolist()
        w2 = np.loadtxt(path + '/w2.txt', dtype=float).tolist()
        b2 = np.loadtxt(path + '/b2.txt', dtype=float).tolist()

        if not isinstance(w2[0], list): # if only one output, then wrap it into an array
                                        # so [1,2,3] -> [[1],[2],[3]]            
            w2 = [[w2[i]] for i in range(len(w2))]

        if not isinstance(b2, list): # if only one output, then wrap it into an array
            b2 = [b2]
        
        return cls(w1, b1, w2, b2, 1)

    @classmethod # second constructor
    def init(cls, inputs_number, nodes_number1, outputs_number, lr):
        init_value = 0
        """this is very important to not assign the same value to the initial weights
           because simply nn is not working properly. For example here was a problem that
           if all weights were the same for example 0.5, then for these inputs and desired 
           outputs
           d1 = [0,0,1]
           d2 = [0,1,1]
           d3 = [1,0,1]
           d4 = [1,1,1]

           o1 = [0]
           o2 = [1] # strongly connected if this is 1
           o3 = [1] # strongly connected this is 0 and vice versa
           o4 = [0]
          either o2 or o3 had to be 0 otherwise output was sth like [0.2][0.6][0.6][0.6]
          https://medium.com/usf-msds/deep-learning-best-practices-1-weight-initialization-14e5c0295b94
          here he says that if all weights are the same, then nn is linear

        """
        w1 = [[random() for o in range(nodes_number1)] for i in range(inputs_number)]
        b1 = [random() for o in range(nodes_number1)]

        w2 = [[random() for o in range(outputs_number)] for i in range(nodes_number1)]
        b2 = [random() for o in range(outputs_number)]
        
        return cls(w1, b1, w2, b2, lr)
    
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

        for o in range(0, output_length):
            y[o] = activationFunction(z[o])

        return y, z

    def think(self, x):
        (self.l1_output, self.l1_z)  = self.feedForward(x, self.w1, self.b1, self.ReLU)
        (self.output, self.output_z) = self.feedForward(self.l1_output, self.w2, self.b2, self.sigmoid)
        return self.output
    
    def update(self, w, b, dedw, dedb):
        outputs_length = len(w[0])
        inputs_length = len(w)
        
        for o in range(0, outputs_length):
            for i in range(0, inputs_length):
                w[i][o] += dedw[i][o] * self.lr
            
            b[o] += dedb[o] * self.lr

    def gradientsOutput(self, inputs, dedo, w, dActivationFunction, acti_arg1):
        """
        for the last layer.
        inputs are the outputs of the last hidden layer
        dedo is an error gradient with respect to the output, is an array
        w are weights between output and the last hidden layer, are constant
        if dActivationFunction is dSigmoid then acti_arg1 --> outputs array
        """
        outputs_length = len(w[0])
        inputs_length = len(w)

        dedw = [[0 for o in range(outputs_length)] for i in range(inputs_length)]
        dedb = [0 for o in range(outputs_length)]
        for o in range(0, outputs_length): 
            for i in range(0, inputs_length):
                dedw[i][o] = dedo[o] * dActivationFunction(acti_arg1[o]) * inputs[i]
            
            dedb[o] = dedo[o] * dActivationFunction(acti_arg1[o]) * 1
        return dedw, dedb
    
    def gradients(self, inputs, dedo, w, w2, dActivationFunction, acti_arg1, dActivationFunction_2, acti_arg1_2):
        """ w is an array of weights between inputs and hidden layer
            w2 same but between outputs of hidden layer and outputs of nn
        
            sum(w2)
        """
        outputs_length = len(w[0]) # of w!
        inputs_length = len(w)

        dedw = [[0 for o in range(outputs_length)] for i in range(inputs_length)]
        dedb = [0 for o in range(outputs_length)]
        
        dedohw = [[0 for o in range(outputs_length)] for i in range(inputs_length)]
        dedohb = [0 for o in range(outputs_length)]
        
        outputs_length2 = len(w2[0])
        inputs_length2 = len(w2)
        
        """ for only dw[0][0] 
            influence of hidden node output (hno[0]) [0] for every output error
            so de with respect to the hidden
            he takes hno[0] and computes derror of hno[0]->derror[zeroth output]
            then hno[0]->derror[first output] and so on

            then still for hno[0] he takes next input so dw[1][0] and checks influence of dw[1][0]
            for errors, so he takes hno[0] -> derror[zeroth output], hno[0]->derror[first output], so
            for all dedohw[0][0] == dedohw[1][0] == ..., it is clearly visible on nn picture of 1 hl
        """
        for o2 in range(0, outputs_length2): # for dw[0][0] only zeroth hidden node, so every w2[0][o2]
            dEdActiv = dedo[o2] * dActivationFunction_2(acti_arg1_2[o2])
            for o in range(0, outputs_length):
                dedoh = dEdActiv * w2[o][o2]
                for i in range(0, inputs_length):
                    dedohw[i][o] += dedoh
                
                dedohb[o] += dedoh

        for o in range(0, outputs_length):
            dActiv = dActivationFunction(acti_arg1[o])
            for i in range(0, inputs_length):
                dedw[i][o] = dedohw[i][o] * dActiv * inputs[i]
            
            dedb[o] = dedohb[o] * dActiv * 1
        
        #print(dedw)
        #print(dedb)

        return dedw, dedb
    
    def learn(self, x, y_desired):
        y = self.think(x)
        dedo = self.dSqe(y, y_desired)

        (dedw2, dedb2) = self.gradientsOutput(self.l1_output, dedo, self.w2, self.dSigmoid, self.output)
        (dedw1, dedb1) = self.gradients(x, dedo, self.w1, self.w2, self.dReLU, self.l1_z, self.dSigmoid, self.output)
        
        self.update(self.w2, self.b2, dedw2, dedb2)
        self.update(self.w1, self.b1, dedw1, dedb1)

        self.e += self.sqe(y, y_desired) # only for printing, derivative is important
    
    def sqe(self, y, y_desired):
        error = 0
        numel = len(y)
        
        for i in range(0, numel):
             error += pow(y[i]-y_desired[i], 2) 
        
        return error

    def dSqe(self, y, y_desired):
        error = []
        numel = len(y)
        
        for i in range(0, numel):
             error.append(y_desired[i]-y[i])
        
        return error

    def sigmoid(self, x):
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
    
    neuralNetwork = FeedForward.init(3, 4, 1, 1)

    for i in range(0, 1500):
        neuralNetwork.e = 0
        d1 = [0,0,1]
        d2 = [0,1,1]
        d3 = [1,0,0]
        d4 = [1,1,1]

        o1 = [0]
        o2 = [1]
        o3 = [1]
        o4 = [0]
        
        neuralNetwork.learn(d1,o1)
        neuralNetwork.learn(d2,o2)
        neuralNetwork.learn(d3,o3)
        neuralNetwork.learn(d4,o4)
        print(i)
        print("error ", neuralNetwork.e)

    print(neuralNetwork.think([0,0,1]))
    print(neuralNetwork.think([0,1,1]))
    print(neuralNetwork.think([1,0,0]))
    print(neuralNetwork.think([1,1,1]))
    print('\n')

    nn2 = FeedForward.load('./model')

    print(nn2.think([0,0,1]))
    print(nn2.think([0,1,1]))
    print(nn2.think([1,0,0]))
    print(nn2.think([1,1,1]))
