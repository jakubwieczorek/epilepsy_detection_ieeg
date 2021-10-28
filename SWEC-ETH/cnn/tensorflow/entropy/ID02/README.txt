Approximated entropy for 1/8 second of data, so 512/1024 samples.
Amount of inputs is 8, what results in the prediction for 1 second.

model_loss_0.0014:
train_data230
test_data233

Epoch 100/100
113/113 [==============================] - 0s 2ms/step - loss: 0.0014

self.model = keras.Sequential([  # layers in sequence
            keras.layers.Conv1D(10, 3, activation="relu", input_shape=(8, CNN.sensor_num)),
            keras.layers.Flatten(),
            keras.layers.Dense(10, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
        self.model.compile(optimizer="adam", loss="binary_crossentropy")  # with sparse_categorical_crossentropy does not working


model_loss_1.111e-05:
train_data230
test_data233

Epoch 100/100
113/113 [==============================] - 0s 2ms/step - loss: 1.1110e-05

self.model = keras.Sequential([  # layers in sequence
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(8, CNN.sensor_num)),
            keras.layers.MaxPooling1D(pool_size=2),
            keras.layers.Conv1D(10, 3, activation="relu"),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
self.model.compile(optimizer="adam", loss="binary_crossentropy")  # with sparse_categorical_crossentropy does not working
