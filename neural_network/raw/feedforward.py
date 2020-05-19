#!/usr/bin/python3

import math
import csv
import numpy

def parse_csv(a_file_name, rows_number, output=True):
    with open(a_file_name, "rU") as csv_file:
        content = csv.reader(csv_file, delimiter=",")

        inputs = []
        outputs = []

        for row in content:
            inputs.append([float(i) for i in row[0:rows_number]])

            if output:
                outputs.append([float(row[rows_number])])
    if output:
        return (inputs, outputs)
    else:
        return (inputs)
    
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
    
    @classmethod # second constructor
    def onesWeights(cls, inputs_number, nodes_number1, outputs_number, lr):
        w1 = [[0 for i in range(nodes_number1)] for j in range(inputs_number)] # 3 inputs 4 outputs
        b1 = [0 for i in range(nodes_number1)]

        w2 = [[0 for i in range(outputs_number)] for j in range(nodes_number1)]
        b2 = [0 for i in range(outputs_number)]
        
        return cls(w1, b1, w2, b2, lr)

    def think(self, x):
        self.l1_output = self.feedForward(x, self.w1, self.b1)
        #print(self.l1_output)
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
        #print(y)
        e = 2*(y_desired[0]-y[0]);

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
            #print(y[o])
        return y

    def activationFunction(self, x):
        return 1 / (1 + math.exp(-x))
    
if __name__ == "__main__":

    #w1 = [[1,1,1,1], [1,1,1,1], [1,1,1,1]] # 3 inputs 4 outputs
    #b1 = [1,1,1,1]

    #w2 = [[1], [1], [1], [1]] # 1 output from 4 sources
    #b2 = [1]
    
    #neuralNetwork = FeedForward(w1, b1, w2, b2, 0.1)
    neuralNetwork = FeedForward.onesWeights(256, 100, 1, 1)

    # training
    data = parse_csv("./dataset/ID02/dataset.csv", 256)
    x = data[0]
    y = data[1]
    data_num = len(data[0])
    
    for i in range(0, 100): 

        neuralNetwork.e = 0
        
        for j in range(0, data_num):
            neuralNetwork.learn(x[j], y[j])
            #print(neuralNetwork.e)

        
        print(i)
        print(neuralNetwork.e)

    #################################
    # print weights
    #print("w1:")
    #print(neuralNetwork.w1)
    
    #print("w2:")
    #print(neuralNetwork.w2)
    
    #print("b1:")
    #print(neuralNetwork.b1)
    
    #print("b2:")
    #print(neuralNetwork.b2)
    
    ################################
    # testing
    #ictal = parse_csv("./dataset/ID02/ictal.csv", 16)
    #ictal_x = ictal[0]
    #ictal_y = ictal[1]

    #interictal = parse_csv("./dataset/ID02/interictal.csv", 256)
    #interictal_x = interictal[0]
    #interictal_y = interictal[1]
    #
    #print(neuralNetwork.think(ictal_x[0])) #ictal
    #print(neuralNetwork.think(ictal_x[1])) #ictal
    #print(neuralNetwork.think(ictal_x[2])) #ictal
    #print(neuralNetwork.think(ictal_x[3])) #ictal
 
    #print(neuralNetwork.think(interictal_x[0])) #ictal
    #print(neuralNetwork.think(interictal_x[1])) #ictal
    #print(neuralNetwork.think(interictal_x[2])) #ictal
    #print(neuralNetwork.think(interictal_x[3])) #ictal


    #test = parse_csv("./dataset/ID02/test.csv", 256, False);
    #test_num=len(test)
    #print(test_num)
    #print(neuralNetwork.think(test[0])) #ictal
    #print(neuralNetwork.think(test[1])) #ictal
    #print(neuralNetwork.think(test[2])) #ictal
    #print(neuralNetwork.think(test[3])) #ictal
    #for j in range(0, test_num):
    #    test[j].append(neuralNetwork.think(test[j])[0])
    #

    #with open("result.txt", "w") as test_result:
    #    writer = csv.writer(test_result)
    #    writer.writerows(test)
    #


