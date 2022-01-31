#include"w1.h"
#include"w2.h"
#include"b1.h"
#include"b2.h"
#include"sample.h"
#include<math.h>
#include<stdio.h>
#include"val_data.h"
#include"val_labels.h"
#include"test_data.h"
#include"test_labels.h"

#define data_size 1150

void test2(const float weights_matrix[], int row, int col)
{
	int i, j;
	for(i=0; i<row; i++){
        	for(j=0; j<col; j++){
            		printf("%f ", *(weights_matrix + i*col + j)); // or better: printf("%d ", *matrix++);
        	}
       		printf("\n");
	}
}

// weights_matrix[], not [][], because second dimension has to be specified
void feedforward(const float x[], const float weights_matrix[], int ROW, int COL, const float biases[], float y[], float (*activationFunction)(float))
{
	int o, i;
	float cur_w;

		for(i = 0; i < ROW; i++)
	{
	for(o = 0; o < COL; o++)
		{	
			cur_w = *(weights_matrix + i*COL + o);
			y[o] += cur_w * x[i];
		}
	
	}

	for(o = 0; o < COL; o++)
	{
		y[o] = (*activationFunction)(y[o] + biases[o]);
	}
}

float ReLU(float x)
{
	if(x < 0) {
		return 0.0;
	} else {
		return x;
	}
}

float sigmoid(float x)
{
	return 1.0 / (1.0 + (float)exp(-x));
}

void think(float x[], float y[], float z[])
{
	float l1_output[72] = {0};
	feedforward(x        , w1[0], 178, 72, b1, l1_output, &ReLU);
	feedforward(l1_output,  w2[0], 72, 1,  b2, y, &sigmoid);
}

float bin_accuracy(float predicted[], float expected[], int size) {
	float sum = 0;

	for(int i = 0; i < size; i++) {
		predicted[i] = predicted[i] > 0.5;
		sum += predicted[i] == expected[i];
	}

	return sum/size;
}

int main(void)
{
	float y[1] = {0};
	float z[1] = {0};
	float test_predicted[data_size] = {0};

	for(int i = 0; i < data_size; i++)
	{
		think(test_data[i], y, z);
		test_predicted[i] = y[0];
		printf("%f\n", test_predicted[i]);
	}
	
	float accuracy = bin_accuracy(test_predicted, test_labels, data_size);

	printf("Accuracy %f\n", accuracy);
	return 0;
}

