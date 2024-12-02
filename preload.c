#define _GNU_SOURCE
#include <X11/Xlib.h>

// Intercepting XSetInputFocus and making it a no-op
int XSetInputFocus(Display *display, Window focus, int revert_to, Time time) {
    return Success;  // Return success
}