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

#import <Foundation/Foundation.h>

@interface TDxCompanionOutputHandler : NSObject {
    NSString *outputTarget;
}

- (id)initWithTarget:(NSString *)target;

- (void)write:(NSString *)message;

@end

//
// TDxCompanionOutputHandler.h ends here
