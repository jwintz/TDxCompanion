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
#import "TDxCompanionExecutionOptions.h"

@interface TDxCompanionKeyBaseAction : NSObject {

}

/**
 * Returns the keys that are supported by the command.
 *
 * @return An NSDictionary which has keyboard key name as dictionary keys and keyboard key codes (strings) as dictionary values.
 */
+ (NSDictionary *)getSupportedKeycodes;

/**
 * Returns the list of keys supported by the command
 *
 * @param indent String to use as indentation string at the beginning of each line
 *
 * @return Newline-separated string
 */
+ (NSString *)getSupportedKeysIndentedWith:(NSString *)indent;

/**
 * Returns a string describing the action performed be the command
 *
 * @param keyName Name of the key
 * @return Human-readable phrase such as @@"Press blahblah key"
 * @note This method must be overwritten by subclasses
 */
- (NSString *)actionDescriptionString:(NSString *)keyName;

/**
 * Performs the command's action
 *
 * @param code The key code
 *
 * @note This method must be overwritten by subclasses
 */
- (void)performActionWithKeycode:(CGKeyCode)code;

#pragma mark - ActionProtocol

/**
 * Performs the action
 *
 * Depending on the `mode` argument, this can be the action, printing a description of the action to STDOUT or both.
 *
 * @param data Part of the argument remaining after stripping the leading command identifier
 * @param options
 */
- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options;

@end

//
// TDxCompanionKeyBaseAction.h ends here
