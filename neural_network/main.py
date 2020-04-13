#!/usr/bin/python3
import numpy

class Synapse:
    def __init__(self, x, w):
        self.x = x # value
        self.w = w # weight

class Neuron:
    def __init__(self, synapses):
        self.synapses = synapses; # inputs
        self.axon = 0 # output
    
    def feedforward(self):
        self.axon = 0
        for synapse in self.synapses:
            self.axon += synapse.x * synapse.w

        self.axon = self.activation_function(self.axon)

        return self.axon
    
    def activation_function(self, x):
        """sigmoid activation function"""
        return 1 / (1 + numpy.exp(-x))

class Layer:
    def __init__(self, neurons):
        self.neurons = neurons
        self.output = 0

    def feedforward(self):
        self.output = []

        for neuron in self.neurons:
            self.output.append(neuron.operate())

        return self.output
        

class NeuralNetwork():
    def __init__(self, layers):
        self.neurons = neurons;
        self.output = []

    def feedforward(self):
        self.output = []

        for neuron in self.neurons:
            self.output.append(neuron.operate())

        return self.output

def run():
    x1 = [1, 2, 3]
    w1 = [0.5, 0.5, 0.5]

    x2 = [4, 5, 6]
    w2 = [0.5, 0.5, 0.5]

    synapses1 = []
    synapses2 = []

    for i in range(0, 2):
        synapses1.append(Synapse(x1[i], w1[i]))
        synapses2.append(Synapse(x2[i], w2[i]))
    
    neuron1 = Neuron(synapses1)
    neuron2 = Neuron(synapses2)

    neurons = []
    neurons.append(neuron1)
    neurons.append(neuron2)

    neuralNetwork = NeuralNetwork(neurons)
    print(neuralNetwork.think())


if __name__ == "__main__":
    run()
