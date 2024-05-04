import QtQuick

Item {
    id: itemWindow
    width: 441
    height: 441
    visible: true
    property int currentAngle: 0
    readonly property int initialAngle: 54
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
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: currentAngle + " km/h\nEngine Status: On"
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

    Image{
        id: seatbeltWarning
        source: "seatbelt.png"
        x: parent.width/2 - width/2
        y: parent.height/2 + 145
        /*initially, the warning is not visible [active]*/
        visible: false
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
        color: "#7b3131"

        Rectangle {
            id: rectTip
            x: 0
            y: parent.height-6
            width: 13
            height: 10
            color: "#7b3131"
            radius: 5
        }

        transform: Rotation{
            origin.x:6.5
            NumberAnimation on angle {
                id: meterAnimation
                /*if engine is turned off, the slider has no effect on the needle anymore*/
                from:     currentAngle+initialAngle
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
                meterAnimation.running=false
            }
        }

    }

    function engineTurnedOff(){
        current_speed.text="0 km/h\nEngine Status: Off"
        meterAnimation.to=initialAngle
        meterAnimation.duration=returnToZeroTime
        needleTimer.start()
    }

    function changeSeatbeltWarning(warnState){
        seatbeltWarning.visible=warnState
    }

}
