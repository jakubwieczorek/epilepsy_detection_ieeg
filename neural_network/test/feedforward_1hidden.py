#!/usr/bin/python3

import math

class FeedForward:
    #def __init__(self, w1, b1, w2, b2, w3, b3, w4, b4, lr):
    def __init__(self, w1, b1, w2, b2, lr):
        self.w1 = w1
        self.b1 = b1
        self.w2 = w2
        self.b2 = b2
        self.lr = lr
        self.e  = 0
    
    @classmethod # second constructor
    def onesWeights(cls, inputs_number, nodes_number1, outputs_number, lr):
        init_value = 0.2

        w1 = [[init_value for o in range(nodes_number1)] for i in range(inputs_number)]
        b1 = [init_value for o in range(nodes_number1)]

        w2 = [[init_value for o in range(outputs_number)] for i in range(nodes_number1)]
        b2 = [init_value for o in range(outputs_number)]
        
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
        (self.l1_output, self.l1_z)  = self.feedForward(x, self.w1, self.b1, self.sigmoid)
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
            

        return dedw, dedb
    
    def learn(self, x, y_desired):
        y = self.think(x)
        dedo = self.dSqe(y, y_desired)

        (dedw2, dedb2) = self.gradientsOutput(self.l1_output, dedo, self.w2, self.dSigmoid, self.output)
        (dedw1, dedb1) = self.gradients(x, dedo, self.w1, self.w2, self.dSigmoid, self.l1_output, self.dSigmoid, self.output)
        
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

if __name__ == "__main__":

    w1 = [[0.15, 0.20], [0.25,0.30]] # 3 inputs 4 outputs
    b1 = [0.35, 0.35]

    w2 = [[0.40, 0.45], [0.50, 0.55]] # 1 output from 4 sources
    b2 = [0.60, 0.60]
    
    neuralNetwork = FeedForward(w1, b1, w2, b2, 0.5)

    for i in range(0, 10000): 
        neuralNetwork.e = 0
        d1 = [0.05,0.10]
        d2 = [0.3,0.4]
        d3 = [0.5,0.9]
        d4 = [0.8,0.03]
        d5 = [0.1,0.2]
        d6 = [0.2,0.5]

        o1 = [0.01, 0.99]
        o2 = [0.62, 0.38]
        o3 = [0.78, 0.43]
        o4 = [0.2, 0.88]
        o5 = [0.44, 0.90]
        o6 = [0.57, 0.2]
        
        neuralNetwork.learn(d1,o1)
        neuralNetwork.learn(d2,o2)
        neuralNetwork.learn(d3,o3)
        neuralNetwork.learn(d4,o4)
        neuralNetwork.learn(d5,o5)
        neuralNetwork.learn(d6,o6)
        print(i)
        print("error ", neuralNetwork.e)

    print(neuralNetwork.think([0.05,0.10]))
    print(neuralNetwork.think([0.30,0.40]))
    print(neuralNetwork.think([0.50,0.90]))
    print(neuralNetwork.think([0.80,0.03]))
    print(neuralNetwork.think([0.10,0.20]))

    # 6 targets error after 10000 epochs 0.05144313 after 100000 0.033
    # 5 targets error after 10000 epochs 0.01295
    # 4 targets error after 10000 epochs 0.0001536
    # 3 targets error after 10000 epochs 0.00025428
    # 2 targets error after 10000 epochs 0.00008878
