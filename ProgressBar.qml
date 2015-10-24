import QtQuick 2.0

Item {
    width: 100
    height: 27

    property real progress
    property color fillColor: "yellow"

    Rectangle {
        anchors.fill: parent
        color: "gray"
        opacity: 0.9

        Rectangle {
            height: parent.height
            width: parent.width * progress
            color: fillColor
            opacity: 0.7
            radius: 4
        }
        radius: 4
        border.color: "darkgray"
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 4
        border.color: "#444"
        border.width: 2
    }
}
