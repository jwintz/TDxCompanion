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

#import "TDxCompanionDragUpAction.h"

#include <unistd.h>

@implementation TDxCompanionDragUpAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"du";
}

+ (NSString *)commandDescription {
    return @"  du:x,y  Will release to END A DRAG at the given coordinates.\n"
    "          Example: “du:112,134” will release at the point with x\n"
    "          coordinate 112 and y coordinate 134.";
}

#pragma mark - MouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Drag release at %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {
    // Left button up
    CGEventRef leftUp = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, p, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, leftUp);
    CFRelease(leftUp);
}

- (uint32_t)getMoveEventConstant {
    return kCGEventLeftMouseDragged;
}

@end

//
// TDxCompanionDragUpAction.m ends here
