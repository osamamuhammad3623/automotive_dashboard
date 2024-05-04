import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 640
    height: 550
    visible: true
    title: qsTr("Dashboard")

    Slider{
        id: slider
        width: 300
        x: root.width/2 - width/2
        y: root.height*0.95
        from:0
        to: 250
    }

    Speedometer{
        id: speedometer
        anchors.centerIn: parent
        currentAngle: slider.value
    }

    /* this button is all implemented in QML */
    Button{
        id: engineOffBtn
        x:root.width/2 + slider.width/2 + 20
        y: root.height*0.95
        text: "Turn off Engine"
        onClicked: {
            speedometer.engineTurnedOff()
        }
    }


    /* this warning logic is implemented in C++ */
    /*
        QML button calls a C++ function/slot to notify backend that warning btn is pressed
        c++ backend emits a signal to notify QML to turn on/off the warning
    */
    Button{
        id: enableSeatbeltWarning
        x:root.width/2 - slider.width/2 - width - 25
        y: root.height*0.95
        text: "Switch seatbelt warning"
        onClicked: {
            /*QML calls C++*/
            warnMgr.seatbeltWarningClicked()
        }
    }

    Connections{
        target:warnMgr
        /*C++ calls QML (signal/slot concept)*/
        function onSeatbeltWarningChanged(warnState) {
            speedometer.changeSeatbeltWarning(warnState)
        }
    }

}


