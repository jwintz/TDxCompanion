
#import <Cocoa/Cocoa.h>

#import "TDxCompanionActionProtocol.h"
#import "TDxCompanionMouseBaseAction.h"

@interface TDxCompanionClickAction : TDxCompanionMouseBaseAction <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

+ (NSString *)commandDescription;

- (NSString *)actionDescriptionString:(NSString *)locationDescription;

- (void)performActionAtPoint:(CGPoint) p;

@end
