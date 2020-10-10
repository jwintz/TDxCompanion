
#import "TDxCompanionClickAction.h"

#include <unistd.h>

@implementation TDxCompanionClickAction

#pragma mark - ActionProtocol

+ (NSString *)commandShortcut {
    return @"c";
}

+ (NSString *)commandDescription {
    return @"  c:x,y   Will CLICK at the point with the given coordinates.\n"
    "          Example: “c:12,34” will click at the point with x coordinate\n"
    "          12 and y coordinate 34. Instead of x and y values, you may\n"
    "          also use “.”, which means: the current position. Using “.” is\n"
    "          equivalent to using relative zero values “c:+0,+0”.";
}

#pragma mark - MouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Click at %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {
    // Left button down
    CGEventRef leftDown = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, p, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, leftDown);
    CFRelease(leftDown);

    usleep(15000); // Improve reliability

    // Left button up
    CGEventRef leftUp = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, p, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, leftUp);
    CFRelease(leftUp);
}

@end
