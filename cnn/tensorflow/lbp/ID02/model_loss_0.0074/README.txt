Epoch 100/100
113/113 [==============================] - 0s 3ms/step - loss: 0.0074

self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x6
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(64, 66)),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1)
        ])
        self.model.compile(optimizer="adam", loss="mse")
