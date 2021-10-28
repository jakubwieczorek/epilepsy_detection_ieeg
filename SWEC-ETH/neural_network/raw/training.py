import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
import csv
import os
import random

# written in tf 2.2.0
print(tf.__version__)

def parse_csv(a_file_name, rows_number, output=True):
    with open(a_file_name, "rU") as csv_file:
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

class FeedForward:
    # def __init__(self):
    #     # training
    #     #data = parse_csv("./dataset/ID08/6026_6040.csv")
    #     train_data = parse_csv("../../../dataset/ID02/train_data.csv", 512)
    #     test_data =  parse_csv("../../../dataset/ID02/test_data.csv", 512)
    #
    #     self.train_data = train_data[0]
    #     self.train_labels = train_data[1]
    #
    #     self.test_data = test_data[0]
    #     self.test_labels = test_data[1]
    #
    #     self.val_data = test_data[0]
    #     self.val_labels = test_data[1]

    def __init__(self):
        ### train parsing
        data_dirs = ["./dataset/ID02/data233/",
                     "./dataset/ID02/data230/"
                     ]

        data_files = []
        for diR in data_dirs:
            [data_files.append(diR + file) for file in os.listdir(diR)]

        self.data = []
        self.data_labels = []

        for i in range(0, len(data_files)):
            data = (parse_csv(data_files[i], 512))
            self.data += data[0]
            self.data_labels += data[1]

        samples_num = len(self.data_labels)
        rand_idx = list(range(1, samples_num))
        random.shuffle(rand_idx)

        self.data = np.array(self.data)
        self.data_labels = np.array(self.data_labels)

        train_idx = rand_idx[:int(samples_num / 3)]
        test_idx = rand_idx[int(samples_num / 3):int(2 * samples_num / 3)]
        val_idx = rand_idx[int(2 * samples_num / 3):]

        self.train_data = self.data[train_idx]
        self.train_labels = self.data_labels[train_idx]

        self.test_data = self.data[test_idx]
        self.test_labels = self.data_labels[test_idx]

        self.val_data = self.data[val_idx]
        self.val_labels = self.data_labels[val_idx]

    def createModel(self):
        self.model = keras.Sequential([ # layers in sequence
                keras.layers.Dense(1000, activation="relu"),
                                    # kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
                                    # bias_regularizer=keras.regularizers.l2(1e-4),
                                    # activity_regularizer=keras.regularizers.l2(1e-5)), # Dense means fully connected
            keras.layers.Dense(500, activation="relu"),
                               # kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
                               # bias_regularizer=keras.regularizers.l2(1e-4),
                               # activity_regularizer=keras.regularizers.l2(1e-5)),  # Dense means fully connected
                # keras.layers.Dense(100, activation="relu"), # Dense means fully connected
            keras.layers.Dense(100, activation="relu"),
            # kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
            # bias_regularizer=keras.regularizers.l2(1e-4),
            # activity_regularizer=keras.regularizers.l2(1e-5)),  # Dense means fully connected
            # keras.layers.Dense(100, activation="relu"), # Dense means fully connected
                keras.layers.Dense(1, activation="sigmoid")
            ])
        self.model.compile(optimizer="adam", loss="binary_crossentropy") # with sparse_categorical_crossentropy does not working

    def trainModel(self, epochs_num, save=True):
        self.history = self.model.fit( # epochs reshuffles training data
            self.train_data, self.train_labels,
            epochs=epochs_num,
            batch_size=32,  # 32 by default https://keras.io/api/models/model_training_apis/
            # callbacks=callbacks,
            # validation_split=0.2
            validation_data=(self.val_data, self.val_labels),
            shuffle=False
        )  # epochs reshuffles training data

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

    # def makeSomePrediction(self):
    #     prediction = self.model.predict(self.test_data)
    #
    #     plot_data = [entry[0] for entry in prediction]
    #     train_labels = [entry[0] for entry in self.train_labels]
    #
    #     with open("train_result.csv", "w") as f:
    #         writer = csv.writer(f)
    #         writer.writerows(zip(plot_data, train_labels))
    #         # writer.writerows(zip(prediction, self.train_labels))
    #
    #     prediction = self.model.predict(self.test_data)
    #
    #     plot_data = [entry[0] for entry in prediction]
    #     test_labels = [entry[0] for entry in self.test_labels]
    #
    #     with open("test_result.csv", "w") as f:
    #         writer = csv.writer(f)
    #         writer.writerows(zip(plot_data, test_labels))
    #         # writer.writerows(zip(prediction, self.test_labels))
    #
    def makeSomePrediction(self):
        prediction = self.model.predict(self.data)

        plot_data = [entry[0] for entry in prediction]
        plot_data_labels = [entry[0] for entry in self.data_labels]

        with open("train_result.csv", "w") as f:
            writer = csv.writer(f)
            writer.writerows(zip(plot_data, plot_data_labels))
            # writer.writerows(zip(prediction, self.train_labels))

if __name__ == "__main__":
    nn = FeedForward()
    nn.createModel()
    nn.trainModel(100)
    #nn.loadModel("./model")
    nn.saveModel("./model")
    nn.makeSomePrediction()
    #nn.saveModel("./model")
