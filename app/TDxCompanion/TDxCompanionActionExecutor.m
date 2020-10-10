#import "TDxCompanionActionExecutor.h"

#include "TDxCompanionActionClassesMacro.h"
#include "TDxCompanionExecutionOptions.h"

@implementation TDxCompanionActionExecutor

+ (void)executeActions:(NSArray *)actions
           withOptions:(struct TDxCompanionExecutionOptions)options {

    NSDictionary *shortcuts = [self shortcuts];

    struct timespec waitingtime;
    waitingtime.tv_sec = 0;

    if (options.waitTime < 100) {
        options.waitTime = 100;
    }

    if (options.waitTime > 999) {
        waitingtime.tv_sec = (int)floor(options.waitTime / 1000);
        waitingtime.tv_nsec = (options.waitTime - waitingtime.tv_sec * 1000) * 1000000;
    } else {
        waitingtime.tv_sec = 0;
        waitingtime.tv_nsec = options.waitTime * 1000000;
    }

    NSUInteger i, count = [actions count];
    for (i = 0; i < count; i++) {
        NSArray *action = [[actions objectAtIndex:i] componentsSeparatedByString:@":"];
        Class actionClass = [shortcuts objectForKey:[action objectAtIndex:0]];
        if (nil == actionClass) {
            if ([[action objectAtIndex:0] isEqualToString:[actions objectAtIndex:i]]) {
                [NSException raise:@"InvalidCommandException"
                            format:@"Unrecognized action shortcut “%@”", [action objectAtIndex:0]];
            } else {
                [NSException raise:@"InvalidCommandException"
                            format:@"Unrecognized action shortcut “%@” in “%@”", [action objectAtIndex:0], [actions objectAtIndex:i]];
            }
        }

        id actionClassInstance = [[actionClass alloc] init];

        if (![actionClassInstance conformsToProtocol:@protocol(TDxCompanionActionProtocol)]) {
            [NSException raise:@"InvalidCommandException"
                        format:@"%@ does not conform to ActionProtocol", actionClass];
        }

        options.isFirstAction = i == 0;
        options.isLastAction = i == count - 1;

        if ([action count] > 1) {
            [actionClassInstance performActionWithData:[[action subarrayWithRange:NSMakeRange(1, [action count] - 1)] componentsJoinedByString:@":"]
                                           withOptions:options];
        } else {
            [actionClassInstance performActionWithData:@""
                                           withOptions:options];
        }

        [actionClassInstance release];

        if (!options.isLastAction) {
            nanosleep(&waitingtime, NULL);
        }
    }
}

+ (NSArray *)actionClasses {
    NSArray *actionClasses = [NSArray arrayWithObjects:ACTION_CLASSES];
    return actionClasses;
}

+ (NSDictionary *)shortcuts {

    NSArray *actionClasses = [[self class] actionClasses];
    NSMutableDictionary *shortcuts = [NSMutableDictionary dictionaryWithCapacity:[actionClasses count]];
    NSUInteger i, ii;

    for (i = 0, ii = [actionClasses count]; i < ii; i++) {
        NSString *classname = [actionClasses objectAtIndex:i];
        Class actionClass = NSClassFromString(classname);
        NSString *shortcut = [actionClass commandShortcut];
        if (nil != [shortcuts objectForKey:shortcut]) {
            [NSException raise:@"ShortcutConflictException"
                        format:@"Shortcut “%@” is used by more than one action class", shortcut];
        }
        [shortcuts setObject:actionClass forKey:shortcut];
    }

    return [[shortcuts retain] autorelease];
}

@end
