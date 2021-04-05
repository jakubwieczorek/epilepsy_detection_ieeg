# judge if review is good or bad

import tensorflow as tf
import numpy as np
from tensorflow import keras

data = keras.datasets.imdb

(train_data, train_labels), (test_data, test_labels) = data.load_data(num_words=10000) # only 10000 most important words

word_index = data.get_word_index()
word_index = {k:(v+3) for k, v in word_index.items()} # +3 because of PAD START UNK and UNUSED

word_index["<PAD>"]    = 0 # PAD stands for padding, so makes all reviews the same length
word_index["<START>"]  = 1 # at the beginning of all review
word_index["<UNK>"]    = 2 # unknown character
word_index["<UNUSED>"] = 3

reverse_word_index = dict([(value, key) for (key, value) in word_index.items()]) # swaps keys with value, so number points to the word

# get rid of all words which exceed more then 250 
train_data = keras.preprocessing.sequence.pad_sequences(train_data, value=word_index["<PAD>"], padding="post", maxlen=250)
test_data  = keras.preprocessing.sequence.pad_sequences(train_data, value=word_index["<PAD>"], padding="post", maxlen=250)


def decode_review(text):
    return " ".join([reverse_word_index.get(i, "?") for i in text]) # if we can't find a value, we'll put ?

print(test_data[0])
print(decode_review(test_data[0]))

model = keras.Sequential()
# we can call them preprocessing
model.add(keras.layers.Embedding(10000, 16)) # how many words, how many dimentions for a word represented as a vector
model.add(keras.layers.GlobalAveragePooling1D()) # 16 dimensions is a lot, so this layer shrinks them and makes an average

# now eventually the 16 dimensions goes into network of 3 layers
model.add(keras.layers.Dense(16, activation="relu"))
model.add(keras.layers.Dense(1, activation="sigmoid"))

model.summary()

model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])

x_val = train_data[:10000]
x_train = train_data[10000:]

y_val = train_labels[:10000]
y_train = train_labels[10000:]

fitModel = model.fit(x_train, y_train, epochs=40, batch_size=512, validation_data=(x_val, y_val), verbose=1)

results = model.evaluate(test_data, test_labels)
print(results)

test_review = test_data[0]
predict = model.predict([test_review])
print("Review: ")
print(decode_review(test_review))
print("Prediction" + str(predict[0]))
print("Actual" + str(test_labels[0]))
