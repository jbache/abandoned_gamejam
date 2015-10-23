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
    }

    ProgressBar {
        id: progressbar
        width: parent.width
        anchors.bottom: parent.bottom

        NumberAnimation on progress {
            id: progressAnimation
            running: activeItem ? activeItem.title === actionItem.title : false
            from: 0
            to: 1
            duration: 10000
            onStopped: {
                finishedTask()
            }
        }
    }

}
