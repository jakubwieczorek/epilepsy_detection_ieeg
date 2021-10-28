11813/113 [==============================] - 2s 21ms/step - loss: 0.0013
Epoch 245/250
113/113 [==============================] - 2s 21ms/step - loss: 0.0011
Epoch 246/250
113/113 [==============================] - 2s 21ms/step - loss: 0.0011
Epoch 247/250
113/113 [==============================] - 2s 21ms/step - loss: 9.4223e-04
Epoch 248/250
113/113 [==============================] - 2s 21ms/step - loss: 8.7762e-04
Epoch 249/250
113/113 [==============================] - 2s 21ms/step - loss: 0.0349
Epoch 250/250
113/113 [==============================] - 2s 21ms/step - loss: 0.0365

 self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x6
            keras.layers.Conv1D(30, 3, activation="relu", input_shape=(CNN.input_num, CNN.sensor_num)),
            keras.layers.MaxPool1D(pool_size=2),
            keras.layers.Conv1D(60, 3, activation="relu"),
            keras.layers.MaxPool1D(pool_size=2),
            keras.layers.Conv1D(60, 3, activation="relu"),
            keras.layers.Flatten(),
            keras.layers.Dense(50, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])