import QtQuick

Item {
    id: itemWindow
    width: 441
    height: 441
    visible: true
    property int currentAngle /* represting the speed */
    property string engineState: "On"
    readonly property int initialAngle: 54
    readonly property int speedThreshold: 130
    readonly property int returnToZeroTime: 3000

    Rectangle {
        id: root
        x: 0
        y: 0
        width: 441
        height: 441
        color: "#322424"
        border.color: "green"
        border.width: 10
        radius: 221

        Text {
            id: current_speed
            y: 0.7* parent.height
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            width: 243
            height: 48
            color: "#ffffff"
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: currentAngle + " km/h\nEngine Status: " + engineState
        }

        Rectangle {
            id: centralRectangle
            x: parent.width/2 - width/2
            y: parent.height/2 - height/2
            width: 30
            height: 30
            color: "#9e7272"
            radius: 15
        }

        Repeater {
            model: 50
            Item {
                height: 210
                transformOrigin: Item.Bottom
                rotation: index*5 + 235
                x: root.width/2
                y: 0 + root.border.width

                Rectangle {
                    height: 10
                    width: 1
                    color: "#ffffff"
                }

                Text {
                    topPadding: 15
                    color: "white"
                    text: (index)%5===0? (index)*5 : ""
                }
            }
        }
    }

    Row{
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height/2 + 145
        Image{
            id: seatbeltWarning
            source: "assets/seatbelt.png"
            height:40
            width:40
            /*initially, the warning is not visible [active]*/
            visible: false
        }

        Image{
            id: doorsOpenWarning
            source: "assets/doorsOpen.png"
            height:40
            width:40
            /*initially, the warning is not visible [active]*/
            visible: false
        }

    }

    Rectangle {
        id: needle
        y: 217
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: centralRectangle.top
        anchors.bottomMargin: -2
        anchors.horizontalCenterOffset: 0
        width: 13
        height: 153
        color: currentAngle>speedThreshold? "red" : "#7b3131"

        Rectangle {
            id: rectTip
            x: 0
            y: parent.height-6
            width: 13
            height: 10
            color: parent.color
            radius: 5
        }

        transform: Rotation{
            origin.x:6.5
            NumberAnimation on angle {
                id: meterAnimation
                /*if engine is turned off, the slider has no effect on the needle anymore*/
                from:     currentAngle+initialAngle+1 /* +1 to make the needle slightly vibrates */
                to:       currentAngle+initialAngle
                duration: 10
                running:  true
                loops:Animation.Infinite
            }
        }

        Timer{
            id:needleTimer
            interval: returnToZeroTime
            repeat: false

            onTriggered: {
                /* set running to false to avoid animation loops */
                meterAnimation.stop()
            }
        }

    }

    function engineTurnedOff(){
        engineState = "Off"
        needle.color= "#7b3131"
        current_speed.text = 0 + " km/h\nEngine Status: " + engineState
        meterAnimation.to=initialAngle
        meterAnimation.duration=returnToZeroTime
        needleTimer.start()
    }

    function changeSeatbeltWarning(warningState){
        seatbeltWarning.visible=warningState
    }

    function changeDoorsOpenWarning(warningState){
        doorsOpenWarning.visible=warningState
    }

}
