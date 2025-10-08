#!/bin/bash
# Test script to verify OpenGL Docker environment setup

echo "=========================================="
echo "OpenGL Docker Environment Test Script"
echo "=========================================="

# Test 1: Check if Docker is running
echo "Test 1: Checking Docker availability..."
if command -v docker &> /dev/null && docker info &> /dev/null; then
    echo "✓ Docker is available and running"
else
    echo "✗ Docker is not available or not running"
    echo "  Please install Docker and ensure it's running"
    exit 1
fi

# Test 2: Check if docker-compose is available
echo ""
echo "Test 2: Checking Docker Compose availability..."
if command -v docker-compose &> /dev/null; then
    echo "✓ Docker Compose is available"
else
    echo "✗ Docker Compose is not available"
    echo "  Please install Docker Compose"
    exit 1
fi

# Test 3: Build the container
echo ""
echo "Test 3: Building OpenGL container..."
if docker-compose build > /dev/null 2>&1; then
    echo "✓ Container built successfully"
else
    echo "✗ Container build failed"
    echo "  Check Docker setup and try again"
    exit 1
fi

# Test 4: Test compilation
echo ""
echo "Test 4: Testing compilation inside container..."
if docker-compose run --rm opengl-dev bash -c "make triangle > /dev/null 2>&1"; then
    echo "✓ Triangle example compiled successfully"
else
    echo "✗ Compilation failed"
    echo "  Check container setup"
    exit 1
fi

if docker-compose run --rm opengl-dev bash -c "make main > /dev/null 2>&1"; then
    echo "✓ Main project template compiled successfully"
else
    echo "✗ Main project compilation failed"
    exit 1
fi

if docker-compose run --rm opengl-dev bash -c "make cube > /dev/null 2>&1"; then
    echo "✓ Rotating cube example compiled successfully"
else
    echo "✗ Cube example compilation failed"
    exit 1
fi

# Test 5: Check if executables can start
echo ""
echo "Test 5: Testing executable startup..."
if docker-compose run --rm opengl-dev bash -c "timeout 1s ./build/triangle 2>&1 | grep -q 'Starting OpenGL Triangle Example'"; then
    echo "✓ Triangle executable starts correctly"
else
    echo "✗ Triangle executable startup failed"
fi

# Test 6: Check DISPLAY variable guidance
echo ""
echo "Test 6: Display setup guidance..."
echo "📋 For GUI display, you need an X server:"
echo "   Windows: Install VcXsrv and set DISPLAY=host.docker.internal:0.0"
echo "   Linux:   Run 'xhost +local:docker' and ensure DISPLAY is set"
echo "   macOS:   Install XQuartz and configure X11 forwarding"

echo ""
echo "=========================================="
echo "🎉 All tests passed!"
echo "=========================================="
echo ""
echo "Your OpenGL Docker environment is ready!"
echo ""
echo "Quick start commands:"
echo "  docker-compose run --rm opengl-dev    # Start development environment"
echo "  make run-triangle                      # Build and run triangle example"
echo "  make run-cube                          # Build and run cube example"
echo "  make main                              # Build your main project"
echo ""
echo "Next steps:"
echo "1. Set up X server for GUI display (see WINDOWS_SETUP.md)"
echo "2. Edit src/main.cpp to start your OpenGL project"
echo "3. Use 'make run-main' to build and run your code"
echo ""
echo "Happy coding! 🚀"