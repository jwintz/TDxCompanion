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

#import "TDxCompanionActionProtocol.h"
#import "TDxCompanionExecutionOptions.h"

@interface TDxCompanionActionExecutor : NSObject {

}

+ (void)executeActions:(NSArray *)actions
           withOptions:(struct TDxCompanionExecutionOptions)options;

+ (NSDictionary *)shortcuts;

+ (NSArray *)actionClasses;

@end

//
// TDxCompanionActionExecutor.h ends here
