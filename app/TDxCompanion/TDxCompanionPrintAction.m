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

#import "TDxCompanionPrintAction.h"

@implementation TDxCompanionPrintAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"p";
}

+ (NSString *)commandDescription {
    return @"  p[:str] Will PRINT the given string. If the string is “.”, the current\n"
    "          MOUSE POSITION is printed. As a convenience, you can skip the\n"
    "          string completely and just write “p” to get the current position.\n"
    "          Example: “p:.” or “p” will print the current mouse position\n"
    "          Example: “p:'Hello world'” will print “Hello world”";
}

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options {

    if ([data isEqualToString:@""] ||
        [data isEqualToString:@"."]) {


        CGEventRef ourEvent = CGEventCreate(NULL);
        CGPoint ourLoc = CGEventGetLocation(ourEvent);
        NSPoint point = NSPointFromCGPoint(ourLoc);
        [options.commandOutputHandler write:[NSString stringWithFormat: @"%.0f,%.0f", point.x, point.y]];
        CFRelease(ourEvent);

        return;
    }

    [options.commandOutputHandler write:data];
}

@end

//
// TDxCompanionPrintAction.m ends here
