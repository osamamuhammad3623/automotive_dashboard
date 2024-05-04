#include "warnmgr.h"

WarnMgr::WarnMgr(QObject *parent)
    : QObject{parent}
{}

void WarnMgr::seatbeltWarningClicked()
{
    /* some backend logic */
    m_seatbeltWarning = !m_seatbeltWarning;

    /* call a QML function/slot by emitting a signal */
    emit seatbeltWarningChanged(m_seatbeltWarning);
}

void WarnMgr::doorsOpentWarningClicked()
{
    /* some backend logic */
    m_doorsOpenWarning = !m_doorsOpenWarning;

    /* call a QML function/slot by emitting a signal */
    emit doorsOpenWarningChanged(m_doorsOpenWarning);
}
