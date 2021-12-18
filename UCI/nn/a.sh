for i in `find . -name "train_result.csv"`; do
	mv $i "`dirname $i`/test_result.csv" 
done;
