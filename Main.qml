import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 800
    height: 600
    maximumHeight: height
    minimumHeight: height
    maximumWidth: width
    minimumWidth: width

    visible: true
    title: qsTr("DevLeague Automotive Dashboard")
    color: "#293462"

    Slider{
        id: slider
        width: 300
        from:0
        to: 250

        onValueChanged: {
            speedometer.currentAngle= value
        }
        anchors{
            horizontalCenter: speedometer.horizontalCenter
        }
        y: 0.9*parent.height
    }

    Speedometer{
        id: speedometer

        anchors{
            left: controlColumn.right
            verticalCenter: parent.verticalCenter
        }
    }

    Column{
        id: controlColumn
        spacing: 10
        rightPadding: 80
        leftPadding: 20
        anchors.verticalCenter: parent.verticalCenter

        Text{
            text: "Vehicle Simulation"
            color: "white"
            font.pixelSize: 25
            bottomPadding: 10
        }

        /* this warning logic is implemented in C++ */
        /*
            QML button calls a C++ function to notify backend that warning btn is pressed
            c++ backend emits a signal to notify QML to turn on/off the warning
        */
        Button{
            height: 30
            width: 200
            font.pixelSize: 15
            text: "Switch seatbelt warning"
            onClicked: {
                /*QML calls C++*/
                warnMgr.seatbeltWarningClicked()
            }
        }

        Button{
            height: 30
            width: 200
            font.pixelSize: 15
            text: "Switch doors-open warning"
            onClicked: {
                /*QML calls C++*/
                warnMgr.doorsOpentWarningClicked()
            }
        }


        /* this button is all implemented in QML [no logic in C++] */
        Button{
            text: "Turn off Engine"
            height: 30
            width: 200
            font.pixelSize: 15
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


