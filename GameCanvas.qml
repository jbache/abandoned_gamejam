import QtQuick 2.0

Item {


    Image {
        source: "qrc:///images/ground.jpg"
        anchors.fill: parent
    }

    ProgressBar {
        id: energyBar
        width: 100
        progress: energy
        z: 1
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 30
    }

    Image {
        id: player
        x: parent.width/2
        anchors.bottom: parent.bottom
        fillMode: Image.PreserveAspectFit
        height: window.height/3
        Behavior on x { NumberAnimation {} }
        source: "qrc:///images/matt_damon.png"
//            y: window.height - height + 10 - 10 * Math.sin(x / 50.5)
        onXChanged: { playerMoved(); }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: { player.x = mouse.x }
    }

    ActionItem {
        id: potatoActionItem

        width: parent.width * 0.4
        title:  "Potatoes"
        anchors.bottom: parent.bottom
        Text {
            anchors.centerIn: parent
            text: title
            color: "white"
            font.pixelSize: 30
        }

        Button {
            id: plantPotatoButton
            buttonText: "Plant Potato"
            anchors.left: potatoActionItem.left
            anchors.bottom: potatoActionItem.bottom
            onClicked: plantPotato()
        }
        Button {
            buttonText: "Harvest Potatoes"
            anchors.left: potatoActionItem.left
            anchors.bottom: plantPotatoButton.top
            onClicked: harvestPotatoes()
        }

        height: gameCanvas.height
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
