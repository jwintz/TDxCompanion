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

#import <Cocoa/Cocoa.h>

#import "TDxCompanionActionProtocol.h"

@interface TDxCompanionWaitAction : NSObject <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options;

@end

//
// TDxCompanionWaitAction.h ends here
