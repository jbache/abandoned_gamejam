import QtQuick 2.0

Item {
    id: actionItem
    width: 300
    height: 100

    property string title: "H20"
    property color fillColor :"#33ffffff"
    property bool isCurrentActionItem: activeItem ? activeItem.title === actionItem.title : false
    property real burnRate: 0.01
    property bool isEnabled: energy > 0

    opacity: isEnabled ? 1 : 0.7
    Behavior on opacity { NumberAnimation { easing.type: Easing.OutCubic } }

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
        NumberAnimation on opacity{
            running: isCurrentActionItem && isEnabled
            from: 0.6
            to: 0.2
            loops: Animation.Infinite
            duration: 1000
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: -1
        color: "transparent"
        border.color: "white"
        border.width: 1
        opacity: 0.7
    }

    Timer {
        id: consumetimer
        interval: 50
        running: isCurrentActionItem && !modalDialog
        repeat: true
        onTriggered: {
            if (energy > 0) {
                energy -= burnRate;
                progressbar.progress += burnRate;
                if (progressbar.progress > 1) {
                    progressbar.progress = 0;
                    finishedTask()
                }
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
