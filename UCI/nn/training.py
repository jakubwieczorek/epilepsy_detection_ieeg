import tensorflow as tf
from tensorflow import keras
import numpy as np
import csv
import random
import json

# written in tf 2.2.0
print(tf.__version__)


# https://towardsdatascience.com/seizure-classification-d0bb92d19962
# https://www.sciencedirect.com/science/article/pii/S2352914820305943 same as above

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


class FeedForward:

    def __init__(self, file, size):
        # data = (parse_csv('./data_lbp_4.csv', 16))
        # data = (parse_csv('./data_lbp_6.csv', 64))
        # data = (parse_csv('./raw.csv', 178))
        data = (parse_csv(file, size))
        self.data = data[0]
        self.data_labels = data[1]

        samples_num = len(self.data_labels)
        rand_idx = list(range(1, samples_num))
        random.shuffle(rand_idx)

        self.data = np.array(self.data)
        self.data_labels = np.array(self.data_labels)

        train_idx = rand_idx[:int(samples_num * 0.8)]
        test_idx = rand_idx[int(samples_num * 0.8):int(samples_num * 0.9)]
        val_idx = rand_idx[int(samples_num * 0.9):]

        self.train_data = self.data[train_idx]
        self.train_labels = self.data_labels[train_idx]

        self.test_data = self.data[test_idx]
        self.test_labels = self.data_labels[test_idx]

        self.val_data = self.data[val_idx]
        self.val_labels = self.data_labels[val_idx]

    def createModel(self, n):
        self.model = keras.Sequential([  # layers in sequence
            keras.layers.Dense(n, activation="relu",
                               kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
                               bias_regularizer=keras.regularizers.l2(1e-4),
                               activity_regularizer=keras.regularizers.l2(1e-5)),  # Dense means fully connected
            # keras.layers.Dense(100, activation="relu"),
            # kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
            # bias_regularizer=keras.regularizers.l2(1e-4),
            # activity_regularizer=keras.regularizers.l2(1e-5)),  # Dense means fully connected
            # keras.layers.Dense(100, activation="relu"), # Dense means fully connected
            # keras.layers.Dense(5, activation="relu"),
            # kernel_regularizer=keras.regularizers.l1_l2(l1=1e-5, l2=1e-4),
            # bias_regularizer=keras.regularizers.l2(1e-4),
            # activity_regularizer=keras.regularizers.l2(1e-5)),  # Dense means fully connected
            # keras.layers.Dense(100, activation="relu"), # Dense means fully connected
            keras.layers.Dense(1, activation="sigmoid")
        ])
        self.model.compile(optimizer="adam", loss="binary_crossentropy",
                           metrics='accuracy')  # with sparse_categorical_crossentropy does not working

    def trainModel(self, epochs_num, save=True):
        self.history = self.model.fit(  # epochs reshuffles training data
            self.train_data, self.train_labels,
            epochs=epochs_num,
            batch_size=32,  # 32 by default https://keras.io/api/models/model_training_apis/
            # callbacks=callbacks,
            # validation_split=0.2,
            validation_data=(self.val_data, self.val_labels),
            shuffle=True
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

    def makeSomePrediction(self, path):
        prediction = self.model.predict(self.test_data)

        plot_data = [entry[0] for entry in prediction]
        plot_data_labels = [entry[0] for entry in self.test_labels]

        with open(path, "w") as f:
            writer = csv.writer(f)
            writer.writerows(zip(plot_data, plot_data_labels))
            # writer.writerows(zip(prediction, self.train_labels))


def train_entropy(window_size):
    data_file = "./entropy/entropy_{window_size}.csv"
    result_dir = "./entropy/{window_size}/{neurons}/model/"
    best_result_dir = "./entropy/{window_size}/best_results.csv"

    nn = FeedForward(data_file.format(window_size=window_size), 178 - window_size)  # 178 is the amount of samples

    accuracies = []
    losses = []
    val_accuracies = []
    val_losses = []

    for i in range(10, 200):
        nn.createModel(i)
        nn.trainModel(300)
        cur_result_dir = result_dir.format(window_size=window_size, neurons=i)
        nn.saveModel(cur_result_dir)

        json.dump(nn.history.history, open(cur_result_dir + "history.json", 'w'))
        json.dump(nn.history.params, open(cur_result_dir + "params.json", 'w'))

        accuracies.append([i, max(nn.history.history['accuracy'])])
        losses.append([i, max(nn.history.history['loss'])])
        val_accuracies.append([i, max(nn.history.history['val_accuracy'])])
        val_losses.append([i, max(nn.history.history['val_loss'])])
        nn.makeSomePrediction(cur_result_dir + "train_result.csv")

    accuracies = sorted(accuracies, key=lambda x: x[1], reverse=True)
    losses = sorted(losses, key=lambda x: x[1])
    val_losses = sorted(val_losses, key=lambda x: x[1])
    val_accuracies = sorted(val_accuracies, key=lambda x: x[1], reverse=True)

    with open(best_result_dir.format(window_size=window_size), "w") as f:
        writer = csv.writer(f)
        writer.writerow(["accuracy", "loss", "val_accuracy", "val_loss"])
        writer.writerows(zip(accuracies, losses, val_accuracies, val_losses))


def train_raw():
    data_file = "./raw/raw.csv"
    result_dir = "./raw/{neurons}/model/"
    best_result_dir = "./raw/best_results.csv"

    nn = FeedForward(data_file, 178)  # 178 is the amount of samples

    accuracies = []
    losses = []
    val_accuracies = []
    val_losses = []

    for i in range(10, 200):
        nn.createModel(i)
        nn.trainModel(300)
        cur_result_dir = result_dir.format(neurons=i)
        nn.saveModel(cur_result_dir)

        json.dump(nn.history.history, open(cur_result_dir + "history.json", 'w'))
        json.dump(nn.history.params, open(cur_result_dir + "params.json", 'w'))

        accuracies.append([i, max(nn.history.history['accuracy'])])
        losses.append([i, max(nn.history.history['loss'])])
        val_accuracies.append([i, max(nn.history.history['val_accuracy'])])
        val_losses.append([i, max(nn.history.history['val_loss'])])
        nn.makeSomePrediction(cur_result_dir + "train_result.csv")

    accuracies = sorted(accuracies, key=lambda x: x[1], reverse=True)
    losses = sorted(losses, key=lambda x: x[1])
    val_losses = sorted(val_losses, key=lambda x: x[1])
    val_accuracies = sorted(val_accuracies, key=lambda x: x[1], reverse=True)

    with open(best_result_dir, "w") as f:
        writer = csv.writer(f)
        writer.writerow(["accuracy", "loss", "val_accuracy", "val_loss"])
        writer.writerows(zip(accuracies, losses, val_accuracies, val_losses))


def train_ar():

    data_file = "./ar/ar_11.csv"
    result_dir = "./ar/11/{neurons}/model/"
    best_result_dir = "./ar/11/best_results.csv"

    nn = FeedForward(data_file, 11)

    accuracies = []
    losses = []
    val_accuracies = []
    val_losses = []

    for i in range(1, 200):
        nn.createModel(i)
        nn.trainModel(100)
        cur_result_dir = result_dir.format(neurons=i)
        nn.saveModel(cur_result_dir)

        json.dump(nn.history.history, open(cur_result_dir + "history.json", 'w'))
        json.dump(nn.history.params, open(cur_result_dir + "params.json", 'w'))

        accuracies.append([i, max(nn.history.history['accuracy'])])
        losses.append([i, max(nn.history.history['loss'])])
        val_accuracies.append([i, max(nn.history.history['val_accuracy'])])
        val_losses.append([i, max(nn.history.history['val_loss'])])
        nn.makeSomePrediction(cur_result_dir + "train_result.csv")

    accuracies = sorted(accuracies, key=lambda x: x[1], reverse=True)
    losses = sorted(losses, key=lambda x: x[1])
    val_losses = sorted(val_losses, key=lambda x: x[1])
    val_accuracies = sorted(val_accuracies, key=lambda x: x[1], reverse=True)

    with open(best_result_dir, "w") as f:
        writer = csv.writer(f)
        writer.writerow(["accuracy", "loss", "val_accuracy", "val_loss"])
        writer.writerows(zip(accuracies, losses, val_accuracies, val_losses))


if __name__ == "__main__":
    # train_entropy(5)
    # train_entropy(40)
    # train_raw()
    # train_ar()
    # nn.loadModel("./model")
    # nn.saveModel("./model")
