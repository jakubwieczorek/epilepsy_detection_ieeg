# to print loss https://datascience.stackexchange.com/questions/53033/why-my-network-needs-so-many-epochs-to-learn
# early stopping to prevent overfitting https://www.geeksforgeeks.org/choose-optimal-number-of-epochs-to-train-a-neural-network-in-keras/
# amount of epochs https://www.researchgate.net/post/How_to_determine_the_correct_number_of_epoch_during_neural_network_training
# https://www.tensorflow.org/guide/keras/train_and_evaluate
# https://stats.stackexchange.com/questions/260294/keras-why-does-loss-decrease-while-val-loss-increase
# https://machinelearningmastery.com/difference-between-a-batch-and-an-epoch/
# https://stackoverflow.com/questions/4752626/epoch-vs-iteration-when-training-neural-networks
# https://datascience.stackexchange.com/questions/42657/what-are-the-possible-approaches-to-fixing-overfitting-on-a-cnn/42663#42663
import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
import csv
import os

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
    sensor_num = 61

    def __init__(self):
        ### train parsing
        train_dirs = ["../dataset/ID08/8/train_data18/",
                       "../dataset/ID08/8/train_data20/",
                       # "../dataset/ID08/8/test_data19/",
                       "../dataset/ID08/8/train_data21/",
                       "../dataset/ID08/8/train_data119/",
                       "../dataset/ID08/8/train_data122/",
                       "../dataset/ID08/8/train_data132/",
                      ]
        
        val_dir = "../dataset/ID08/8/test_data19/"
        
        test_dir = "../dataset/ID08/8/test_data19/"
        
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

        test_files = os.listdir(test_dir)

        for i in range(0, len(test_files)):
            test_data.append(parse_csv(test_dir + test_files[i], 8))
            self.test_data.append(test_data[i][0])
        self.test_labels = test_data[0][1]

        ### val parsing
        val_data = []
        self.val_data = []

        val_files = os.listdir(val_dir)

        for i in range(0, len(val_files)):
            val_data.append(parse_csv(val_dir + val_files[i], 8))
            self.val_data.append(val_data[i][0])
        self.val_labels = val_data[0][1]

        ### reshaping
        self.train_data = np.array(self.train_data)  # shape (3, 4, 64)
        self.train_labels = np.array(self.train_labels)
        self.train_data = tf.reshape(self.train_data, (-1, 8, CNN.sensor_num)).numpy()

        self.test_labels = np.array(self.test_labels)
        self.test_data = np.array(self.test_data)
        self.test_data = tf.reshape(self.test_data, (-1, 8, CNN.sensor_num)).numpy()

        self.val_labels = np.array(self.val_labels)
        self.val_data = np.array(self.val_data)
        self.val_data = tf.reshape(self.val_data, (-1, 8, CNN.sensor_num)).numpy()


    def createModel(self):
        # Conv1D is for 1D data like signals, from for example different sensors. Ideal for iEEG
        self.model = keras.Sequential([  # layers in sequence
            keras.layers.Conv1D(100, 3, activation="relu", input_shape=(8, CNN.sensor_num),
                                kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
                                bias_regularizer=keras.regularizers.l2(1e-4),
                                activity_regularizer=keras.regularizers.l2(1e-5)),
            # keras.layers.BatchNormalization(),
            # keras.layers.Conv1D(64, 3, activation="relu",
            #                     kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4)),
            keras.layers.Flatten(),
            keras.layers.Dense(100, activation="relu"),
            keras.layers.Dropout(0.5),
            keras.layers.Dense(100, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
        # self.model.compile(optimizer="adam", loss="mse") # with sparse_categorical_crossentropy does not working
        self.model.compile(optimizer="adam",
                           loss="binary_crossentropy")  # with sparse_categorical_crossentropy does not working

    # loss = tf.keras.losses.binary_crossentropy

    def trainModel(self, epochs_num, save=True):
        callbacks = [
            keras.callbacks.EarlyStopping(
                # Stop training when `val_loss` is no longer improving
                monitor="val_loss",
                # "no longer improving" being defined as "no better than 1e-2 less"
                min_delta=1e-2,
                # "no longer improving" being further defined as "for at least 2 epochs"
                patience=2,
                verbose=1,
            )
        ]
        # for 6 files each 3600 samples -> 6*3600=21600 samples.T his is when batch_size=1, when 32m, then 21600/32=675
        self.history = self.model.fit(
            self.train_data, self.train_labels,
            epochs=epochs_num,
            batch_size=32, # 32 by default https://keras.io/api/models/model_training_apis/
            # callbacks=callbacks,
            # validation_split=0.2
            validation_data=(self.val_data, self.val_labels)
        )  # epochs reshuffles training data
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
    nn.trainModel(1500)
    # nn.loadModel("./model")
    nn.saveModel("./model")
    nn.makeSomePrediction()
    # nn.saveModel("./model")
