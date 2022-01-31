TARGET = main.out
OBJECTS = main.o
LINK = g++
CXX = g++
FLAGS = -std=c++11 -g -Wall -c

$(TARGET): $(OBJECTS)
	$(LINK) -o $(TARGET) $(OBJECTS) -lm
main.o: main.c w1.h w2.h b1.h b2.h val_data.h val_labels.h test_data.h test_labels.h
	$(CXX) $(FLAGS) -o main.o main.c
clean:
	rm -f *.o 
	rm *.out
