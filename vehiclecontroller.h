#ifndef VEHICLECONTROLLER_H
#define VEHICLECONTROLLER_H

#include <QObject>

class VehicleController : public QObject
{
    Q_OBJECT
public:
    VehicleController();
    /* to be called from QML */
    Q_INVOKABLE void vehModeChangedUi(QString newMode);
    Q_INVOKABLE void vehTempChangedUi(int newTemp);

signals:
    void vehModeChanged(QString newMode);
    void vehTempChanged(int newTemp);

private:
    QString m_vehMode="P";
    int m_vehTemp=32;
};

#endif // VEHICLECONTROLLER_H
