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

#import "TDxCompanionKeyBaseAction.h"
#import "TDxCompanionExecutionOptions.h"

@implementation TDxCompanionKeyBaseAction

+ (NSDictionary *)getSupportedKeycodes {
    [NSException raise:@"InvalidCommandException"
                format:@"To be implemented by subclasses"];
    return [NSDictionary dictionaryWithObject:@"Will never be reached, but makes Xcode happy" forKey:@"Foo"];
}

+ (NSString *)getSupportedKeysIndentedWith:(NSString *)indent {

    NSArray *sortedkeyNames = [[[[self class] getSupportedKeycodes] allKeys] sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];

    return [NSString stringWithFormat:@"%@%@", indent, [sortedkeyNames componentsJoinedByString:[@"\n" stringByAppendingString:indent]]];
}

- (NSString *)actionDescriptionString:(NSString *)keyName {
    [NSException raise:@"InvalidCommandException"
                format:@"To be implemented by subclasses"];
    return @"Will never be reached, but makes Xcode happy";
}

- (void)performActionWithKeycode:(CGKeyCode)code {
    [NSException raise:@"InvalidCommandException"
                format:@"To be implemented by subclasses"];
}

#pragma mark - ActionProtocol

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options {

    NSString *shortcut = [[self class] commandShortcut];

    // Wait before executing the key event(s). If this is the very first action, use a longer
    // delay (as it could be observed that an initial keyboard was swallowed, cf. issue #39),
    // otherwise only a short delay.
    struct timespec waitingtime;
    waitingtime.tv_sec = 0;
    waitingtime.tv_nsec = (options.isFirstAction ? 65 : 20) * 1000000; // Milliseconds
    nanosleep(&waitingtime, NULL);

    if ([data isEqualToString:@""]) {
        [NSException raise:@"InvalidCommandException"
                    format:@"Missing argument to command “%@”: Expected one or more keys (separated by a comma). Examples: “%@:ctrl” or “%@:cmd,alt”",
         shortcut, shortcut, shortcut];
    }

    NSDictionary *keycodes = [[self class] getSupportedKeycodes];
    NSArray *keys = [data componentsSeparatedByString:@","];
    NSUInteger i, count = [keys count];

    // First, validate the key names
    for (i = 0; i < count; i++) {
        NSObject *keyname = [keys objectAtIndex:i];
        if (![keycodes objectForKey:keyname]) {
            [NSException raise:@"InvalidCommandException"
                        format:@"Invalid key “%@” given as argument to command “%@”.\nThe key name may only be one of:\n%@",
                               keyname, shortcut, [[self class] getSupportedKeysIndentedWith:@"  - "]];
        }
    }

    // Then, perform whatever action is requested
    for (i = 0; i < count; i++) {
        unsigned code = [[keycodes objectForKey:[keys objectAtIndex:i]] intValue];

        if (i > 0) {
            // If non-first key, wait a little, as otherwise, the event will be swallowed
            waitingtime.tv_sec = 0;
            waitingtime.tv_nsec = 20 * 1000000; // Milliseconds
            nanosleep(&waitingtime, NULL);
        }
    }
}

@end

//
// TDxCompanionKeyBaseAction.m ends here
