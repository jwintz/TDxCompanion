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

#import "TDxCompanionDragDownAction.h"

@implementation TDxCompanionDragDownAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"dd";
}

+ (NSString *)commandDescription {
    return @"  dd:x,y  Will press down to START A DRAG at the given coordinates.\n"
    "          Example: “dd:12,34” will press down at the point with x\n"
    "          coordinate 12 and y coordinate 34. Instead of x and y values,\n"
    "          you may also use “.”, which means: the current position.";
}

#pragma mark - MouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Drag press down at %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {
    // Left button down, but don't release
    CGEventRef leftDown = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, p, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, leftDown);
    CFRelease(leftDown);
}

@end

//
// TDxCompanionDragDownAction.m ends here
