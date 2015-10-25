import QtQuick 2.0

Rectangle {
    id: button
    width: 260
    height: 60
    property int fontsize: 30

    opacity: enabled ? 1 : 0.5
    property string buttonText: "buttonTitle"
    signal clicked

    anchors.margins: 10
    border.color: "transparent"
    color: buttonID.pressed ? "#33ffffff" : "#77ffffff"
    radius: 10

    Text {
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: fontsize
        text: buttonText
    }

    MouseArea {
        id: buttonID
        anchors.fill: parent
        onClicked: button.clicked()

    }

}
