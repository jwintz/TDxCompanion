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

#include <QtWidgets>

class TDxCompanionWindowPrivate;

class TDxCompanionWindow : public QDialog
{
    Q_OBJECT

public:
     TDxCompanionWindow(QWidget *parent = nullptr);
    ~TDxCompanionWindow(void);

public:
    void setVisible(bool visible) override;

public slots:
    void start(void);
    void stop(void);

protected:
    void closeEvent(QCloseEvent *event) override;

private:
    TDxCompanionWindowPrivate *d;
};

//
// TDxCompanionWindow.h ends here
