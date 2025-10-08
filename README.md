# OpenGL Development Environment with Docker

A containerized C/C++ OpenGL development environment using FreeGLUT, designed for computer graphics courses. This setup allows you to compile and run OpenGL programs without installing compilers or graphics libraries on your host system.

## 🚀 Quick Start

### Prerequisites

1. **Docker and Docker Compose** installed on your system
2. **X Server** for displaying OpenGL windows:
   - **Windows**: Install [VcXsrv](https://sourceforge.net/projects/vcxsrv/) or [Xming](https://sourceforge.net/projects/xming/)
   - **macOS**: Install [XQuartz](https://www.xquartz.org/)
   - **Linux**: X11 is typically pre-installed

### Setup for Windows (VcXsrv)

1. Install and start VcXsrv with these settings:

   - Multiple windows
   - Start no client
   - **Disable access control** (important!)
   - Additional parameters: `-nowgl`

2. Set your DISPLAY environment variable:
   ```bash
   export DISPLAY=host.docker.internal:0.0
   ```

### Building and Running

1. **Clone or copy this project to your desired location**

2. **Build the Docker environment:**

   ```bash
   docker-compose build
   ```

3. **Start the development container:**

   ```bash
   docker-compose run --rm opengl-dev
   ```

4. **Inside the container, build and run programs:**

   ```bash
   # Build and run the main project
   make run-main

   # Or build and run examples
   make run-triangle
   make run-cube

   # Or use the build script
   ./build.sh -r triangle
   ```

## 📁 Project Structure

```
glut-docker/
├── Dockerfile              # Container configuration
├── docker-compose.yml      # Docker Compose setup
├── Makefile                # Build automation
├── build.sh               # Build script with options
├── README.md              # This file
├── src/                   # Your main project files
│   └── main.cpp          # Template for your code
├── examples/              # Example programs
│   ├── triangle.cpp      # Basic triangle example
│   └── rotating_cube.cpp # 3D rotating cube
└── build/                 # Compiled executables (auto-created)
```

## 🛠️ Development Workflow

### 1. Working on Your Project

Edit files in the `src/` directory. The main template is in `src/main.cpp`. This file is mounted as a volume, so changes are immediately available in the container.

### 2. Building Your Program

```bash
# Using Makefile
make main                 # Build main project
make clean               # Clean build files
make help                # Show all available targets

# Using build script
./build.sh               # Build main project
./build.sh -c main       # Clean and build
./build.sh -r main       # Build and run
./build.sh -h            # Show help
```

### 3. Running Programs

```bash
# Run after building
./build/main
./build/triangle
./build/rotating_cube

# Or build and run in one command
make run-main
make run-triangle
make run-cube
```

## 📚 Example Programs

### Triangle (`examples/triangle.cpp`)

- Basic OpenGL setup
- Colorful triangle with gradient
- Keyboard input handling
- Good starting point for beginners

### Rotating Cube (`examples/rotating_cube.cpp`)

- 3D transformations
- Animation with timer
- Lighting and materials
- More advanced OpenGL concepts

### Template (`src/main.cpp`)

- Clean starting point for your projects
- Basic structure following course patterns
- Ready to customize

## 🔧 Troubleshooting

### Common Issues

#### 1. "Cannot connect to X server"

**Windows:**

- Ensure VcXsrv is running
- Check that "Disable access control" is enabled in VcXsrv
- Set DISPLAY correctly: `export DISPLAY=host.docker.internal:0.0`

**Linux:**

- Allow X11 forwarding: `xhost +local:docker`
- Or run: `docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix your-image`

#### 2. "Permission denied" for build.sh

```bash
chmod +x build.sh
```

#### 3. Build fails with linking errors

Make sure you're running inside the Docker container where all libraries are properly installed.

#### 4. Window doesn't appear

- Check that your X server is running
- Verify DISPLAY environment variable is set
- For Windows, ensure Windows Firewall allows VcXsrv

### Debugging Tips

1. **Test X11 connection:**

   ```bash
   # Inside container
   echo $DISPLAY
   xeyes   # Should open a simple X11 app
   ```

2. **Check OpenGL support:**

   ```bash
   glxinfo | grep "direct rendering"
   ```

3. **Verbose build output:**
   ```bash
   make clean
   make VERBOSE=1 main
   ```

## 🎯 Following Along with Course

### Code::Blocks Equivalent Workflow

This setup mimics the Code::Blocks + FreeGLUT environment your professor uses:

1. **New Project**: Edit `src/main.cpp`
2. **Build**: Run `make main` (equivalent to F9 in Code::Blocks)
3. **Run**: Run `./build/main` (equivalent to Ctrl+F10 in Code::Blocks)
4. **Debug**: Add print statements and rebuild

### Course Assignment Workflow

1. **Start new assignment:**

   ```bash
   cp src/main.cpp src/assignment1.cpp
   # Edit assignment1.cpp
   ```

2. **Add to Makefile:**

   ```makefile
   assignment1: $(BUILD_DIR)/assignment1
   $(BUILD_DIR)/assignment1: $(SRC_DIR)/assignment1.cpp | $(BUILD_DIR)
       $(CXX) $(CXXFLAGS) -o $@ $< $(LIBS)
   ```

3. **Build and test:**
   ```bash
   make assignment1
   ./build/assignment1
   ```

## 🔄 Advanced Usage

### Custom Compiler Flags

Edit the `CXXFLAGS` in `Makefile`:

```makefile
CXXFLAGS = -Wall -Wextra -std=c++11 -O2 -g  # Add -g for debugging
```

### Adding External Libraries

Modify `Dockerfile` to install additional packages:

```dockerfile
RUN apt-get update && apt-get install -y \
    # existing packages... \
    libglew-dev \
    libglfw3-dev
```

### Multiple Projects

Create subdirectories in `src/` for different assignments:

```
src/
├── assignment1/
│   └── main.cpp
├── assignment2/
│   └── main.cpp
└── final_project/
    └── main.cpp
```

## 📋 Makefile Targets Reference

| Target                | Description                 |
| --------------------- | --------------------------- |
| `make` or `make main` | Build main project          |
| `make triangle`       | Build triangle example      |
| `make cube`           | Build rotating cube example |
| `make examples`       | Build all examples          |
| `make run-main`       | Build and run main project  |
| `make run-triangle`   | Build and run triangle      |
| `make run-cube`       | Build and run cube          |
| `make clean`          | Remove build files          |
| `make help`           | Show available targets      |

## 💡 Tips for Success

1. **Save frequently** - Your code is in mounted volumes, so it persists
2. **Use version control** - Initialize git in your project directory
3. **Test early and often** - Build and run frequently during development
4. **Follow course examples** - The provided examples follow common course patterns
5. **Learn the shortcuts** - Use `make run-triangle` instead of separate build/run steps

## 🤝 Contributing

Feel free to add more examples or improve the setup! Common additions:

- More example programs
- Additional graphics libraries
- Improved build scripts
- Better error handling

## 📄 License

This project template is free to use for educational purposes.

---

**Happy coding!** 🎨✨

If you encounter any issues, check the troubleshooting section or ask your instructor for help.
