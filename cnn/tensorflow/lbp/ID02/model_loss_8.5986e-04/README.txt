Epoch 89/500
113/113 [==============================] - 0s 3ms/step - loss: 0.0049

Epoch 126/500
113/113 [==============================] - 0s 3ms/step - loss: 6.9495e-04

Epoch 500/500
113/113 [==============================] - 0s 3ms/step - loss: 8.5986e-04

self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x6
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(64, 66)),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1)
        ])
        self.model.compile(optimizer="adam", loss="mse")

as you can see in the epochs there is no difference between 126 and 500, so 130 should be enough