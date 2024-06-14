import QtQuick
import QtQuick.Controls

Rectangle {
    id: display
    width: 200
    height: 300
    radius: 40
    color: "#23253e"
    border.color: "#57b9fc"
    border.width: 4
    property string current_veh_mode: "P"
    property int current_veh_temp: 32
    property int current_milage: 1215
    property int current_gas_percentage: 60

    Text {
        id: veh_mode
        y: 84
        height: 70
        color: "#ffffff"
        text: current_veh_mode
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 91
        anchors.rightMargin: 26
        font.pixelSize: 50
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    Text {
        id: veh_temp
        y: 250
        height: 35
        color: "#ffffff"
        text: current_veh_temp + qsTr("° C")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 71
        anchors.rightMargin: 70
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    Text {
        id: milage
        y: 209
        height: 35
        color: "#ffffff"
        text: current_milage + qsTr(" km")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    ProgressBar {
        id: gas_bar
        y: 104
        width: 180
        height: 25
        visible: true
        value: current_gas_percentage/100
        leftInset: 5
        clip: false
        enabled: true
        rotation: -90
        anchors.left: parent.left
        anchors.leftMargin: -33
    }

    Text {
        id: veh_temp1
        x: 66
        y: 172
        width: 23
        height: 35
        color: "#ffffff"
        text: qsTr("E")
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: false
    }

    Text {
        id: veh_temp2
        x: 66
        y: 17
        width: 23
        height: 35
        color: "#ffffff"
        text: qsTr("F")
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: false
    }

    function changeVehMode(newMode){
        current_veh_mode = newMode
    }

    function changeVehTemp(newTemp){
        current_veh_temp = newTemp
    }

}
