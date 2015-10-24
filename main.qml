import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 800
    height: 600

    property int sol: 0
    property int potatoes: 10
    property int h2o: 100
    property real energy: 1
    property ActionItem activeItem: null
    property bool modalDialog: messageDialog.visible

    property var actionItems: [potatoActionItem]

    function applyRandomShit() {
        if (Math.random() > 2/3) {
            messageDialog.showDialog("Random shit just happened")
        }
    }

    function endTurn() {
        sol +=1
        potatoes -= 1;
        h2o += 1;
        energy = 1;
        messageText.showMessage("Sol " + sol);
        applyRandomShit()
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

    SpaceshipIndicator {
        id: gameProgress
        z: 1
        sol_count: sol
    }

    GameCanvas {
        id: gameCanvas
        anchors.top: gameProgress.bottom
        width: parent.width
        anchors.bottom: parent.bottom
    }
}

