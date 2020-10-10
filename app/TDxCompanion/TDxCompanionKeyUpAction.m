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

#import "TDxCompanionKeyUpAction.h"

@implementation TDxCompanionKeyUpAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"ku";
}

+ (NSString *)commandDescription {
    NSString *keyList = [[self class] getSupportedKeysIndentedWith:@"            - "];
    NSString *format = @"  ku:keys Will trigger a KEY UP event for a comma-separated list of\n"
                        "          modifier keys. Possible keys are:\n%@\n"
                        "          Example: “ku:cmd,ctrl” will release the command key and the\n"
                        "          control key (which will only have an effect if you performed\n"
                        "          a “key down” before)";
    return [NSString stringWithFormat:format, keyList];
}

#pragma mark - TDxCompanionKeyBaseAction

- (void)performActionWithKeycode:(CGKeyCode)code {
    CGEventRef e = CGEventCreateKeyboardEvent(NULL, code, false);
    CGEventPost(kCGSessionEventTap, e);
    CFRelease(e);
}

- (NSString *)actionDescriptionString:(NSString *)keyName {
    return [NSString stringWithFormat:@"Release %@ key", keyName];
}

@end

//
// TDxCompanionKeyUpAction.m ends here
