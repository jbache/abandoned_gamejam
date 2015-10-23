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
    property ActionItem activeItem: null

    property var actionItems: [entertainment, potatoActionItem, h20]

    function endTurn() {
        sol +=1
        potatoes -= 1;
        h2o += 1;
    }

    Image {
        anchors.fill: parent
        source: "qrc:///images/ground.png"
    }

    ActionItem {
        id: h20
        anchors.bottom: parent.bottom
        title: "H2O"
    }

    ActionItem {
        id: entertainment
        anchors.right: parent.right
        title: "Entertainment"
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

        onXChanged: playerMoved()
        onYChanged: playerMoved()
    }


    function playerMoved() {
        var foundItem = false

        for (var index in actionItems) {
            var actionItem = actionItems[index];
            if (pointInsideItem(player, actionItem)) {
                activeItem = actionItem;
                foundItem = true;
            }
        }

        if (!foundItem) {
            activeItem = null;
        }
    }

    function pointInsideItem(point, item) {
        if ((point.x < (item.x + item.width)) && (point.x > item.x)
                && (point.y < item.y + item.height) && (point.y> item.y)) {
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

    ActionItem {
        id: potatoActionItem
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.6
        title: "potatoes"
        fillColor: Qt.rgba(1, 1, 0, 0.5)
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

    Text {
        anchors.centerIn: parent
        color: "red"
        text: activeItem !== null ? activeItem.title : "no item"
        font.pixelSize: 50
    }

}

