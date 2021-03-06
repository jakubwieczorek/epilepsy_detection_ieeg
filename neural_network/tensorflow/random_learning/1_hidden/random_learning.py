import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
# written in tf 2.2.0
print(tf.__version__)

class FeedForward:
    def __init__(self):
        self.train_images = [[0.0, 0.0, 1.0],[0.0, 1.0, 1.0],[1.0, 0.0, 0.0],[1.0, 1.0, 1.0]]
        self.train_labels = [0.0, 1.0, 1.0, 0.0]
        self.test_images = self.train_images
        self.test_labels = self.train_labels
    def createModel(self):
        self.model = keras.Sequential([ # layers in sequence
                #keras.layers.Dense(4, activation="relu"),
                keras.layers.Dense(4, activation="relu"), # Dense means fully connected
                keras.layers.Dense(1, activation="sigmoid")
            ])
        self.model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"]) # with sparse_categorical_crossentropy does not working

    def trainModel(self, epochs_num, save=True):
        self.model.fit(self.train_images, self.train_labels, epochs=epochs_num) # epochs reshuffles training data
        test_loss, test_acc = self.model.evaluate(self.test_images, self.test_labels)
        print("Accuracy", test_acc)

    def saveModel(self, path):
        self.model.save(path)
        
        # there are 3 layers, but only 2 set of w and b, so 
        # here layer[1].get_weights are weights between inputs and first hl
        w_num = 1

        for layer in self.model.layers:
            np.savetxt(path + '/w' + str(w_num) + '.txt', layer.get_weights()[0], fmt='%f')
            np.savetxt(path + '/b' + str(w_num) + '.txt', layer.get_weights()[1], fmt='%f')
            w_num += 1

    def loadModel(self, path):
        self.model = keras.models.load_model(path)

    def makeSomePrediction(self):
        prediction = self.model.predict(self.test_images)
        print(prediction)


if __name__ == "__main__":
    nn = FeedForward()
    nn.createModel()
    nn.trainModel(10000)
    #nn.loadModel("./model")
    nn.saveModel("./model")
    nn.makeSomePrediction()
    #nn.saveModel("./model")
