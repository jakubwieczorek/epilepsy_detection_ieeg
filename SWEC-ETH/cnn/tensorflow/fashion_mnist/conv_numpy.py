import numpy as np
import matplotlib.pyplot as plt


def zero_pad(X, pad):
    """
    Pad with zeros all images of the dataset X. The padding is applied to the height and width of an image,
    as illustrated in Figure 1.

    Argument:
    X -- python numpy array of shape (m, n_H, n_W, n_C) representing a batch of m images
    pad -- integer, amount of padding around each image on vertical and horizontal dimensions

    Returns:
    X_pad -- padded image of shape (m, n_H + 2*pad, n_W + 2*pad, n_C)
    """

    ### START CODE HERE ### (≈ 1 line)
    X_pad = np.pad(X, ((0, 0), (pad, pad), (pad, pad), (0, 0)), 'constant', constant_values=(0, 0))
    ### END CODE HERE ###

    return X_pad

def conv_single_step(a_slice_prev, W, b):
    """
    Apply one filter defined by parameters W on a single slice (a_slice_prev) of the output activation
    of the previous layer.

    Arguments:
    a_slice_prev -- slice of input data of shape (f, f, n_C_prev)
    W -- Weight parameters contained in a window - matrix of shape (f, f, n_C_prev)
    b -- Bias parameters contained in a window - matrix of shape (1, 1, 1)

    Returns:
    Z -- a scalar value, result of convolving the sliding window (W, b) on a slice x of the input data
    """

    ### START CODE HERE ### (≈ 2 lines of code)
    # Element-wise product between a_slice and W. Do not add the bias yet. BTW np.dot is matrix multiplication
    # https://stackoverflow.com/questions/48201729/difference-between-np-dot-and-np-multiply-with-np-sum-in-binary-cross-entropy-lo
    s = np.multiply(a_slice_prev, W)
    # Sum over all entries of the volume s.
    Z = np.sum(s)
    # Add bias b to Z. Cast b to a float() so that Z results in a scalar value.
    Z = Z + b.astype(float)
    ### END CODE HERE ###

    return Z

def conv_single_step2(a_slice_prev, W, b):
    # conv_single_step on loops
    # for cube only, so RGB colors

    x_len = len(W)
    y_len = len(W[0])
    z_len = len(W[0][0])

    # s = [[[0 for z in range(0, z_len)] for j in range(0, y_len)] for i in range(0, x_len)]

    # for k in range(0, z_len):
    #     for i in range(0, x_len):
    #         for j in range(0, y_len):
    #             s[i][j][k] = W[i][j][k] * a_slice_prev[i][j][k]
    # print(s)

    # dor product
    Z = 0
    for k in range(0, z_len):
        for i in range(0, x_len):
            for j in range(0, y_len):
                Z = Z + W[i][j][k] * a_slice_prev[i][j][k]

    return Z + b.astype(float)


def test_conv_single_step():
    np.random.seed(1)
    a_slice_prev = np.random.randn(4, 4, 3)  # cube 3x4x4 -> x layers, cube because RGB for instance
    W = np.random.randn(4, 4, 3)
    b = np.random.randn(1, 1, 1)

    Z = conv_single_step(a_slice_prev, W, b)
    print("Z =", Z)

def test_conv_single_step2():
    np.random.seed(1)
    a_slice_prev = np.random.randn(4, 4, 3)
    W = np.random.randn(4, 4, 3)
    b = np.random.randn(1, 1, 1)

    Z = conv_single_step2(a_slice_prev, W, b)
    print("Z =", Z)

def test_padding():
    np.random.seed(1)
    x = np.random.randn(4, 3, 3, 2)
    x_pad = zero_pad(x, 2)
    print("x.shape =", x.shape)
    print("x_pad.shape =", x_pad.shape)
    print("x[1,1] =", x[1, 1])
    print("x_pad[1,1] =", x_pad[1, 1])

    plt.rcParams['figure.figsize'] = (5.0, 4.0)  # set default size of plots
    plt.rcParams['image.interpolation'] = 'nearest'
    plt.rcParams['image.cmap'] = 'gray'

    f2 = plt.figure(2)
    plt.subplot(1, 2, 1)
    plt.imshow(x[0, :, :, 0])
    plt.subplot(1, 2, 2)
    plt.imshow(x_pad[0, :, :, 0])
    plt.show()


if __name__ == "__main__":
    test_padding()
    test_conv_single_step()
    test_conv_single_step2()