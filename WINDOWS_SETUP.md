# Windows Setup Guide for OpenGL Docker Environment

This guide will help you set up the OpenGL development environment on Windows.

## Step 1: Install Docker Desktop

1. Download Docker Desktop from: https://www.docker.com/products/docker-desktop/
2. Install and restart your computer
3. Start Docker Desktop and ensure it's running

## Step 2: Install X Server (VcXsrv)

Since Windows doesn't have a built-in X server, you need to install one to display OpenGL windows.

1. **Download VcXsrv**: https://sourceforge.net/projects/vcxsrv/
2. **Install VcXsrv** with default settings
3. **Configure VcXsrv**:
   - Start "XLaunch" from Start Menu
   - Choose "Multiple windows" → Next
   - Choose "Start no client" → Next
   - **IMPORTANT**: Check "Disable access control" → Next
   - Finish

## Step 3: Set Up Environment

1. **Open PowerShell or Command Prompt**
2. **Navigate to your project directory**:

   ```bash
   cd C:\Users\yourusername\Desktop\glut-docker
   ```

3. **Set DISPLAY variable** (required each time):

   ```bash
   # In PowerShell
   $env:DISPLAY="host.docker.internal:0.0"

   # In Command Prompt
   set DISPLAY=host.docker.internal:0.0

   # In Git Bash (recommended)
   export DISPLAY=host.docker.internal:0.0
   ```

## Step 4: Build and Run

1. **Build the Docker environment**:

   ```bash
   docker-compose build
   ```

2. **Start the development container**:

   ```bash
   docker-compose run --rm opengl-dev
   ```

3. **Inside the container, test the setup**:

   ```bash
   # Test X11 connection
   xeyes

   # Build and run triangle example
   make run-triangle
   ```

## Alternative: Quick Start Script for Windows

Create a `start.bat` file in your project directory:

```batch
@echo off
echo Starting VcXsrv (if not already running)...
start "" "C:\Program Files\VcXsrv\xlaunch.exe" -run "C:\Program Files\VcXsrv\config.xlaunch"

echo Setting DISPLAY variable...
set DISPLAY=host.docker.internal:0.0

echo Starting Docker container...
docker-compose run --rm opengl-dev
```

Then just double-click `start.bat` to start everything.

## Troubleshooting Windows-Specific Issues

### Issue: "Cannot connect to X server"

1. Ensure VcXsrv is running (check system tray)
2. Make sure "Disable access control" was checked during XLaunch setup
3. Restart VcXsrv with the correct settings
4. Check Windows Firewall - allow VcXsrv through firewall

### Issue: VcXsrv not working

1. Try alternative X servers:
   - **Xming**: https://sourceforge.net/projects/xming/
   - **MobaXterm**: https://mobaxterm.mobatek.net/ (includes X server)

### Issue: Docker not starting

1. Ensure Docker Desktop is running
2. Enable WSL 2 if prompted
3. Restart Docker Desktop

### Issue: Path problems

Use forward slashes in paths within the container, even on Windows.

## Recommended Development Setup

1. **Use Git Bash** or **PowerShell** as your terminal
2. **Keep VcXsrv running** in the background
3. **Use VS Code** with Docker extension for editing
4. **Set up aliases** for common commands:
   ```bash
   alias gl-start='export DISPLAY=host.docker.internal:0.0 && docker-compose run --rm opengl-dev'
   ```

## Performance Tips

1. **Increase Docker memory allocation** in Docker Desktop settings
2. **Enable hardware acceleration** in VcXsrv settings if available
3. **Close unnecessary applications** when running graphics programs
