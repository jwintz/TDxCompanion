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
#import "TDxCompanionWaitAction.h"

@implementation TDxCompanionWaitAction

#pragma mark - TDxCompanionActionProtocol

+ (NSString *)commandShortcut {
    return @"w";
}

+ (NSString *)commandDescription {
    return @"  w:ms    Will WAIT/PAUSE for the given number of milliseconds.\n"
    "          Example: “w:500” will pause command execution for half a second";
}

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options {

    unsigned milliseconds = abs([data intValue]);
    NSString *shortcut = [[self class] commandShortcut];

    if ([data isEqualToString:@""] ||
        !milliseconds) {
        [NSException raise:@"InvalidCommandException"
                    format:@"Invalid or missing argument to command “%@”: Expected number of milliseconds. Example: “%@:50”", shortcut, shortcut];
    }

    if (MODE_REGULAR != options.mode) {
        [options.verbosityOutputHandler write:[NSString stringWithFormat:@"Wait %i milliseconds", milliseconds]];
    }

    if (MODE_TEST == options.mode) {
        return;
    }

    struct timespec waitingtime;
    if (milliseconds > 999) {
        waitingtime.tv_sec = (int)floor(milliseconds / 1000);
        waitingtime.tv_nsec = (milliseconds - waitingtime.tv_sec * 1000) * 1000000;
    } else {
        waitingtime.tv_sec = 0;
        waitingtime.tv_nsec = milliseconds * 1000000;
    }

    nanosleep(&waitingtime, NULL);
}

@end

//
// TDxCompanionWaitAction.m ends here
