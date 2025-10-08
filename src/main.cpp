// Your main project file - start writing your OpenGL code here!
// This template follows the same structure as the examples

#include <GL/glut.h>
#include <GL/gl.h>
#include <iostream>

// Window dimensions
const int WINDOW_WIDTH = 800;
const int WINDOW_HEIGHT = 600;

// Initialize OpenGL settings
void initGL() {
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);  // Black background
    glEnable(GL_DEPTH_TEST);
    
    // Set up projection
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

// Display function - put your drawing code here
void display() {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glLoadIdentity();
    
    // TODO: Add your OpenGL drawing code here
    // Example: Draw a simple point at the center
    glColor3f(1.0f, 1.0f, 1.0f);  // White color
    glPointSize(5.0f);
    glBegin(GL_POINTS);
        glVertex2f(0.0f, 0.0f);
    glEnd();
    
    glutSwapBuffers();
}

// Handle window resize
void reshape(int width, int height) {
    if (height == 0) height = 1;
    
    glViewport(0, 0, width, height);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

// Handle keyboard input
void keyboard(unsigned char key, int x, int y) {
    switch(key) {
        case 27:  // ESC key
        case 'q':
        case 'Q':
            std::cout << "Goodbye!" << std::endl;
            exit(0);
            break;
    }
}

int main(int argc, char** argv) {
    std::cout << "OpenGL Template Program" << std::endl;
    std::cout << "Press 'q' or ESC to quit" << std::endl;
    
    // Initialize GLUT
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(WINDOW_WIDTH, WINDOW_HEIGHT);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("My OpenGL Project");
    
    // Initialize OpenGL
    initGL();
    
    // Register callbacks
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard);
    
    // Start main loop
    glutMainLoop();
    
    return 0;
}