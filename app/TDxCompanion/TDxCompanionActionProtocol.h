
#import <Cocoa/Cocoa.h>
#import "TDxCompanionExecutionOptions.h"

@protocol TDxCompanionActionProtocol

/**
 * Returns the command's shortcut
 *
 * The command shortcut is the string which has to be used as command-line argument (typically followed by “:” plus some arguments) to invoke the command.
 *
 * @note The command shortcut has to be unique for each command.
 * @return Command shortcut
 */
+ (NSString *)commandShortcut;

/**
 * Returns the command description
 *
 * The command description is to be included in the help output and is formatted (i.e.: indented). It should include a description as well as at least one usage example.
 *
 * @return Command description
 */
+ (NSString *)commandDescription;

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
