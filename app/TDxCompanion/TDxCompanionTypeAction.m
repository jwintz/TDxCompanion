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

#import "TDxCompanionConfig.h"
#import "TDxCompanionTypeAction.h"

@implementation TDxCompanionTypeAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"t";
}

+ (NSString *)commandDescription {
    return @"  t:text  Will TYPE the given TEXT into the frontmost application.\n"
            "          If the text includes space(s), it must be enclosed in quotes.\n"
            "          Example: “type:Test” will type “Test” \n"
            "          Example: “type:'Viele Grüße'” will type “Viele Grüße”";
}

#pragma mark - KeyBaseAction

- (void)performActionWithKeycode:(CGKeyCode)code {
    CGEventRef e1 = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)code, true);
    CGEventPost(kCGSessionEventTap, e1);
    CFRelease(e1);

    CGEventRef e2 = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)code, false);
    CGEventPost(kCGSessionEventTap, e2);
    CFRelease(e2);
}

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options {

    struct timespec waitingtime;
    waitingtime.tv_sec = 0;
    waitingtime.tv_nsec = 10 * 1000000; // Milliseconds

    NSString *shortcut = [[self class] commandShortcut];

    if ([data isEqualToString:@""]) {
        [NSException raise:@"InvalidCommandException"
                    format:@"Missing argument to command “%@”: Expected a string. Examples: “%@:Hello” or “%@:'Hello world'”",
         shortcut, shortcut, shortcut];
    }

    // Generate the key code mapping
    TDxCompanionKeycodeInformer *ki = [TDxCompanionKeycodeInformer sharedInstance];

    NSArray *keyCodeInfos = [ki keyCodesForString:data];

    NSUInteger j, jj;

    for (j = 0, jj = [keyCodeInfos count]; j < jj; ++j) {

        NSArray *keyCodeInfo = [keyCodeInfos objectAtIndex:j];

        CGKeyCode keyCode = [[keyCodeInfo objectAtIndex:0] intValue];

        if ([[keyCodeInfo objectAtIndex:1] intValue] & MODIFIER_SHIFT) {
            CGEventRef e = CGEventCreateKeyboardEvent(NULL, KEYCODE_SHIFT, true);
            CGEventPost(kCGSessionEventTap, e);
            CFRelease(e);
        }

        nanosleep(&waitingtime, NULL); // Note: the delay is not needed for all keys. Strange, but true.

        if ([[keyCodeInfo objectAtIndex:1] intValue] & MODIFIER_ALT) {
            CGEventRef e = CGEventCreateKeyboardEvent(NULL, KEYCODE_ALT, true);
            CGEventPost(kCGSessionEventTap, e);
            CFRelease(e);
        }

        nanosleep(&waitingtime, NULL);

        CGEventRef keyDownEvent = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)keyCode, true);
        CGEventPost(kCGSessionEventTap, keyDownEvent);
        CFRelease(keyDownEvent);

        CGEventRef keyUpEvent = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)keyCode, false);
        CGEventPost(kCGSessionEventTap, keyUpEvent);
        CFRelease(keyUpEvent);

        nanosleep(&waitingtime, NULL);

        if ([[keyCodeInfo objectAtIndex:1] intValue] & MODIFIER_ALT) {
            CGEventRef e = CGEventCreateKeyboardEvent(NULL, KEYCODE_ALT, false);
            CGEventPost(kCGSessionEventTap, e);
            CFRelease(e);
        }

        nanosleep(&waitingtime, NULL);

        if ([[keyCodeInfo objectAtIndex:1] intValue] & MODIFIER_SHIFT) {
            CGEventRef e = CGEventCreateKeyboardEvent(NULL, KEYCODE_SHIFT, false);
            CGEventPost(kCGSessionEventTap, e);
            CFRelease(e);
        }

        nanosleep(&waitingtime, NULL);
    }
}

@end

//
// TDxCompanionTypeAction.m ends here
