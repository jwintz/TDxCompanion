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

#import "TDxCompanionMoveAction.h"

@implementation TDxCompanionMoveAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"m";
}

+ (NSString *)commandDescription {
    return @"  m:x,y   Will MOVE the mouse to the point with the given coordinates.\n"
    "          Example: “m:12,34” will move the mouse to the point with\n"
    "          x coordinate 12 and y coordinate 34.";
}

#pragma mark - TDxCompanionMouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Move to %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {
    // Simply does nothing. Moving is done by the parent.
}

@end

//
// TDxCompanionMoveAction.m ends here
