import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true
    width: 800
    height: 600

    property int sol: 0
    property int potatoes: 10
    property int h2o: 100
    property real energy: 1
    property ActionItem activeItem: null

    property var actionItems: [entertainment, potatoActionItem, h20]

    function endTurn() {
        sol +=1
        potatoes -= 1;
        h2o += 1;
        energy = 1;
        messageText.showMessage("Sol " + sol);
    }

    function harvestPotatoes() {
        potatoes += 5;
        energy = 0;
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

    ProgressBar {
        id: energyBar
        width: parent.width
        progress: energy
        z: 1
    }

    Item {
        anchors.top: energyBar.bottom
        anchors.bottom: parent.bottom

        width: parent.width

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
            spacing: 10
            StatusText {
                color: "white"
                font.pixelSize: 30
                text: "Potatoes: " + potatoes
            }
            StatusText {
                color: "white"
                font.pixelSize: 30
                text: "H2O: " + h2o
            }
        }

        ActionItem {
            id: potatoActionItem
            anchors.centerIn: parent
            width: parent.width * 0.4
            height: parent.height * 0.4
            title: "potatoes"
            fillColor: Qt.rgba(1, 1, 0, 0.5)
            onFinishedTask: potatoes += 1
        }

        Button {
            buttonText: "Harvest Potatoes"
            anchors.right: parent.right
            anchors.bottom: endTurnButton.top
            onClicked: harvestPotatoes()
        }



        Rectangle {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            id: endTurnButton
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
    MessageText {
        id: messageText
    }
}

