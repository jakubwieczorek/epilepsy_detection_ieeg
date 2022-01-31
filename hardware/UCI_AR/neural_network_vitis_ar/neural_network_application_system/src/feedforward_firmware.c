#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include <xfeedforward.h>
#include"test_data.h"
#include"test_labels.h"
#include "xil_types.h"
#include "xtmrctr.h"
#include "xparameters.h"

#define dataset_size 1150

XFeedforward xFeedforward;
XFeedforward_Config *xFeedforward_cfg;
XTmrCtr AXI_Timer;

float *xBRAM = (float *)0x40000000;
float *yBRAM = (float *)0x42000000;

float bin_accuracy(float predicted[], float expected[], int size) {
	float sum = 0;

	for(int i = 0; i < size; i++) {
		predicted[i] = predicted[i] > 0.5;
		sum += predicted[i] == expected[i];
	}

	return sum/size;
}


void init_Feedforward() {
	int status=0;
	xFeedforward_cfg = XFeedforward_LookupConfig(XPAR_FEEDFORWARD_0_DEVICE_ID);
	if (xFeedforward_cfg) {
		status = XFeedforward_CfgInitialize(&xFeedforward, xFeedforward_cfg);
		if (status != XST_SUCCESS) {printf("Failed to initialize xFeedforward\n");}
		else {printf("Successfully initialized xFeedforward\n");}
	}
}

void init_data2(int signal) {
	for(int i=0; i<11; i++) {
		xBRAM[i] = test_data[signal][i];
	}
}

int test2() {

	XTmrCtr_Initialize(&AXI_Timer, XPAR_TMRCTR_0_DEVICE_ID);

	float test_predicted[dataset_size] = {0};
	unsigned int elapsed = 0;

	for(int i = 0; i<dataset_size; i++) {
		init_data2(i);

		XTmrCtr_Start(&AXI_Timer, 0);

		XFeedforward_Start(&xFeedforward);
		while(!XFeedforward_IsDone(&xFeedforward));

		XTmrCtr_Stop(&AXI_Timer, 0);
		printf("%d: expected: %f, actual %f\n", i, test_labels[i], yBRAM[0]);
		elapsed+=XTmrCtr_GetValue(&AXI_Timer, 0);
		printf("%f seconds\n",(double)XTmrCtr_GetValue(&AXI_Timer, 0)/XPAR_AXI_TIMER_0_CLOCK_FREQ_HZ);

		test_predicted[i] = yBRAM[0];
	}

	float accuracy = bin_accuracy(test_predicted, test_labels, dataset_size);

	printf("Accuracy %f\n", accuracy);
	printf("Time for all experiments %f\n", (double)elapsed/XPAR_AXI_TIMER_0_CLOCK_FREQ_HZ);

	return 0;
}

int main(void) {
	printf("Feedforward test for EEG signals\n");
	printf("START init_Feedforward\n");
	init_Feedforward();

	test2();

    return 0;
}