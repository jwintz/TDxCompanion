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

#import "TDxCompanionDoubleclickAction.h"

#include <unistd.h>

@implementation TDxCompanionDoubleclickAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"dc";
}

+ (NSString *)commandDescription {
    return @"  dc:x,y  Will DOUBLE-CLICK at the point with the given coordinates.\n"
    "          Example: “dc:12,34” will double-click at the point with x\n"
    "          coordinate 12 and y coordinate 34. Instead of x and y values,\n"
    "          you may also use “.”, which means: the current position.";
}

#pragma mark - MouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Double-click at %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {

    // Left button down
    CGEventRef mouseEvent = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, p, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    // Left button up
    CGEventSetType(mouseEvent, kCGEventLeftMouseUp);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    usleep(200000); // Improve reliability

    // 2nd click
    CGEventSetIntegerValueField(mouseEvent, kCGMouseEventClickState, 2);

    CGEventSetType(mouseEvent, kCGEventLeftMouseDown);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    CGEventSetType(mouseEvent, kCGEventLeftMouseUp);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    CFRelease(mouseEvent);
}

@end

//
// TDxCompanionDoubleclickAction.m ends here
