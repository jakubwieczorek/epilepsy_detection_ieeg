All of these are for the all sensors and ID02

self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x6
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(64, 66)),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1)
        ])
        self.model.compile(optimizer="adam", loss="mse")

model_loss_0.0074, epochs 100,
model_loss_0.0022, epochs 130 <- OPTIMUM for this configuration
model_loss_0.0042, epochs 300
model_loss_8.5986e-04, epochs 500, but was the same in this experiment even for 120 (check README for this test)
so for this model, more epochs do not improve the classification result


---------------------
metrics accuracy does not working in any model
---------------------
self.model = keras.Sequential([  # layers in sequence
            # 8 filters, 3 kernels (1D convolutional window), 64x6
            keras.layers.Conv1D(20, 3, activation="relu", input_shape=(64, 66)),
            keras.layers.Flatten(),
            keras.layers.Dense(20, activation="relu"),
            keras.layers.Dense(1, activation="sigmoid")
        ])
        self.model.compile(optimizer="adam", loss="mse")

model_loss_0.0098, epochs 120
activation sigmoid, however does not look good on the plot, so only one test

----------------------
self.model = keras.Sequential([  # layers in sequence
        # 8 filters, 3 kernels (1D convolutional window), 64x6
        keras.layers.Conv1D(20, 3, activation="relu", input_shape=(64, 66)),
        keras.layers.Flatten(),
        keras.layers.Dense(20, activation="relu"),
        keras.layers.Dense(1, activation="sigmoid")
    ])
    self.model.compile(optimizer="adam", loss="binary_crossentropy")

model_loss_0.0242, 120 epochs
model_loss_0.0024, 250 epochs <- on 160 would be better (check README for this model)

the best one so far
sigmoid + binary_crossentropy