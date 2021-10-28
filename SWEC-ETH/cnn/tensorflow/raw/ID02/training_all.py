# to print loss https://datascience.stackexchange.com/questions/53033/why-my-network-needs-so-many-epochs-to-learn
# early stopping to prevent overfitting https://www.geeksforgeeks.org/choose-optimal-number-of-epochs-to-train-a-neural-network-in-keras/
# amount of epochs https://www.researchgate.net/post/How_to_determine_the_correct_number_of_epoch_during_neural_network_training

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
    sensor_num = 1
    input_num = 512

    def __init__(self):
        data_dirs = ["../dataset/ID02/data230/",
                     "../dataset/ID02/data233/"
                    ]

        data_files = []
        for diR in data_dirs:
            [data_files.append(diR + file) for file in os.listdir(diR)]

        data = []
        self.data = []

        for i in range(0, len(data_files)):
            data.append(parse_csv(data_files[i], CNN.input_num))
            self.data.append(data[i][0])

        # (3600,1), no (3600,1,62), same for all sensors
        self.data_labels = []
        for i in range(0, len(data_dirs)):
            self.data_labels = self.data_labels + data[i * CNN.sensor_num][1]

        samples_num = len(self.data_labels)
        rand_idx = list(range(1, samples_num))
        random.shuffle(rand_idx)

        self.data = tf.reshape(np.array(self.data), (-1, CNN.input_num, CNN.sensor_num)).numpy()
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
        # Conv1D is for 1D data like signals, from for example different sensors. Ideal for iEEG
        self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x6
            keras.layers.Conv1D(100, 5, activation="relu", input_shape=(CNN.input_num, CNN.sensor_num)
                                # kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
                                # bias_regularizer=keras.regularizers.l2(1e-4),
                                # activity_regularizer=keras.regularizers.l2(1e-5)
                                ),
            keras.layers.Conv1D(100, 3, activation="relu"
                                # kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
                                # bias_regularizer=keras.regularizers.l2(1e-4),
                                # activity_regularizer=keras.regularizers.l2(1e-5)
                                ),
            keras.layers.Flatten(),
            keras.layers.Dense(50, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
        # self.model.compile(optimizer="adam", loss="mse") # with sparse_categorical_crossentropy does not working
        self.model.compile(optimizer="adam", loss="binary_crossentropy") # with sparse_categorical_crossentropy does not working
    # loss = tf.keras.losses.binary_crossentropy

    def trainModel(self, epochs_num, save=True):
        self.history = self.model.fit(
            self.train_data, self.train_labels,
            epochs=epochs_num,
            batch_size=32,  # 32 by default https://keras.io/api/models/model_training_apis/
            # callbacks=callbacks,
            # validation_split=0.2
            validation_data=(self.val_data, self.val_labels)
        )
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
    nn.trainModel(250)
    #nn.loadModel("./model")
    nn.saveModel("./model")
    nn.makeSomePrediction()
    #nn.saveModel("./model")