import QtQuick 2.0

Rectangle {
    id: splash
    color: "#333"

    property string splashText: ""
    property alias text: innerText.text
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

    Column {
        spacing: 20
        anchors.centerIn: parent
        Image {
            id: image
            height: splash.height* .6
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }
        FutureText {
            id: innerText
            font.pixelSize: 30
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            text: splashText
        }
    }

}

