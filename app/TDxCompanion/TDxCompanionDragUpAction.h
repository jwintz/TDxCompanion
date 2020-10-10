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

@interface TDxCompanionDragUpAction : TDxCompanionMouseBaseAction <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

+ (NSString *)commandDescription;

- (NSString *)actionDescriptionString:(NSString *)locationDescription;

- (void)performActionAtPoint:(CGPoint) p;

@end

//
// TDxCompanionDragUpAction.h ends here
