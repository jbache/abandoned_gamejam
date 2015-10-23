import QtQuick 2.0

Rectangle {
    width: 100
    height: 20
    color: "gray"

    property real progress
    property color fillColor: "yellow"
//    onProgressChanged: if (progress > 1) progress = 1

    opacity: 0.7

    Rectangle {
        height: parent.height
        width: parent.width * progress
        color: fillColor
        opacity: 0.7
    }

    border.color: "darkgray"
}
