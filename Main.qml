import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 1600
    height: 900
    maximumHeight: height
    minimumHeight: height
    maximumWidth: width
    minimumWidth: width

    visible: true
    title: qsTr("DevLeague Automotive Dashboard")
    color: "#2f2f30"

    Rectangle {
        width: 1280
        height: 550
        color: "#23253e"
        border.color: "#57b9fc"
        border.width: 7
        radius: 221

        anchors{
            verticalCenter: parent.verticalCenter
            left: controlColumn.right
        }

        Speedometer{
            id: speedometer
            anchors{
                right: display.left
                rightMargin: 35
                verticalCenter: parent.verticalCenter
            }

        }

        Dashboard_Display{
            id: display
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

        }

        MotorRpm{
            id: motor_rpm
            anchors{
                left: display.right
                leftMargin: 35
                verticalCenter: parent.verticalCenter
            }
        }
    }

    Slider{
        id: slider
        width: 300
        from:0
        to: 250

        onValueChanged: {
            speedometer.currentAngle=value
            motor_rpm.currentAngle= value
        }
        anchors{
            horizontalCenter: parent.horizontalCenter
        }
        y: 0.9*root.height
    }


    Column{
        id: controlColumn
        spacing: 10
        rightPadding: 50
        leftPadding: 20
        anchors.verticalCenter: parent.verticalCenter

        Text{
            text: "Vehicle Simulation"
            color: "white"
            font.pixelSize: 25
            bottomPadding: 10
        }

        /* these warnings logic is implemented in C++ */
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


        /* these buttons are implemented in QML [no logic in C++] */
        Button{
            text: "Switch temperature warning"
            height: 30
            width: 200
            font.pixelSize: 15
            onClicked: {
                motor_rpm.switchHotTempWarning()
            }
        }

        Button{
            text: "Turn off Engine"
            height: 30
            width: 200
            font.pixelSize: 15
            onClicked: {
                speedometer.engineTurnedOff()
                motor_rpm.engineTurnedOff()
            }
        }

        /* this logic is implemented in C++ */
        Row{
            Text{
                id: modeText
                text: "Mode:"
                font.pixelSize: 15
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                rightPadding: 10
            }

            ComboBox{
                height: 30
                width: 200-modeText.width
                font.pixelSize: 15
                model: ["P", "D", "N", "R"]
                onCurrentTextChanged: {
                    vehController.vehModeChangedUi(currentText)
                }
            }
        }

        Row{
            Text{
                id: tempText
                text: "Temperature:"
                font.pixelSize: 15
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                rightPadding: 10
            }

            SpinBox{
                height: 30
                width: 200-tempText.width
                font.pixelSize: 15
                from: 0
                to:200
                value: 32

                onValueChanged: {
                    vehController.vehTempChangedUi(value)
                }
            }
        }

        /* any control option can be added (& connected to C++ backend), i.e. milage */
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

    Connections{
        target:vehController

        /*C++ calls QML (signal/slot concept)*/
        function onVehModeChanged(newMode) {
            display.changeVehMode(newMode)
        }

        function onVehTempChanged(newTemp) {
            display.changeVehTemp(newTemp)
        }
    }
}


