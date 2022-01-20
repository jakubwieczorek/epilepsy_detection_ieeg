#include"w1.h"
#include"w2.h"
#include"b1.h"
#include"b2.h"
#include"sample.h"
#include<math.h>
#include<stdio.h>

class ActivationFunction {
public:
	virtual double activate(double x) const = 0;
};

class ReLU : public ActivationFunction {
public:
	double activate(double x) const {
		return x < 0 ? 0.0 : x;
	}
};

class Sigmoid : public ActivationFunction {
public:
        double activate(double x) const {
		return 1.0 / (1.0 + (double)exp(-x));
	}
};

void test2(const double weights_matrix[], int row, int col)
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
void feedforward(const double x[], const double weights_matrix[], int ROW, int COL, 
		const double biases[], double y[], const ActivationFunction &activationFunction)
{
	int o, i;
	double cur_w;

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
		y[o] = activationFunction.activate(y[o] + biases[o]);
	}
}

void think(double x[], double y[], double z[])
{
	double l1_output[72] = {0};
	feedforward(x        , w1[0], 178, 72, b1, l1_output, ReLU());
	feedforward(l1_output,  w2[0], 72, 1,  b2, y, Sigmoid());
}

int main(void)
{
	double y[1] = {0};
	double z[1] = {0};

	think(one, y, z);

	for(int i = 0; i < 1; i++)
	{
		printf("%f\n", y[i]);
	}

	return 0;
}

