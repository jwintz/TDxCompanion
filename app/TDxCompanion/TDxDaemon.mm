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
#import "TDxCompanionConfig.h"
#import "TDxCompanionClickAction.h"
#import "TDxCompanionExecutionOptions.h"
#import "TDxCompanionMoveAction.h"

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
    static TDxDaemon        *part;
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

    static void axis_handler(double tx, double ty, double tz)
    {
        QPoint position = QCursor::pos();
        position += QPoint(tx, -ty);

        QScreen *screen = qApp->screens().at(0);

        if(position.x() < 0 || position.x() > screen->size().width())
            return;

        if(position.y() < 0 || position.y() > screen->size().height())
            return;

        struct TDxCompanionExecutionOptions options;
        options.easing = 0;
        options.waitTime = 0;
        options.mode = MODE_REGULAR;

        id moveAction = [[TDxCompanionMoveAction alloc] init];
        [moveAction performActionWithData:[NSString stringWithFormat:@"%d,%d", position.x(), position.y()] withOptions: options];
        [moveAction release];
    }

    static void button_handler(bool button_1)
    {
        if(!button_1)
            return;

        QPoint position = QCursor::pos();

        struct TDxCompanionExecutionOptions options;
        options.easing = 0;
        options.waitTime = 0;
        options.mode = MODE_REGULAR;

        id clickAction = [[TDxCompanionClickAction alloc] init];
        [clickAction performActionWithData:[NSString stringWithFormat:@"%d,%d", position.x(), position.y()] withOptions: options];
        [clickAction release];

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

                axis_handler(t_x, t_y, t_z);

                break;

            case kConnexionCmdHandleButtons:

                // qDebug() << Q_FUNC_INFO << "button handler";
                // qDebug() << Q_FUNC_INFO << "button handler (1)?" << (state->buttons & kConnexionMaskButton1);
                // qDebug() << Q_FUNC_INFO << "button handler (2)?" << (state->buttons & kConnexionMaskButton2);

                button_handler((state->buttons & kConnexionMaskButton1));

                emit(part->clicked((state->buttons & kConnexionMaskButton1), (state->buttons & kConnexionMaskButton2)));

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

TDxDaemon        *TDxDaemonPrivate::part = nullptr;
TDxDaemonPrivate *TDxDaemonPrivate::self = nullptr;

// ///////////////////////////////////////////////////////////////////
// TDxDaemon
// ///////////////////////////////////////////////////////////////////

TDxDaemon::TDxDaemon(QObject *parent) : QObject(parent), d(new TDxDaemonPrivate)
{
    d->part = this;
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
