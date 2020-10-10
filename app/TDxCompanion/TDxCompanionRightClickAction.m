// Version: $Id$
//
//

// Commentary:
//
//

// Change Log:
//
//

// Code:

#import "TDxCompanionRightClickAction.h"

#include <unistd.h>

@implementation TDxCompanionRightClickAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"rc";
}

+ (NSString *)commandDescription {
    return @"  rc:x,y  Will RIGHT-CLICK at the point with the given coordinates.\n"
    "          Example: “rc:12,34” will right-click at the point with x coordinate\n"
    "          12 and y coordinate 34. Instead of x and y values, you may\n"
    "          also use “.”, which means: the current position. Using “.” is\n"
    "          equivalent to using relative zero values “c:+0,+0”.";
}

#pragma mark - MouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Right-click at %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {
    // Right button down
    CGEventRef rightDown = CGEventCreateMouseEvent(NULL, kCGEventRightMouseDown, p, kCGMouseButtonRight);
    CGEventPost(kCGHIDEventTap, rightDown);
    CFRelease(rightDown);

    usleep(15000); // Improve reliability

    // Right button up
    CGEventRef rightUp = CGEventCreateMouseEvent(NULL, kCGEventRightMouseUp, p, kCGMouseButtonRight);
    CGEventPost(kCGHIDEventTap, rightUp);
    CFRelease(rightUp);
}

@end

//
// TDxCompanionRightClickAction.m ends here
