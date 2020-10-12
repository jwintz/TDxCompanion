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

#include <QtCore>
#include <QtGui>

class TDxDaemonPrivate;

class TDxDaemon : public QObject
{
    Q_OBJECT

public:
     TDxDaemon(QObject *parent);
    ~TDxDaemon(void);

signals:
    void clicked(bool, bool);

public:
    int   initialize(void);
    int uninitialize(void);

public:
    bool initialized(void);

public:
      QVector3D position(void);
    QQuaternion orientation(void);

private:
    TDxDaemonPrivate *d;
};

//
// TDxDaemon.h ends here
