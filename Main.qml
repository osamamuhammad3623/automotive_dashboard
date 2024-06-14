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
        id: dashboard
        width: 1280
        height: 550
        color: "#23253e"
        border.color: "#57b9fc"
        border.width: 7
        radius: 221
        property bool tempWarning: false

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

        Row{
            property int iconSize: 50
            spacing: 10
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 50
            }
            Image{
                id: hotTempWarning
                source: "assets/temperature.png"
                height: parent.iconSize
                width:  parent.iconSize
                /*initially, the warning is not visible [active]*/
                visible: dashboard.tempWarning
            }

            Image{
                id: seatbeltWarning
                source: "assets/seatbelt.png"
                height: parent.iconSize
                width:  parent.iconSize
                /*initially, the warning is not visible [active]*/
                visible: false
            }

            Image{
                id: doorsOpenWarning
                source: "assets/doorsOpen.png"
                height: parent.iconSize
                width:  parent.iconSize
                /*initially, the warning is not visible [active]*/
                visible: false
            }
        }

        function changeSeatbeltWarning(warningState){
            seatbeltWarning.visible=warningState
        }

        function changeDoorsOpenWarning(warningState){
            doorsOpenWarning.visible=warningState
        }

        function switchHotTempWarning(){
            tempWarning= !tempWarning
        }

        Connections{
            target:warnMgr

            /*C++ calls QML (signal/slot concept)*/
            function onSeatbeltWarningChanged(warnState) {
                dashboard.changeSeatbeltWarning(warnState)
            }

            function onDoorsOpenWarningChanged(warnState) {
                dashboard.changeDoorsOpenWarning(warnState)
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

    Slider{
        id: slider
        width: 300
        from:0
        to: 250

        anchors{
            horizontalCenter: parent.horizontalCenter
        }
        y: 0.9*root.height

        Binding{
            speedometer.currentAngle: slider.value
            when: speedometer.engineState="On"
        }

        Binding{
            motor_rpm.currentAngle: slider.value
            when: motor_rpm.engineState="On"
        }
    }

    Text{
        anchors{
            bottom: slider.top
            bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
        text: "Speed"
        font.pixelSize: 25
        color: "white"

    }

    Column{
        id: controlColumn
        spacing: 10
        rightPadding: 50
        leftPadding: 30
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
                dashboard.switchHotTempWarning()
            }
        }

        Button{
            text: "Turn on Engine"
            height: 30
            width: 200
            font.pixelSize: 15
            onClicked: {
                speedometer.engineTurnedOn()
                motor_rpm.engineTurnedOn()
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

}


