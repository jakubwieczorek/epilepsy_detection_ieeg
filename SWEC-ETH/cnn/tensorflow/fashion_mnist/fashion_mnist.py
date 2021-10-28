# https://www.superdatascience.com/blogs/the-ultimate-guide-to-convolutional-neural-networks-cnn
# https://datascience-enthusiast.com/DL/Convolution_model_Step_by_Stepv2.html
# https://stats.stackexchange.com/questions/153531/what-is-batch-size-in-neural-network

import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
# written in tf 2.2.0
print(tf.__version__)

class FeedForward:
    def __init__(self):
        data = keras.datasets.fashion_mnist
        self.train_images = []
        (self.train_images, self.train_labels), (self.test_images, self.test_labels) = data.load_data()
        self.class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
               'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

    def showSomeData(self):
        f1 = plt.figure(1)
        plt.imshow(self.train_images[0])
        plt.colorbar()
        plt.grid(False)

        f2 = plt.figure(2, figsize=(10,10))
        for i in range(25):
            plt.subplot(5,5,i+1)
            plt.xticks([])
            plt.yticks([])
            plt.grid(False)
            plt.imshow(self.train_images[i], cmap=plt.cm.binary) # in gray scale
            plt.xlabel(class_names[self.train_labels[i]])
        plt.show()

    def createModel(self):
        # 2D is for images. Even grayscale, so 28x28x1
        self.model = keras.Sequential([ # layers in sequence
                # amount of filters is amount of outputs
                # each filter of dimension 2x2 -> 28*28/4=196
                # each filter of dimension 3x3 -> 28*28/9=87.11
                keras.layers.Conv2D(87, (3, 3), activation="relu", padding="same", input_shape=(28, 28, 1)),
                # MaxPooling is used to downsample the data.
                # Formula is: output_shapcd e=(input_shape - pool_size + 1)/strides, so for pool_size 2 and input_size 5
                # output_size = 5-2+1 = 4
                # keras.layers.MaxPooling1D(2),
                # keras.layers.Conv1D(32, 3, activation="relu"),
                keras.layers.Flatten(),
                keras.layers.Dense(10, activation="softmax")
            ])
        self.model.compile(optimizer="adam", loss="sparse_categorical_crossentropy", metrics=["accuracy"])

    def createModel2(self):
        # Conv1D is for 1D data like signals, from for example different sensors. Ideal for iEEG
        self.model = keras.Sequential([ # layers in sequence
                # 32 filters, 3 kernels (1D convolutional window), 28 vectors of 28-dimensional vectors
                keras.layers.Conv1D(32, 3, activation="relu", input_shape=(28, 28)),
                keras.layers.MaxPooling1D(2),
                keras.layers.Conv1D(32, 3, activation="relu"),
                keras.layers.Flatten(),
                keras.layers.Dense(10, activation="softmax")
            ])
        self.model.compile(optimizer="adam", loss="sparse_categorical_crossentropy", metrics=["accuracy"])

    def trainModel(self, save=True):
        # https://stackoverflow.com/questions/63279168/valueerror-input-0-of-layer-sequential-is-incompatible-with-the-layer-expect
        self.train_images = tf.reshape(self.train_images, (-1, 28, 28, 1))
        self.test_images = tf.reshape(self.test_images, (-1, 28, 28, 1))

        self.model.fit(self.train_images, self.train_labels, epochs=5)  # epochs reshuffles training data

        test_loss, test_acc = self.model.evaluate(self.test_images, self.test_labels)

        print("Accuracy", test_acc)

    def trainModel2(self, save=True):
        #cp_callback = tf.keras.callback.ModelCheckpoint(filepath="./cp.ckpt", save_weights_only=True, verbose=1)
        self.model.fit(self.train_images, self.train_labels, epochs=5)  # epochs reshuffles training data

        test_loss, test_acc = self.model.evaluate(self.test_images, self.test_labels)

        print("Accuracy", test_acc)

    def saveModel(self, path):
        self.model.save(path)
        
        # there are 3 layers, but only 2 set of w and b, so 
        # here layer[1].get_weights are weights between inputs and first hl
        w1 = self.model.layers[1].get_weights()[0].tolist()
        b1  = self.model.layers[1].get_weights()[1].tolist()
        w2 = self.model.layers[2].get_weights()[0].tolist()
        b2  = self.model.layers[2].get_weights()[1].tolist()
        
        with open(path + '/w1.txt', 'w') as f:
            for i in w1:
                f.write("%s\n" % i)

    def loadModel(self, path):
        self.model = keras.models.load_model(path)

    def makeSomePrediction(self):
        prediction = self.model.predict(self.test_images)

        for i in range(5):
            plt.grid(False)
            plt.imshow(self.test_images[i], cmap=plt.cm.binary)
            plt.xlabel("Actual:" + self.class_names[self.test_labels[i]])
            plt.title("Prediction " + self.class_names[np.argmax(prediction[i])])
            plt.show()

        #prediction = model.predict([test_images[7]])
        #print(prediction)


if __name__ == "__main__":
    nn = FeedForward()
    nn.createModel()
    nn.trainModel()
    #nn.saveModel("./model")
    #nn.loadModel("./model")
    nn.makeSomePrediction()
    #nn.saveModel("./model")
