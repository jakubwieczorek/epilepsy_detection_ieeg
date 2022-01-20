TARGET = main.out
OBJECTS = main.o
LINK = g++
CXX = g++
FLAGS = -std=c++11 -g -Wall -c

$(TARGET): $(OBJECTS)
	$(LINK) -o $(TARGET) $(OBJECTS) -lm
main.o: main.cpp w1.h w2.h b1.h b2.h
	$(CXX) $(FLAGS) -o main.o main.cpp
clean:
	rm -f *.o 
	rm *.out
