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

