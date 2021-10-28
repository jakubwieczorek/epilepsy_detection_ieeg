Epoch 166/250
113/113 [==============================] - 0s 3ms/step - loss: 0.0011
Epoch 167/250
113/113 [==============================] - 0s 3ms/step - loss: 0.0010
Epoch 168/250
113/113 [==============================] - 0s 3ms/step - loss: 9.3499e-04

Epoch 249/250
113/113 [==============================] - 0s 3ms/step - loss: 0.0045
Epoch 250/250
113/113 [==============================] - 0s 3ms/step - loss: 0.0024


self.model = keras.Sequential([  # layers in sequence
        # 8 filters, 3 kernels (1D convolutional window), 64x6
        keras.layers.Conv1D(20, 3, activation="relu", input_shape=(64, 66)),
        keras.layers.Flatten(),
        keras.layers.Dense(20, activation="relu"),
        keras.layers.Dense(1, activation="sigmoid")
    ])
    self.model.compile(optimizer="adam", loss="binary_crossentropy")


sigmoid + binary_crossentropy, very good adjustment, but not on the test data. Best one so far.
Amount of epochs should be around 160, 250 is to much