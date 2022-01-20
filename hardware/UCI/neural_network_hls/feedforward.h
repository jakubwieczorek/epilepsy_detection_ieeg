#ifndef FEEDFORWARD_H
#define FEEDFORWARD_H
typedef float fp_type_t;

#define INPUTS 178
#define HIDDEN_1 72
#define OUTPUT 1

// weights_matrix[], not [][], because second dimension has to be specified
void feedforward(fp_type_t x[INPUTS], fp_type_t y[2]);

fp_type_t ReLU(fp_type_t x);

fp_type_t sigmoid(fp_type_t x);

#endif
