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

#import "TDxCompanionOutputHandler.h"

struct TDxCompanionExecutionOptions {
    unsigned mode;
    unsigned easing;
    unsigned waitTime;
    BOOL isFirstAction;
    BOOL isLastAction;
    TDxCompanionOutputHandler *verbosityOutputHandler;
    TDxCompanionOutputHandler *commandOutputHandler;
};

//
// TDxCompanionExecutionOptions.h ends here
