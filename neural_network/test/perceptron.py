#!/usr/bin/python3

import numpy

class Perceptron:
    """neural network with only one neuron, which
    has two inputs one bias and one output. Perceptron
    is trained to do OR function using back propagation,
    where inputs with desired output are given in order to 
    tune the weights and bias according to the derivative
    of the loss function. 
    
    Loss function is a sum of squares
    of the difference between neural network output and 
    desired result. Derivative has to be calculated with
    respect to the weights and bias, but loss function
    does not contain them. Nevertheless output(y) function
    has, so the chain rule can be exploited to 
    calculate the derivative. 

    neural network output:
    y = activation_function(W*x+b)=z(W*x+b)
    chain rule:
    Loss(y, y_desired) = dLoss/dy * dy/dz * dz/dw
    
    It is worth noting that 
    simple error function as a difference of y and y_desired
    can be used as well, but it yields worse results than
    derivative, because derivative heads into the extremum.

    Bias does not have any input, so 1 as an input is passed.
  
    Learning rate speeds up learning procedure, but
    weight can be overtuned and learning can miss desired 
    tunning.

    Activation function for the neuron is sigmoid function.
    Simple 1 and 0 will be better for this example, 
    but sigmoid was chosen just for testing purposes.

    Bias is needed for that network, because without him
    for [0,0] input even for learning rate 10000
    the output will be 0.5. This is because for [0,0]
    regardless weight the output will be 0, and 
    signmoid(0) = 0.5, so bias handles 0 in the inputs
    """
    def __init__(self, w, bias, lr):
        self.w = w
        self.bias = bias
        self.lr = lr
        self.y = 0

    def think(self, x):
        y = self.feedForward(x)
        return self.activationFunction(y)

    def learnDerivative(self, x, y_desired):
        y = self.think(x)
        e = y_desired - y;
        dw = []
        #dw.append(self.dLossFunctionWb(e, x[0])) 
        #dw.append(self.dLossFunctionWb(e, x[1])) 
        dw.append(self.dLossFunctionWb(e, self.w[0]*x[0]+self.bias))
        dw.append(self.dLossFunctionWb(e, self.w[1]*x[1]+self.bias))
        #dw.append(self.dLossFunctionWb(e, y)) 
        #dw.append(self.dLossFunctionWb(e, y)) 
        dBias = self.dLossFunctionWb(e, 1)
        lr=self.lr

        self.w[0] += lr*x[0]*dw[0]
        self.w[1] += lr*x[1]*dw[1]
        self.bias += lr*1*dBias

        return [self.w, self.bias]

    def learnSimple(self, x, y_desired):        
        y = self.think(x)
        e = y_desired - y;

        lr=self.lr

        self.w[0] += lr*x[0]*e
        self.w[1] += lr*x[1]*e
        self.bias += lr*1*e
        
        return [self.w, self.bias]

    def feedForward(self, x):
        w = self.w
        return x[0]*w[0] + x[1]*w[1] + self.bias

    def activationFunction(self, x):
        return 1 / (1 + numpy.exp(-x))
    
    def lossFunction(self, y_desired, y):
        return (y_desired - y)^2

    def dLossFunctionWb(self, e, x):
        return 2*e * (numpy.exp(-x) / pow((1+numpy.exp(-x)),2))

if __name__ == "__main__":
    perceptron = Perceptron([1,1], 1, 10)

    for i in range(0, 50):
        print(perceptron.learnSimple([1,0],1))
        print(perceptron.learnSimple([0,1],1))
        print(perceptron.learnSimple([1,1],1))
        print(perceptron.learnSimple([0,0],0))

    print(perceptron.think([1,1]))    
    print(perceptron.think([0,1]))    
    print(perceptron.think([1,0]))    
    print(perceptron.think([0,0]))    


    perceptron2 = Perceptron([1,1], 1, 10)

    for i in range(0, 50):
        print(perceptron2.learnDerivative([1,0],1))
        print(perceptron2.learnDerivative([0,1],1))
        print(perceptron2.learnDerivative([1,1],1))
        print(perceptron2.learnDerivative([0,0],0))

    print(perceptron2.think([1,1]))    
    print(perceptron2.think([0,1]))    
    print(perceptron2.think([1,0]))    
    print(perceptron2.think([0,0])) 

