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
#import "TDxCompanionMouseBaseAction.h"

@interface TDxCompanionTripleclickAction : TDxCompanionMouseBaseAction <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

- (NSString *)actionDescriptionString:(NSString *)locationDescription;

- (void)performActionAtPoint:(CGPoint) p;

@end

//
// TDxCompanionTripleclickAction.h ends here
