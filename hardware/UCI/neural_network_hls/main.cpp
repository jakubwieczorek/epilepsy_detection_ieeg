#include"sample.h"
#include"feedforward.h"
#include<hls_math.h>
#include<stdio.h>
#include"test_data.h"
#include"test_labels.h"

#define data_size 1150

fp_type_t bin_accuracy(fp_type_t test_predicted[], fp_type_t test_expected[], int size) {
	fp_type_t sum = 0;

	for(int i = 0; i < size; i++) {
			test_predicted[i] = test_predicted[i] > 0.5;
			sum += test_predicted[i] == test_expected[i];
	}

	return sum/size;
}

int test1() {
	fp_type_t y[2] = {0};


	FILE *fp = fopen("actual_result.txt", "w");

	for(int i = 0; i<17; i++) {
		feedforward(&(dataset[i*178]), y);

		printf(		"%d: expected: %d, actual %f\n", i, expected[i], y[0]);
		fprintf(fp, "%d: expected: %d, actual %f\n", i, expected[i], y[0]);
	}
	fclose(fp);

	int retval = system("diff --brief -w actual_result.txt expected_result.txt");
	if (retval != 0) {
			printf( "Test failed\n" );

			retval=1;
	} else {
			printf(  "Test passed\n"  );
	}

	return retval;
}

int test2() {
	fp_type_t y[2] = {0};
    float test_predicted[data_size] = {0};
	FILE *fp = fopen("actual_result2.txt", "w");

	for(int i = 0; i<data_size; i++) {
		feedforward(test_data[i], y);
        test_predicted[i] = y[0];
		printf(		"%d: expected: %f, actual %f\n", i, test_labels[i], y[0]);
		fprintf(fp, "%d: expected: %f, actual %f\n", i, test_labels[i], y[0]);
	}
	fclose(fp);

	float accuracy = bin_accuracy(test_predicted, test_labels, data_size);

	printf("Accuracy %f\n", accuracy);


	int retval = system("diff --brief -w actual_result2.txt expected_result2.txt");
	if (retval != 0) {
		printf( "Test failed\n" );

		retval=1;
	} else {
		printf(  "Test passed\n"  );
	}

	return retval;
}

int main(void)
{
	test1();
	return test2();
}

