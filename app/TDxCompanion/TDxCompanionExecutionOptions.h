
#import "TDxCompanionOutputHandler.h"

#pragma once

struct TDxCompanionExecutionOptions {
    unsigned mode;
    unsigned easing;
    unsigned waitTime;
    BOOL isFirstAction;
    BOOL isLastAction;
    TDxCompanionOutputHandler *verbosityOutputHandler;
    TDxCompanionOutputHandler *commandOutputHandler;
};
