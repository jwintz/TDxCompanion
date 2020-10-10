#import <Cocoa/Cocoa.h>

#import "TDxCompanionActionProtocol.h"

typedef enum {
    XAXIS = 1,
    YAXIS = 2
} CLICLICKAXIS;

@interface TDxCompanionMouseBaseAction : NSObject {

}

/**
 * Takes an unparsed position string for a single axis and returns the corresponding position
 *
 * @param unparsedValue String in one of the supported formats, such as @@"934", @@"+17" or @@"=218"
 * @param axis The axis
 */
+ (int)getCoordinate:(NSString *)unparsedValue
             forAxis:(CLICLICKAXIS)axis;

/**
 * Checks if the given string is an acceptable X or Y coordinate value and throws an exception if not
 *
 * @param string String to test. See +getCoordinate:forAxis: for supported syntaxes
 * @param axis The axis
 */
+ (void)validateAxisValue:(NSString *)string
                  forAxis:(CLICLICKAXIS)axis;

/**
 * Returns a human-readable description of the action
 *
 * This should be a one-line string which will be used in “verbose” and in “test” mode.
 *
 * @param locationDescription A textual representation of the coordinates at which the action is performed.
 */
- (NSString *)actionDescriptionString:(NSString *)locationDescription;

/**
 * Performs the mouse-related action an inheriting command provides
 *
 * This method is called as last step of method performActionWithData:withOptions: It should only perform the action, not print a description when in MODE_VERBOSE mode, as this is done by performActionWithData:withOptions:
 *
 * @note This method will only be invoked when in MODE_REGULAR or MODE_VERBOSE mode.
 */
- (void)performActionAtPoint:(CGPoint)p;

/**
 * Performs the action
 *
 * Depending on the mode argument, this can be the action, printing a description of the action to STDOUT or both. This implementation performs the preparatory steps such as validating arguments, calculating the mouse position etc., but leaves performing the action to subclasses, whose performActionAtPoint: method it eventually invokes.
 *
 * @param data Part of the argument remaining after stripping the leading command identifier
 * @param options
 */
- (void)performActionWithData:(NSString *)data
                  withOptions:(struct TDxCompanionExecutionOptions)options;

- (void)postHumanizedMouseEventsWithEasingFactor:(unsigned)easing
                                             toX:(float)endX
                                             toY:(float)endY;

- (uint32_t)getMoveEventConstant;

@end
