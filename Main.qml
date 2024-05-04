import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 800
    height: 600
    visible: true
    title: qsTr("Dashboard")

    Slider{
        id: slider
        width: 300
        from:0
        to: 250

        anchors{
            horizontalCenter: speedometer.horizontalCenter
        }
        y: 0.9*parent.height

    }

    Speedometer{
        id: speedometer
        currentAngle: slider.value

        anchors{
            left: controlColumn.right
            verticalCenter: parent.verticalCenter
        }
    }

    Column{
        id: controlColumn
        spacing: 10
        rightPadding: 80
        leftPadding: parent.width * 0.05
        anchors.verticalCenter: parent.verticalCenter

        /* this warning logic is implemented in C++ */
        /*
            QML button calls a C++ function to notify backend that warning btn is pressed
            c++ backend emits a signal to notify QML to turn on/off the warning
        */
        Button{
            id: enableSeatbeltWarning
            height: 30
            text: "Switch seatbelt warning"
            onClicked: {
                /*QML calls C++*/
                warnMgr.seatbeltWarningClicked()
            }
        }

        Button{
            id: enableDoorsOpenWarning
            height: 30
            text: "Switch doors-open warning"
            onClicked: {
                /*QML calls C++*/
                warnMgr.doorsOpentWarningClicked()
            }
        }


        /* this button is all implemented in QML [no logic in C++] */
        Button{
            id: engineOffBtn
            text: "Turn off Engine"
            height: 30
            onClicked: {
                speedometer.engineTurnedOff()
            }
        }
    }

    Connections{
        target:warnMgr
        /*C++ calls QML (signal/slot concept)*/

        function onSeatbeltWarningChanged(warnState) {
            speedometer.changeSeatbeltWarning(warnState)
        }

        function onDoorsOpenWarningChanged(warnState) {
            speedometer.changeDoorsOpenWarning(warnState)
        }
    }

}


