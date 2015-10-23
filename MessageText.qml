import QtQuick 2.0

Rectangle {
    id: messageText
    anchors.fill: parent
    color: "#aa000000"
    opacity: 0

    function showMessage(message) {
        text.text = message
        scaleAnimation.restart();
    }
    property real yOffset

    Text {
        id: text
        anchors.centerIn: parent
        anchors.verticalCenterOffset: yOffset
        font.pixelSize: 70
        color: "white"
    }

    SequentialAnimation {
        id: scaleAnimation
        ParallelAnimation {
            NumberAnimation{
                target: messageText
                property: "yOffset"
                from: -100
                to: 0
                easing.type: Easing.OutCubic
                duration: 500
            }
            NumberAnimation{
                target: messageText
                property: "opacity"
                from: 0
                to: 1
                easing.type: Easing.OutCubic
                duration: 1000
            }
            NumberAnimation {
                target: messageText
                property: "scale"
                from: 1.2
                to: 1
                easing.type: Easing.OutCubic
                duration: 500
            }
        }

        ParallelAnimation {
            NumberAnimation{
                target: messageText
                property: "opacity"
                from: 1
                to: 0
                easing.type: Easing.OutCubic
                duration: 1000
            }
            NumberAnimation{
                target: messageText
                property: "yOffset"
                from: 0
                to: 100
                easing.type: Easing.OutCubic
                duration: 500
            }
        }
    }
}

