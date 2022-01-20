#!/bin/bash

cp ../../../../UCI/nn/raw/72/model/*.txt .

for f in w*.txt; do
	sed -i 's/ /, /g' $f
	sed -i 's/$/},/g' $f
	sed -i 's/^/{/g' $f

	sed -i '1s/^/double '$f'[][] = {/' $f
	sed -i 's/.txt//g' $f
	echo "};" >> $f
done

for f in b*.txt; do
	sed -i 's/$/, /g' $f
	sed -i '1s/^/double '$f'[] = {/' $f
	sed -i 's/.txt//g' $f
	echo "};" >> $f
done

rename -f "s/txt/h/" w*.txt
rename -f "s/txt/h/" b*.txt
