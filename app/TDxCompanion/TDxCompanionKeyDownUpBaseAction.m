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

#import "TDxCompanionKeyDownUpBaseAction.h"

@implementation TDxCompanionKeyDownUpBaseAction

#pragma mark - TDxCompanionKeyBaseAction

+ (NSDictionary *)getSupportedKeycodes {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"59", @"ctrl",
            @"55", @"cmd",
            @"58", @"alt",
            @"56", @"shift",
            @"63", @"fn",
            nil];
}

@end

//
// TDxCompanionKeyDownUpBaseAction.m ends here
