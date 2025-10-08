# Docker container for C/C++ OpenGL development with FreeGLUT
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    cmake \
    pkg-config \
    freeglut3-dev \
    libglu1-mesa-dev \
    mesa-utils \
    libgl1-mesa-dev \
    libxmu-dev \
    libxi-dev \
    libxext-dev \
    libx11-dev \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /workspace

# Create a non-root user for development
RUN useradd -m -s /bin/bash developer && \
    chown -R developer:developer /workspace

# Switch to non-root user
USER developer

# Set environment variables for OpenGL
ENV DISPLAY=:0

# Default command
CMD ["/bin/bash"]