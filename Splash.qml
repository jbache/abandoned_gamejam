import QtQuick 2.0

Rectangle {
    id: splash
    color: "#333"
    property string splashText: ""

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

        Image {
            id: image
            height: splash.height* .9
            anchors.horizontalCenter: parent.horizontalCenter
        }
        FutureText {
            id: innerText
            font.pixelSize: 30
            color: "white"
            anchors.top: image.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: splashText
        }

}

