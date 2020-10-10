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

#import "TDxCompanionOutputHandler.h"

@implementation TDxCompanionOutputHandler

- (id)initWithTarget:(NSString *)target {
    self = [super init];

    if (self) {
        if (!target) {
            outputTarget = @"stdout";
        } else if ([target isEqualToString:@"stdout"] ||
                   [target isEqualToString:@"stderr"]) {
            outputTarget = target;
        } else if ([target isEqualToString:@"clipboard"]) {
            outputTarget = target;
        } else {
            NSFileManager *fm = [NSFileManager defaultManager];
            if ([fm fileExistsAtPath:target]) {
                if (![fm isWritableFileAtPath:target]) {
                    [NSException raise:@"InvalidDestinationException"
                                format:@"Cannot write to the file “%@” specified as output destination.", target];
                }
            } else {
                if (![fm createFileAtPath:target contents:nil attributes:nil]) {
                    [NSException raise:@"InvalidDestinationException"
                                format:@"Cannot create file “%@” specified as output destination.", target];
                }
            }
            outputTarget = target;
        }
    }
    return self;
}

- (void)write:(NSString *)message {
    if ([outputTarget isEqualToString:@"stdout"]) {
        printf("%s\n", [message UTF8String]);
        return;
    }

    if ([outputTarget isEqualToString:@"stderr"]) {
        fprintf(stderr, "%s\n", [message UTF8String]);
        return;
    }

    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:outputTarget];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[[message stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
}

@end

//
// TDxCompanionOutputHandler.m ends here
