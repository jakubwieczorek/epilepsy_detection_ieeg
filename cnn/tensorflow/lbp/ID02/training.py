import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
import csv

# written in tf 2.2.0
print(tf.__version__)

def parse_csv(a_file_name, rows_number, output=True):
    with open(a_file_name, "r") as csv_file:
        content = csv.reader(csv_file, delimiter=",")

        inputs = []
        outputs = []

        for row in content:
            inputs.append([float(i) for i in row[0:rows_number]])

            if output:
                outputs.append([float(row[rows_number])]) # every output wrapped in []
    if output:
        return (inputs, outputs)
    else:
        return (inputs)

class CNN:
    def __init__(self):
        # training
        #data = parse_csv("./dataset/ID08/6026_6040.csv")
        train_data = parse_csv("dataset/ID02/64/train_data.csv", 64)
        test_data = parse_csv("dataset/ID02/64/test_data.csv", 64)
        
        self.train_data = train_data[0]
        self.train_data = tf.reshape(self.train_data, (-1, 64, 1)).numpy().tolist()
        self.train_labels = train_data[1]
        self.train_labels = tf.reshape(self.train_labels, (-1, 1, 1)).numpy().tolist()

        self.test_data = test_data[0]
        self.test_data = tf.reshape(self.test_data, (-1, 64, 1)).numpy().tolist()

        self.test_labels = test_data[1]
        self.test_labels = tf.reshape(self.test_labels, (-1, 1, 1)).numpy().tolist()

    def createModel(self):
        # Conv1D is for 1D data like signals, from for example different sensors. Ideal for iEEG
        self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x1
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(64, 1)),
            keras.layers.MaxPooling1D(pool_size=2),
            keras.layers.Conv1D(10, 2, activation="relu"),

            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1)
        ])
        self.model.compile(optimizer="adam", loss="mse") # with sparse_categorical_crossentropy does not working

    def trainModel(self, epochs_num, save=True):
        self.model.fit(self.train_data, self.train_labels, epochs=epochs_num) # epochs reshuffles training data
        # test_loss, test_acc = self.model.evaluate(self.test_data, self.test_labels)
        # print("Accuracy", test_acc)

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
        prediction = self.model.predict(self.train_data)
        with open("model_loss_0.0042/train_result.csv", "w") as f:
            writer = csv.writer(f)
            writer.writerows(zip(prediction, self.train_labels))

        prediction = self.model.predict(self.test_data)
        with open("model_loss_0.0042/test_result.csv", "w") as f:
            writer = csv.writer(f)
            writer.writerows(zip(prediction, self.test_labels))

if __name__ == "__main__":
    nn = CNN()
    nn.createModel()
    nn.trainModel(5)
    #nn.loadModel("./model")
    #nn.saveModel("./model")
    nn.makeSomePrediction()
    #nn.saveModel("./model")
