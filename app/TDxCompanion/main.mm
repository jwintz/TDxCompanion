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

#include <QtCore>
#include <QtGui>
#include <QtWidgets>
#include <QtWidgets/QMacNativeWidget>

// /////////////////////////////////////////////////////////////////////////////
//
// /////////////////////////////////////////////////////////////////////////////

#include "TDxCompanionWindow.h"

// /////////////////////////////////////////////////////////////////////////////

#import <AppKit/AppKit.h>

// /////////////////////////////////////////////////////////////////////////////
//
// /////////////////////////////////////////////////////////////////////////////

int main(int argc, char **argv)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    Q_INIT_RESOURCE(main);

    QApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);

    QApplication application(argc, argv);
    application.setApplicationName("TDxCompanion");
    application.setOrganizationName("jwintz");
    application.setOrganizationDomain("me");
    application.setQuitOnLastWindowClosed(false);

    TDxCompanionWindow window;
    window.show();

    int status = application.exec();

    [pool release];

    return status;
}

// 
// main.cpp ends here
