#!/bin/bash
# Build script for OpenGL projects

echo "=== OpenGL Project Build Script ==="

# Check if we're in a container
if [ -f /.dockerenv ]; then
    echo "Running inside Docker container ✓"
else
    echo "Warning: Not running in Docker container"
fi

# Function to display help
show_help() {
    echo "Usage: $0 [OPTION] [TARGET]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -c, --clean    Clean build directory before building"
    echo "  -r, --run      Run the program after building"
    echo ""
    echo "Targets:"
    echo "  main           Build main project (default)"
    echo "  triangle       Build triangle example"
    echo "  cube           Build rotating cube example"
    echo "  examples       Build all examples"
    echo "  all            Build everything"
    echo ""
    echo "Examples:"
    echo "  $0                    # Build main project"
    echo "  $0 triangle           # Build triangle example"
    echo "  $0 -r cube            # Build and run cube example"
    echo "  $0 -c all             # Clean and build everything"
}

# Parse command line arguments
CLEAN=false
RUN=false
TARGET="main"

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -c|--clean)
            CLEAN=true
            shift
            ;;
        -r|--run)
            RUN=true
            shift
            ;;
        main|triangle|cube|examples|all)
            TARGET=$1
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Clean if requested
if [ "$CLEAN" = true ]; then
    echo "Cleaning build directory..."
    make clean
fi

# Build the target
echo "Building target: $TARGET"
case $TARGET in
    main)
        make main
        EXECUTABLE="./build/main"
        ;;
    triangle)
        make triangle
        EXECUTABLE="./build/triangle"
        ;;
    cube)
        make cube
        EXECUTABLE="./build/rotating_cube"
        ;;
    examples)
        make examples
        echo "All examples built successfully!"
        exit 0
        ;;
    all)
        make main examples
        echo "Everything built successfully!"
        exit 0
        ;;
    *)
        echo "Unknown target: $TARGET"
        exit 1
        ;;
esac

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful! ✓"
    
    # Run if requested
    if [ "$RUN" = true ]; then
        echo "Running $EXECUTABLE..."
        echo "Note: Make sure your X server is running and DISPLAY is set correctly"
        $EXECUTABLE
    else
        echo "To run the program: $EXECUTABLE"
    fi
else
    echo "Build failed! ✗"
    exit 1
fi