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

#import "TDxCompanionTripleclickAction.h"

#include <unistd.h>

@implementation TDxCompanionTripleclickAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"tc";
}

+ (NSString *)commandDescription {
    return @"  tc:x,y  Will TRIPLE-CLICK at the point with the given coordinates.\n"
    "          Example: “tc:12,34” will triple-click at the point with x\n"
    "          coordinate 12 and y coordinate 34. Instead of x and y values,\n"
    "          you may also use “.”, which means: the current position.\n"
    "          Note: If you find that this does not work in a target application,\n"
    "          please try if double-clicking plus single-clicking does.";
}

#pragma mark - MouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Triple-click at %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {

    // Left button down
    CGEventRef mouseEvent = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, p, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    // Left button up
    CGEventSetType(mouseEvent, kCGEventLeftMouseUp);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    usleep(200000); // Improve reliability

    // 2nd/3rd click
    CGEventSetIntegerValueField(mouseEvent, kCGMouseEventClickState, 3);

    CGEventSetType(mouseEvent, kCGEventLeftMouseDown);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    CGEventSetType(mouseEvent, kCGEventLeftMouseUp);
    CGEventPost(kCGHIDEventTap, mouseEvent);

    CFRelease(mouseEvent);
}

@end

//
// TDxCompanionTripleclickAction.m ends here
