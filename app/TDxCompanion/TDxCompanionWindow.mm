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

#include <QtQuick>

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

public:
    bool triggered = false;

public:
    QObject *root = nullptr;
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

    QQuickView *view = new QQuickView;
    view->engine()->addImportPath("qrc:/");
    view->setSource(QUrl("qrc:/PieMenuControlView.qml"));

    d->root = view->rootObject();

    QWidget *container = QWidget::createWindowContainer(view);
    container->setMinimumSize(QSize(400, 150));
    container->setMaximumSize(QSize(400, 150));

    QVBoxLayout *s_layout = new QVBoxLayout;
    s_layout->addWidget(d->button_start);
    s_layout->addWidget(d->button_stop);
    s_layout->addStretch();

    QHBoxLayout *t_layout = new QHBoxLayout;
    t_layout->setContentsMargins(20, 20, 20, 20);
    t_layout->addWidget(d->status);
    t_layout->addLayout(s_layout);

    QVBoxLayout *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->setSpacing(0);
    layout->addLayout(t_layout);
    layout->addWidget(container);

    d->menu = new QMenu(this);
    d->menu->addAction(restoreAction);
    d->menu->addSeparator();
    d->menu->addAction(quitAction);

    d->icon = new QSystemTrayIcon(this);
    d->icon->setContextMenu(d->menu);
    d->icon->setIcon(QIcon(":/TDxCompanion-dark.png"));
    d->icon->show();

    this->setWindowTitle(tr("TDxCompanionWindow"));
    this->resize(400, 200);

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

    connect(d->daemon, &TDxDaemon::clicked, [=] (bool button_1, bool button_2)
    {
        if(button_2)
            d->triggered = !d->triggered;

        d->root->setProperty("triggered", d->triggered);
    });
}

TDxCompanionWindow::~TDxCompanionWindow(void)
{
    this->stop();

    delete d;
}

void TDxCompanionWindow::setVisible(bool visible)
{
    QDialog::setVisible(visible);
}

void TDxCompanionWindow::start(void)
{
    if(!d->daemon->initialize())
        d->status->setPixmap(QPixmap(":/TDxCompanion-on.png"));

    d->root->setProperty("triggered", false);

    // qDebug() << Q_FUNC_INFO << d->daemon->initialized();
}

void TDxCompanionWindow::stop(void)
{
    if(!d->daemon->uninitialize())
        d->status->setPixmap(QPixmap(":/TDxCompanion-off.png"));

    d->root->setProperty("triggered", false);

    // qDebug() << Q_FUNC_INFO << d->daemon->initialized();
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
