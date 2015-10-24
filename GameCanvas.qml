import QtQuick 2.0

Item {
    property var actionItems: []

    Text {
        id: sol_indicator
        //anchors.left: parent.left
        anchors.top: parent.top
        x: 20
        color: "white"
        font.pixelSize: 20
        text: "sol: " + window.sol
        z:1
    }

    function applyRandomShit() {
        if (Math.random() > 2/3) {
            messageDialog.showDialog("Random shit just happened")
        }
    }

    function endTurn() {
        print("end turn button clicked")
        sol +=1
        potatoes -= 1;
        h2o += 1;
        energy = 1;
        messageText.showMessage("Sol " + sol);
        applyRandomShit()
        calculateDistanceTraveledEachDay();
        if (sol == totalDaysToRescue) {
            onClicked: gameWon.show()
        }
    }

    function harvestPotatoes() {
        potatoes += 5;
        energy = 0;
    }

    function plantPotato() {
        potatoes -= 1;
        energy -= .2;
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

    Image {
        source: "qrc:///images/ground.jpg"
        anchors.fill: parent
    }

    ProgressBar {
        id: energyBar
        width: 200
        progress: energy
        z: 1
        anchors.right: endSolButton.left
        anchors.top: parent.top
        anchors.margins: 30
    }

    Button {
        id: endSolButton
        width: 50
        fontsize: 20
        buttonText: "End <br>sol"
        onClicked: endTurn()
        anchors.right: parent.right
        z:1
    }

    Image {
        id: player
        x: parent.width/2
        z: 1
        anchors.bottom: ground.top
        anchors.bottomMargin: -20
        fillMode: Image.PreserveAspectFit
        height: window.height/4
        Behavior on x { NumberAnimation {} }
        source: "qrc:///images/matt_damon.png"
        //            y: window.height - height + 10 - 10 * Math.sin(x / 50.5)
        onXChanged: { playerMoved(); }
    }

    Rectangle {
        id: ground
        height: 80
        opacity: 0.9
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#f3834b"
        Rectangle {
            height: 2
            width: parent.width
            color: Qt.darker(parent.color, 1.5)
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: { player.x = mouse.x; }
    }


    //    ActionItem {
    //        id: potatoActionItem

    //        width: parent.width * 0.4
    //        title:  "Potatoes"
    //        anchors.bottom: parent.bottom
    //        Text {
    //            anchors.centerIn: parent
    //            text: title
    //            color: "white"
    //            font.pixelSize: 30
    //        }

    //        Button {
    //            id: plantPotatoButton
    //            buttonText: "Plant Potato"
    //            anchors.left: potatoActionItem.left
    //            anchors.bottom: potatoActionItem.bottom
    //            onClicked: plantPotato()
    //        }
    //        Button {
    //            buttonText: "Harvest Potatoes"
    //            anchors.left: potatoActionItem.left
    //            anchors.bottom: plantPotatoButton.top
    //            onClicked: harvestPotatoes()
    //        }
    //        height: gameCanvas.height
    //    }



}
