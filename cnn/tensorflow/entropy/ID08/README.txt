Approximated entropy for 1/8 second of data, so 1024 samples for this patient.
Amount of inputs is 8, what results in the prediction for 1 second.


loss 0.0292:
Epoch 1300/1300
675/675 [==============================] - 1s 2ms/step - loss: 0.0292

train data all sensors, hours 18, 20, 21, 119, 122, 132
test data all sensors, hour 19
self.model = keras.Sequential([  # layers in sequence
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(8, CNN.sensor_num)),
            keras.layers.MaxPooling1D(pool_size=2),
            keras.layers.Conv1D(10, 2, activation="relu"),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
self.model.compile(optimizer="adam", loss="binary_crossentropy")

loss 0.0030
Epoch 150/150
675/675 [==============================] - 2s 3ms/step - loss: 0.0030

self.model = keras.Sequential([  # layers in sequence
            keras.layers.Conv1D(100, 3, activation="relu", input_shape=(8, CNN.sensor_num)),
            keras.layers.MaxPooling1D(pool_size=2),
            keras.layers.Conv1D(70, 3, activation="relu"),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
self.model.compile(optimizer="adam", loss="binary_crossentropy")

loss: 4.1146e-04
Epoch 1233/2000
675/675 [==============================] - 6s 8ms/step - loss: 8.3811e-04
Epoch 1910/2000
675/675 [==============================] - 6s 8ms/step - loss: 0.0013
Epoch 2000/2000
675/675 [==============================] - 6s 8ms/step - loss: 4.1146e-04

self.model = keras.Sequential([  # layers in sequence6
            keras.layers.Conv1D(200, 20, activation="relu", padding="same", input_shape=(8, CNN.sensor_num)),
            keras.layers.MaxPooling1D(pool_size=2),
            keras.layers.Conv1D(150, 5, padding="same", activation="relu"),
            keras.layers.MaxPooling1D(pool_size=2),
            keras.layers.Conv1D(100, 3, padding="same", activation="relu"),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
self.model.compile(optimizer="adam", loss="binary_crossentropy")