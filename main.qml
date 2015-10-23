import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true
    width: 800
    height: 600


    Image {
        anchors.fill: parent
        source: "qrc:///images/ground.png"
    }

    Rectangle {
        width: 300
        height: 100
        Text {
            anchors.centerIn: parent
            text: "H2O"
            color: "white"
            font.pixelSize: 30
        }
        border.width: 2
        border.color: "white"
        color: "#33ffffff"
    }

    Rectangle {
        id: entertainment
        anchors.right: parent.right
        width: 300
        height: 100
        Text {
            anchors.centerIn: parent
            text: "Entertainment"
            color: "white"
            font.pixelSize: 30
        }
        border.width: 2
        border.color: "white"
        color: "#33ff0000"
    }

    Text {
        anchors.bottom: parent.bottom
        text: "H2O "
    }


    Rectangle {
        id: player
        width: 40
        height: 40
        radius: width/2
        border.width: 2
        color: "#ccc"
        border.color: "black"
        Behavior on x { NumberAnimation {} }
        Behavior on y { NumberAnimation {} }
    }


    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: {
            player.x = mouse.x
            player.y = mouse.y

        }
    }

}

