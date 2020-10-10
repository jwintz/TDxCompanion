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

@interface TDxCompanionRightClickAction : TDxCompanionMouseBaseAction <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

+ (NSString *)commandDescription;

- (NSString *)actionDescriptionString:(NSString *)locationDescription;

- (void)performActionAtPoint:(CGPoint) p;

@end

//
// TDxCompanionRightClickAction.h ends here
