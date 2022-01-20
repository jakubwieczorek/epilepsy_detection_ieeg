#include"sample.h"
#include"feedforward.h"
#include<hls_math.h>
#include<stdio.h>

int main(void)
{
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

