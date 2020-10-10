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

#pragma once

#define MODE_REGULAR 0
#define MODE_VERBOSE 1
#define MODE_TEST 2

#define MODIFIER_SHIFT 32
#define MODIFIER_ALT 64
#define MODIFIER_SHIFT_ALT (MODIFIER_SHIFT | MODIFIER_ALT)
#define NSNUMBER_MODIFIER_SHIFT [NSNumber numberWithInt:MODIFIER_SHIFT]
#define NSNUMBER_MODIFIER_ALT [NSNumber numberWithInt:MODIFIER_ALT]
#define NSNUMBER_MODIFIER_SHIFT_ALT [NSNumber numberWithInt:MODIFIER_SHIFT_ALT]

#define KEYCODE_SHIFT 56
#define KEYCODE_ALT 58

//
// TDxCompanionConfig.h ends here
