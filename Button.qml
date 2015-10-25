import QtQuick 2.0

Rectangle {
    id: button
    width: 160
    height: 70
    property int fontsize: 25

    opacity: enabled ? 1 : 0.5
    property string buttonText: "buttonTitle"
    signal clicked

    anchors.margins: 10
    border.color: "white"
    border.width: 2
    color: buttonID.pressed ? "#77ffffff" : "white"


    FutureText {
        anchors.centerIn: parent
        text: buttonText
        color: "#f26522"
    }

    MouseArea {
        id: buttonID
        anchors.fill: parent
        onClicked: button.clicked()

    }

}
