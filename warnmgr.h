#ifndef WARNMGR_H
#define WARNMGR_H

#include <QObject>

class WarnMgr : public QObject
{
    Q_OBJECT

public:
    explicit WarnMgr(QObject *parent = nullptr);
    /* to be called from QML */
    Q_INVOKABLE void seatbeltWarningClicked();
    Q_INVOKABLE void doorsOpentWarningClicked();

signals:
    void seatbeltWarningChanged(bool state);
    void doorsOpenWarningChanged(bool state);

private:
    bool m_seatbeltWarning=false;
    bool m_doorsOpenWarning=false;
};

#endif // WARNMGR_H
