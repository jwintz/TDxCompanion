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

#import "TDxCompanionKeyDownAction.h"

@implementation TDxCompanionKeyDownAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"kd";
}

+ (NSString *)commandDescription {
    NSString *keyList = [[self class] getSupportedKeysIndentedWith:@"            - "];
    NSString *format = @"  kd:keys Will trigger a KEY DOWN event for a comma-separated list of\n"
    "          modifier keys. Possible keys are:\n%@\n"
    "          Example: “kd:cmd,alt” will press the command key and the\n"
    "          option key (and will keep them down until you release them\n"
    "          with another command)";
    return [NSString stringWithFormat:format, keyList];
}

#pragma mark - KeyBaseAction

- (void)performActionWithKeycode:(CGKeyCode)code {
    CGEventRef e = CGEventCreateKeyboardEvent(NULL, code, true);
    CGEventPost(kCGSessionEventTap, e);
    CFRelease(e);
}

- (NSString *)actionDescriptionString:(NSString *)keyName {
    return [NSString stringWithFormat:@"Hold %@ key down", keyName];
}

@end

//
// TDxCompanionKeyDownAction.m ends here
