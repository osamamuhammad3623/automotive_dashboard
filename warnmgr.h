#ifndef WARNMGR_H
#define WARNMGR_H

#include <QObject>

class WarnMgr : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool seatbeltWarning)

public:
    explicit WarnMgr(QObject *parent = nullptr);
    /* to be called from QML */
    Q_INVOKABLE void seatbeltWarningClicked();

signals:
    void seatbeltWarningChanged(bool state);

private:
    bool m_seatbeltWarning=false;
};

#endif // WARNMGR_H
