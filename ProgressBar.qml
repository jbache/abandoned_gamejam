import QtQuick 2.0

Rectangle {
    width: 100
    height: 20
    color: "gray"

    property real progress
    property color fillColor: "yellow"

    Rectangle {
        height: parent.height
        width: parent.width * progress
        color: fillColor
    }
}
