
#import <Cocoa/Cocoa.h>

#import "TDxCompanionActionProtocol.h"

@interface TDxCompanionColorPickerAction : NSObject <TDxCompanionActionProtocol> {

}

+ (NSString *)commandShortcut;

+ (NSString *)commandDescription;

- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options;

@end
