Approximated entropy for 1/8 second of data, so 1024 samples for this patient.
Amount of inputs is 8, what results in the prediction for 1 second.


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

