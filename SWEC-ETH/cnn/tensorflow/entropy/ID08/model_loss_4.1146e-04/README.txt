Approximated entropy for 1/8 second of data, so 1024 samples for this patient.
Amount of inputs is 8, what results in the prediction for 1 second.

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