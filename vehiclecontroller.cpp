#include "vehiclecontroller.h"

VehicleController::VehicleController() {}

void VehicleController::vehModeChangedUi(QString newMode)
{
    m_vehMode = newMode;

    emit vehModeChanged(m_vehMode);
}

void VehicleController::vehTempChangedUi(int newTemp)
{
    m_vehTemp = newTemp;
    emit vehTempChanged(m_vehTemp);
}
