# OpenGL Docker Environment - Quick Reference

## 🚀 Quick Start Commands

```bash
# First time setup
docker-compose build

# Start development environment
docker-compose run --rm opengl-dev

# Inside container - build and run
make run-triangle    # Basic triangle example
make run-cube        # 3D rotating cube
make run-main        # Your main project
```

## 🛠️ Build Commands

| Command | Description |
|---------|-------------|
| `make main` | Build main project |
| `make triangle` | Build triangle example |
| `make cube` | Build rotating cube |
| `make examples` | Build all examples |
| `make clean` | Clean build files |
| `make help` | Show all targets |

## 🎮 Build Script Options

```bash
./build.sh               # Build main project
./build.sh triangle      # Build triangle
./build.sh cube          # Build cube
./build.sh -r triangle   # Build and run triangle
./build.sh -c all        # Clean and build everything
./build.sh -h            # Show help
```

## 📁 Project Structure

```
glut-docker/
├── src/main.cpp         # 👈 Edit this for your projects
├── examples/            # Sample programs
├── build/               # Compiled executables
├── Makefile             # Build configuration
├── build.sh             # Build script
└── README.md            # Full documentation
```

## 🖥️ Windows Display Setup

1. **Install VcXsrv**: https://sourceforge.net/projects/vcxsrv/
2. **Configure XLaunch**:
   - Multiple windows ✓
   - Start no client ✓  
   - **Disable access control** ✓ (Important!)
3. **Set environment**:
   ```bash
   export DISPLAY=host.docker.internal:0.0
   ```

## 🐛 Common Issues

| Problem | Solution |
|---------|----------|
| "Cannot connect to X server" | Check VcXsrv is running and access control disabled |
| "Permission denied" for build.sh | File should already be executable in container |
| Build fails | Make sure you're inside the Docker container |
| Window doesn't appear | Verify DISPLAY variable and X server setup |

## 💡 Development Tips

- **Save frequently** - Your code in `src/` persists outside container
- **Use version control** - Initialize git in your project directory
- **Test incrementally** - Build and run after small changes
- **Follow examples** - Check `examples/` for common patterns
- **Debug with prints** - Add `std::cout` statements for debugging

## 🔄 Typical Workflow

1. **Edit** `src/main.cpp`
2. **Build** with `make main`
3. **Run** with `./build/main`
4. **Repeat** until satisfied
5. **Clean** with `make clean` when done

## 📚 Learning Resources

- **OpenGL Tutorial**: https://learnopengl.com/
- **FreeGLUT Docs**: http://freeglut.sourceforge.net/docs/api.php
- **Examples**: Check the `examples/` directory in this project

---
*For full documentation, see README.md*