# Makefile for OpenGL projects
# Compiler settings
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11 -O2

# OpenGL/GLUT libraries
LIBS = -lGL -lGLU -lglut -lX11 -lXmu -lXi -lm

# Directories
SRC_DIR = src
EXAMPLES_DIR = examples
BUILD_DIR = build

# Default target
.PHONY: all clean main triangle cube examples help

all: main

# Build main project
main: $(BUILD_DIR)/main
	@echo "Built main project successfully!"

$(BUILD_DIR)/main: $(SRC_DIR)/main.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $< $(LIBS)

# Build examples
triangle: $(BUILD_DIR)/triangle
	@echo "Built triangle example successfully!"

$(BUILD_DIR)/triangle: $(EXAMPLES_DIR)/triangle.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $< $(LIBS)

cube: $(BUILD_DIR)/rotating_cube
	@echo "Built rotating cube example successfully!"

$(BUILD_DIR)/rotating_cube: $(EXAMPLES_DIR)/rotating_cube.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $< $(LIBS)

examples: triangle cube
	@echo "Built all examples successfully!"

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Run targets
run-main: main
	@echo "Running main project..."
	./$(BUILD_DIR)/main

run-triangle: triangle
	@echo "Running triangle example..."
	./$(BUILD_DIR)/triangle

run-cube: cube
	@echo "Running rotating cube example..."
	./$(BUILD_DIR)/rotating_cube

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)/*
	@echo "Cleaned build directory!"

# Help target
help:
	@echo "Available targets:"
	@echo "  all          - Build main project (default)"
	@echo "  main         - Build main project"
	@echo "  triangle     - Build triangle example"
	@echo "  cube         - Build rotating cube example"
	@echo "  examples     - Build all examples"
	@echo "  run-main     - Build and run main project"
	@echo "  run-triangle - Build and run triangle example"
	@echo "  run-cube     - Build and run rotating cube example"
	@echo "  clean        - Clean build directory"
	@echo "  help         - Show this help message"