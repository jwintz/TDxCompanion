
#import <Foundation/Foundation.h>

#include <CoreFoundation/CoreFoundation.h>
#include <Carbon/Carbon.h>

@interface TDxCompanionKeycodeInformer : NSObject {
    NSMutableDictionary *map;
    TISInputSourceRef keyboard;
    CFDataRef keyLayoutData;
    const UCKeyboardLayout *keyboardLayout;
}

+ (id)sharedInstance;

- (NSArray *)keyCodesForString:(NSString *)string;

- (NSString *)stringForKeyCode:(CGKeyCode)keyCode andModifiers:(UInt32)modifiers;

- (NSString *)prepareString:(NSString *)string;

/**
 * Returns a map of characters which require typing two characters with the current keyboard layout
 *
 * @warning This method is incomplete. It not only supports only a few keyboard layout, but also lacks lots of characters even for the few supported keyboard layouts.
 * @return NSDictionary which has the characters as keys and a string containing the characters to be typed as values
 */
- (NSDictionary *)getReplacementMapForKeyboardLayoutNamed:(NSString *)layoutName;

@end
