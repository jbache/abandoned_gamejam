import QtQuick 2.0

Rectangle {
    id: actionItem
    width: 300
    height: 100

    property string title: "H20"
    property color fillColor :"#33ffffff"

    Text {
        anchors.centerIn: parent
        text: title
        color: "white"
        font.pixelSize: 30
    }
    border.width: 2
    border.color: "white"
    color: fillColor

    ProgressBar {
        anchors.centerIn: parent
        width: parent.width * 0.6
        anchors.verticalCenterOffset: 30
    }
}
