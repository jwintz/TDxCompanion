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

#import "TDxCompanionMouseBaseAction.h"
#import "TDxCompanionActionProtocol.h"

@interface TDxCompanionMoveAction : TDxCompanionMouseBaseAction <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

+ (NSString *)commandDescription;

- (NSString *)actionDescriptionString:(NSString *)locationDescription;

- (void)performActionAtPoint:(CGPoint) p;

@end

//
// TDxCompanionMoveAction.h ends here
