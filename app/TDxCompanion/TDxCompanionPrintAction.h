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

@interface TDxCompanionPrintAction : NSObject <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

+ (NSString *)commandDescription;

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options;

@end

//
// TDxCompanionPrintAction.h ends here
