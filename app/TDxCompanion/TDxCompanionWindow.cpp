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
#include "TDxCompanionWindow.h"

// /////////////////////////////////////////////////////////////////////////////
//
// /////////////////////////////////////////////////////////////////////////////

class TDxCompanionWindowPrivate
{
public:
    QSystemTrayIcon *icon;
    QMenu *menu;

public:
    QLabel *status;

public:
    QPushButton *button_start;
    QPushButton *button_stop;

public:
    TDxDaemon *daemon;
};

// /////////////////////////////////////////////////////////////////////////////
//
// /////////////////////////////////////////////////////////////////////////////

TDxCompanionWindow::TDxCompanionWindow(QWidget *parent) : QDialog(parent)
{
    d = new TDxCompanionWindowPrivate;

    d->daemon = new TDxDaemon(this);

    QAction *restoreAction = new QAction(tr("&Restore"), this);
    QAction *quitAction = new QAction(tr("&Quit"), this);

    d->status = new QLabel(this);
    d->status->setPixmap(QPixmap(":/TDxCompanion-off.png"));

    d->button_start = new QPushButton("Start Deamon", this);
    d->button_stop  = new QPushButton("Stop Deamon", this);

    QHBoxLayout *s_layout = new QHBoxLayout;
    s_layout->addWidget(d->button_start);
    s_layout->addWidget(d->button_stop);

    QVBoxLayout *layout = new QVBoxLayout(this);
    layout->addWidget(d->status);
    layout->addLayout(s_layout);

    d->menu = new QMenu(this);
    d->menu->addAction(restoreAction);
    d->menu->addSeparator();
    d->menu->addAction(quitAction);

    d->icon = new QSystemTrayIcon(this);
    d->icon->setContextMenu(d->menu);
    d->icon->setIcon(QIcon(":/TDxCompanion-dark.png"));
    d->icon->show();

    this->setWindowTitle(tr("TDxCompanionWindow"));
    this->resize(400, 300);

    connect(d->button_start, SIGNAL(clicked()), this, SLOT(start()));
    connect(d->button_stop,  SIGNAL(clicked()), this, SLOT(stop()));

    connect(restoreAction, &QAction::triggered, [=] (void)
    {
        this->show();
        this->raise();
    });
   
    connect(quitAction, &QAction::triggered, [=] (void)
    {
        d->daemon->uninitialize();
        qApp->quit();
    });
}

TDxCompanionWindow::~TDxCompanionWindow(void)
{
    delete d;
}

void TDxCompanionWindow::setVisible(bool visible)
{
    QDialog::setVisible(visible);
}

void TDxCompanionWindow::start(void)
{
    if(!d->daemon->initialize()) {
        d->status->setPixmap(QPixmap(":/TDxCompanion-on.png"));
    }

    qDebug() << Q_FUNC_INFO << d->daemon->initialized();
}

void TDxCompanionWindow::stop(void)
{
    if(!d->daemon->uninitialize()) {
        d->status->setPixmap(QPixmap(":/TDxCompanion-off.png"));
    }

    qDebug() << Q_FUNC_INFO << d->daemon->initialized();
}

void TDxCompanionWindow::closeEvent(QCloseEvent *event)
{
    if (!event->spontaneous() || !this->isVisible()) {
        return;
    }

    if(d->icon->isVisible()) {
        this->hide();
        event->ignore();
    }
}

//
// TDxCompanionWindow.mm ends here
