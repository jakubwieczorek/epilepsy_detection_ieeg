#include"w1.h"
#include"w2.h"
#include"b1.h"
#include"b2.h"
#include<hls_math.h>
#include"feedforward.h"

fp_type_t ReLU(fp_type_t x) {
	return x < (fp_type_t)0 ? (fp_type_t)0 : x;
}

fp_type_t sigmoid(fp_type_t x) {
	return (fp_type_t)1 / ((fp_type_t)1 + (fp_type_t)hls::exp(-x));
}

void feedforward(fp_type_t x[INPUTS], fp_type_t y[2]) {
#pragma HLS INTERFACE s_axilite port=return bundle=CTRL_BUS
#pragma HLS INTERFACE bram port=x
#pragma HLS INTERFACE bram port=y

	int o, i;
	fp_type_t l1y[HIDDEN_1] = {0};
	fp_type_t wy_sum[HIDDEN_1] = {0};


	loop_input_1: for(i = 0; i < INPUTS; i++) {
#pragma HLS PIPELINE II=10
		loop_output_1: for(o = 0; o < HIDDEN_1; o++) {
				wy_sum[o] += w1[i][o] * x[i];
			}
	}

	loop_activation_function_1: for(o = 0; o < HIDDEN_1; o++) {
#pragma HLS PIPELINE II=10
		l1y[o] = ReLU(wy_sum[o] + b1[o]);
	}


	loop_input_2: for(i = 0; i < HIDDEN_1; i++) {
#pragma HLS PIPELINE II=10
		y[0] += w2[i][0] * l1y[i];
	}

	y[0] = sigmoid(y[0] + b2[0]);
}

