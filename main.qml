import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true
    width: 800
    height: 600

    property int sol: 0
    property int potatoes: 10
    property int h2o: 100
    property real energy: 0.5

    function endTurn() {
        sol +=1
        potatoes -= 1;
        h2o += 1;
    }

    Image {
        anchors.fill: parent
        source: "qrc:///images/ground.png"
    }

    Rectangle {
        id: ht2oRect
        width: 300
        height: 100
        anchors.bottom: parent.bottom
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
        x: parent.width/2
        y: parent.height/2
        radius: width/2
        border.width: 2
        color: "#ccc"
        border.color: "black"
        Behavior on x { NumberAnimation {} }
        Behavior on y { NumberAnimation {} }
    }

    function mouseInsideItem(mouse, item) {
        if ((mouse.x < (item.x + item.width)) && (mouse.x > item.x)
                && (mouse.y < item.y + item.height) && (mouse.y> item.y)) {
            return true
        }
        return false
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: {
            player.x = mouse.x
            player.y = mouse.y

            if (mouseInsideItem(mouse, potatoRect))
                print ("Inside Potato!")
            if (mouseInsideItem(mouse, ht2oRect))
                print ("Inside H20!")
            if (mouseInsideItem(mouse, entertainment))
                print ("Inside Entertainment!")
        }
    }

    Column {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        Text {
            color: "white"
            font.pixelSize: 30
            text: "Sol:" + sol
        }
        Text {
            color: "white"
            font.pixelSize: 30
            text: "Potatoes: " + potatoes
        }
        Text {
            color: "white"
            font.pixelSize: 30
            text: "H2O: " + h2o
        }
        Text {
            color: "white"
            font.pixelSize: 30
            text: "Energy: "
        }
        ProgressBar {
            progress: energy
        }
    }

    Rectangle {
        id: potatoRect
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.6
        color: Qt.rgba(1, 1, 0, 0.5)
    }

    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        border.color: "white"
        width: 260
        height: 60
        color: endTurnMouse.pressed ? "#33ffffff" : "#77ffffff"
        radius: 10
        Text {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 30
            text: "End turn"
        }
        MouseArea {
            id: endTurnMouse
            anchors.fill: parent
            onClicked: endTurn()
        }
    }

}

