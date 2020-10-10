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

#import "TDxCompanionColorPickerAction.h"
#import "TDxCompanionMouseBaseAction.h"

@implementation TDxCompanionColorPickerAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"cp";
}

+ (NSString *)commandDescription {
    return @"  cp:str  Will PRINT THE COLOR value at the given screen location.\n"
    "          The color value is printed as three decimal 8-bit values,\n"
    "          representing, in order, red, green, and blue.\n"
    "          Example: “cp:123,456” might print “127 63 0”";
}

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options {

    NSString *shortcut = [[self class] commandShortcut];

    if ([data isEqualToString:@""]) {
        [NSException raise:@"InvalidCommandException"
                    format:@"Missing argument to command “%@”: Expected two coordinates (separated by a comma) or “.”. Example: “%@:123,456” or “%@:.”",
                           shortcut, shortcut, shortcut];
    } else {
        NSArray *coords;

        if ([data isEqualToString:@"."]) {
            coords = [NSArray arrayWithObjects: @"+0", @"+0", nil];
        } else {
            coords = [data componentsSeparatedByString:@","];

            if ([coords count] != 2 ||
                [[coords objectAtIndex:0] isEqualToString:@""] ||
                [[coords objectAtIndex:1] isEqualToString:@""])
            {
                [NSException raise:@"InvalidCommandException"
                            format:@"Invalid argument “%@” to command “%@”: Expected two coordinates (separated by a comma) or “.”. Example: “%@:123,456” or “%@:.”",
                                   data, shortcut, shortcut, shortcut];
            }
        }

        CGPoint p;
        p.x = [TDxCompanionMouseBaseAction getCoordinate:[coords objectAtIndex:0] forAxis:XAXIS];
        p.y = [TDxCompanionMouseBaseAction getCoordinate:[coords objectAtIndex:1] forAxis:YAXIS];

        CGRect imageRect = CGRectMake(p.x, p.y, 1, 1);
        CGImageRef imageRef = CGWindowListCreateImage(imageRect, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
        NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithCGImage:imageRef];
        CGImageRelease(imageRef);
        NSColor *color = [bitmap colorAtX:0 y:0];
        [bitmap release];

        [options.commandOutputHandler write:[NSString stringWithFormat:@"%d %d %d\n", (int)(color.redComponent*255), (int)(color.greenComponent*255), (int)(color.blueComponent*255)]];
    }
}

@end

//
// TDxCompanionColorPickerAction.m ends here
