#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include <xfeedforward.h>
#include "sample.h"

XFeedforward xFeedforward;
XFeedforward_Config *xFeedforward_cfg;

float *xBRAM = (float *)0x40000000;
float *yBRAM = (float *)0x42000000;

void init_Feedforward() {
	int status=0;
	xFeedforward_cfg = XFeedforward_LookupConfig(XPAR_FEEDFORWARD_0_DEVICE_ID);
	if (xFeedforward_cfg) {
		status = XFeedforward_CfgInitialize(&xFeedforward, xFeedforward_cfg);
		if (status != XST_SUCCESS) {printf("Failed to initialize xFeedforward\n");}
		else {printf("Successfully initialized xFeedforward\n");}
	}
}

void init_data(int signal) {
	for(int i=0; i<178; i++) {
		xBRAM[i] = dataset[signal][i];
	}
}

int main(void) {
	printf("Feedforward test for EEG signals\n");
	printf("START init_Feedforward\n");
	init_Feedforward();

	for(int i=0; i<17; i++) {
		init_data(i);
		XFeedforward_Start(&xFeedforward);
		while(!XFeedforward_IsDone(&xFeedforward));
		printf("%d: expected: %d, actual %f\n", i, expected[i], yBRAM[0]);
	}
    return 0;
}