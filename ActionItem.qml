import QtQuick 2.0

Item {
    id: actionItem
    width: 300
    height: 100

    property string title: "H20"
    property color fillColor :"#33ffffff"

    signal finishedTask

    Text {
        anchors.centerIn: parent
        text: title
        color: "white"
        font.pixelSize: 30
    }

    Rectangle {
        anchors.fill: parent
        color: fillColor
        opacity: 0.5
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: -1
        color: "transparent"
        border.color: "white"
        border.width: 1
        opacity: 0.7
    }

    property bool isCurrentActionItem: activeItem ? activeItem.title === actionItem.title : false
    property real burnRate: 0.01

    Timer {
        id: consumetimer
        interval: 100
        running: isCurrentActionItem
        repeat: true
        onTriggered: {
            if (energy > 0) {
                energy -= burnRate;
                progressbar.progress += burnRate;
            } else {
                energy = 0;
            }
        }
    }

    ProgressBar {
        id: progressbar
        width: parent.width
        anchors.bottom: parent.bottom

    }

}
