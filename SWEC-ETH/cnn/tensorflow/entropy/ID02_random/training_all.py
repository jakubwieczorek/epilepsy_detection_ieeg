# to print loss https://datascience.stackexchange.com/questions/53033/why-my-network-needs-so-many-epochs-to-learn
# early stopping to prevent overfitting https://www.geeksforgeeks.org/choose-optimal-number-of-epochs-to-train-a-neural-network-in-keras/
# amount of epochs https://www.researchgate.net/post/How_to_determine_the_correct_number_of_epoch_during_neural_network_training

# https://stackoverflow.com/questions/46308374/what-is-validation-data-used-for-in-a-keras-sequential-model
# https://machinelearningmastery.com/difference-between-a-batch-and-an-epoch/
# https://datascience.stackexchange.com/questions/50854/how-does-keras-train-without-disrupting-the-data-set-order
import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
import csv
import os
from random import sample

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
                outputs.append([float(row[rows_number])])  # every output wrapped in []
    if output:
        return (inputs, outputs)
    else:
        return (inputs)


class CNN:
    sensor_num = 66

    def __init__(self):
        ### train parsing
        train_dirs = [
                      #"../dataset/ID02/8/train_data119/",
                      "../dataset/ID02/8/train_data230/",
                      ]

        train_files = []
        for diR in train_dirs:
            [train_files.append(diR + file) for file in os.listdir(diR)]

        train_data = []
        self.train_data = []

        for i in range(0, len(train_files)):
            train_data.append(parse_csv(train_files[i], 8))
            self.train_data.append(train_data[i][0])

        # (3600,1), no (3600,1,62), same for all sensors
        self.train_labels = []
        for i in range(0, len(train_dirs)):
            self.train_labels = self.train_labels + train_data[i * CNN.sensor_num][1]

        ### test parsing
        test_data = []
        self.test_data = []

        test_dir = "../dataset/ID02/8/test_data233/"
        test_files = os.listdir(test_dir)

        for i in range(0, len(test_files)):
            test_data.append(parse_csv(test_dir + test_files[i], 8))
            self.test_data.append(test_data[i][0])
        self.test_labels = test_data[0][1]

        ### reshaping
        self.train_data = np.array(self.train_data)  # shape (3, 4, 64)
        self.test_data = np.array(self.test_data)
        self.train_labels = np.array(self.train_labels)
        self.test_labels = np.array(self.test_labels)

        self.test_data = tf.reshape(self.test_data, (-1, 8, CNN.sensor_num)).numpy()
        self.train_data = tf.reshape(self.train_data, (-1, 8, CNN.sensor_num)).numpy()

    def createModel(self):
        # Conv1D is for 1D data like signals, from for example different sensors. Ideal for iEEG
        self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x6
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(8, CNN.sensor_num)),
            keras.layers.MaxPooling1D(pool_size=2),
            keras.layers.Conv1D(10, 3, activation="relu"),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
        # self.model.compile(optimizer="adam", loss="mse") # with sparse_categorical_crossentropy does not working
        self.model.compile(optimizer="adam",
                           loss="binary_crossentropy")  # with sparse_categorical_crossentropy does not working

    # loss = tf.keras.losses.binary_crossentropy

    def trainModel(self, epochs_num, save=True):
        self.model.fit(self.train_data, self.train_labels, epochs=epochs_num)  # epochs reshuffles training data
        # test_loss, test_acc = self.model.evaluate(self.test_data, self.test_labels)
        # print("Accuracy", test_acc)

    def saveModel(self, path):
        self.model.save(path)

    def loadModel(self, path):
        self.model = keras.models.load_model(path)

    def makeSomePrediction(self):
        prediction = self.model.predict(self.train_data)

        plot_data = [entry[0] for entry in prediction]
        train_labels = [entry[0] for entry in self.train_labels]

        with open("train_result.csv", "w") as f:
            writer = csv.writer(f)
            writer.writerows(zip(plot_data, train_labels))
            # writer.writerows(zip(prediction, self.train_labels))

        prediction = self.model.predict(self.test_data)

        plot_data = [entry[0] for entry in prediction]
        test_labels = [entry[0] for entry in self.test_labels]

        with open("test_result.csv", "w") as f:
            writer = csv.writer(f)
            writer.writerows(zip(plot_data, test_labels))
            # writer.writerows(zip(prediction, self.test_labels))


if __name__ == "__main__":
    nn = CNN()
    nn.createModel()
    nn.trainModel(100)
    # nn.loadModel("./model")
    nn.saveModel("./model")
    nn.makeSomePrediction()
    # nn.saveModel("./model")
