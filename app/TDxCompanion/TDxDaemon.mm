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

#include "TDxDaemon.h"

// /////////////////////////////////////////////////////////////////////////////

#import "TDxCompanionActionExecutor.h"

// /////////////////////////////////////////////////////////////////////////////
// macOS driver backend                                     // TODO: To be split
// /////////////////////////////////////////////////////////////////////////////

#if defined (Q_OS_MAC)

#include <ConnexionClientAPI.h>

#endif

// ///////////////////////////////////////////////////////////////////
// TDxDaemonPrivate
// ///////////////////////////////////////////////////////////////////

class TDxDaemonPrivate
{
public:
    static TDxDaemonPrivate *self;

#if defined(Q_OS_MAC)
public:
    static void added(unsigned int id)
    {
        Q_UNUSED(id);
    }

    static void removed(unsigned int id)
    {
        Q_UNUSED(id);
    }

    static void message(unsigned int id, unsigned int type, void *data)
    {
        static double sensivity = 0.1;

        ConnexionDeviceState *state = NULL;

        double t_x = 0.0;
        double t_y = 0.0;
        double t_z = 0.0;
        double r_x = 0.0;
        double r_y = 0.0;
        double r_z = 0.0;

        switch (type) {
        case kConnexionMsgDeviceState:
            state = static_cast<ConnexionDeviceState *>(data);
            switch (state->command) {
            case kConnexionCmdHandleAxis:
                t_x = +1.0 * state->axis[0] * sensivity;
                t_y = -1.0 * state->axis[1] * sensivity;
                t_z = -1.0 * state->axis[2] * sensivity;
                r_x = +1.0 * state->axis[3] * sensivity * 1.0 / 8.0;
                r_y = -1.0 * state->axis[4] * sensivity * 1.0 / 8.0;
                r_z = -1.0 * state->axis[5] * sensivity * 1.0 / 8.0;

                self->position = QVector3D(t_x, t_y, t_z);
                self->orientation = QQuaternion::fromEulerAngles(r_x, r_y, r_z);

                qDebug() << Q_FUNC_INFO << "Axis handler" << self->position << self->orientation;

                break;

            case kConnexionCmdHandleButtons:
                qDebug() << Q_FUNC_INFO << "Button handler" << state->buttons;
                break;

            default:
                break;
        };
        default:
            break;
        };
    }
#endif

public:
      QVector3D position;
    QQuaternion orientation;

public:
    int status;

public:
    TDxCompanionActionExecutor *executor;
};

TDxDaemonPrivate *TDxDaemonPrivate::self = NULL;

// ///////////////////////////////////////////////////////////////////
// TDxDaemon
// ///////////////////////////////////////////////////////////////////

TDxDaemon::TDxDaemon(QObject *parent) : QObject(parent), d(new TDxDaemonPrivate)
{
    d->self = d;

    d->executor = [[TDxCompanionActionExecutor alloc] init];
}

TDxDaemon::~TDxDaemon(void)
{
    [d->executor dealloc];

    delete d;
}

int TDxDaemon::initialize(void)
{
#if defined(Q_OS_MAC)
    d->status = InstallConnexionHandlers(d->message, d->added, d->removed);
    ::RegisterConnexionClient(kConnexionClientWildcard, NULL, kConnexionClientModeTakeOver, kConnexionMaskAll);
#endif

    return d->status;
}

int TDxDaemon::uninitialize(void)
{
#if defined(Q_OS_MAC)
    ::CleanupConnexionHandlers();
#endif

    return d->status;
}

QVector3D TDxDaemon::position(void)
{
    return d->position;
}

bool TDxDaemon::initialized(void)
{
    return d->status;
}

QQuaternion TDxDaemon::orientation(void)
{
    return d->orientation;
}

//
// TDxDaemon.cpp ends here
