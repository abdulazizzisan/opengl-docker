/*
 * Basic OpenGL Triangle Example
 * This program demonstrates basic OpenGL concepts commonly taught in computer graphics courses
 */

#include <GL/glut.h>
#include <GL/gl.h>
#include <iostream>

// Window dimensions
const int WINDOW_WIDTH = 800;
const int WINDOW_HEIGHT = 600;

// Function to initialize OpenGL settings
void initGL() {
    // Set the background color to black
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
    // Enable depth testing
    glEnable(GL_DEPTH_TEST);
    
    // Set the viewport
    glViewport(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
    
    // Set up projection matrix
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    // Set up orthographic projection
    glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0);
    
    // Switch to modelview matrix
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

// Display callback function
void display() {
    // Clear the color and depth buffers
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    // Reset transformations
    glLoadIdentity();
    
    // Draw a colorful triangle
    glBegin(GL_TRIANGLES);
        glColor3f(1.0f, 0.0f, 0.0f);  // Red vertex
        glVertex2f(0.0f, 0.6f);
        
        glColor3f(0.0f, 1.0f, 0.0f);  // Green vertex
        glVertex2f(-0.6f, -0.6f);
        
        glColor3f(0.0f, 0.0f, 1.0f);  // Blue vertex
        glVertex2f(0.6f, -0.6f);
    glEnd();
    
    // Swap front and back buffers
    glutSwapBuffers();
}

// Reshape callback function
void reshape(int width, int height) {
    if (height == 0) height = 1;
    
    glViewport(0, 0, width, height);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

// Keyboard callback function
void keyboard(unsigned char key, int x, int y) {
    switch(key) {
        case 27:  // ESC key
        case 'q':
        case 'Q':
            std::cout << "Exiting program..." << std::endl;
            exit(0);
            break;
    }
}

int main(int argc, char** argv) {
    std::cout << "Starting OpenGL Triangle Example" << std::endl;
    std::cout << "Press 'q' or ESC to quit" << std::endl;
    
    // Initialize GLUT
    glutInit(&argc, argv);
    
    // Set display mode (double buffered, RGB color, depth buffer)
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    
    // Set window size and position
    glutInitWindowSize(WINDOW_WIDTH, WINDOW_HEIGHT);
    glutInitWindowPosition(100, 100);
    
    // Create window
    glutCreateWindow("OpenGL Triangle - Computer Graphics Course");
    
    // Initialize OpenGL
    initGL();
    
    // Register callback functions
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard);
    
    // Start the main loop
    glutMainLoop();
    
    return 0;
}