import QtQuick 2.0

Rectangle {
    id: splash
    color: "#333"

    property alias imageSource: image.source
    Behavior on opacity { NumberAnimation {} }

    function show() {
        opacity = 1
    }

    function hide() {
        opacity = 0;
    }

    signal clicked

    MouseArea {
        enabled: splash.opacity>0
        anchors.fill: parent
        onClicked: {
            splash.clicked()
            splash.opacity = 0
        }
    }

    property alias text: innerText.text

    Column {
        anchors.centerIn: parent
        spacing: 40
        Text {
            id: innerText
            font.pixelSize: 30
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            text: ""
        }
        Image {
            id: image
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


}

