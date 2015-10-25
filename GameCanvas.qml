import QtQuick 2.0

Item {
    id: game
    property var actionItems: []
    property var potatoList: []
    signal nextSol()

    property int pendingEvent: -1
    property var randomEvents: ["Your H20 maker broke. <br> You can't produce water for 2 days!",
        "Martian zombies came for your potatos. <br> You must give them 10 potatos or they eat your brains!",
        "Your radio to NASA broke. <br> You must spend 50% of your energy today to fix it."]

    FutureText {
        id: potato_indicator
        //anchors.left: parent.left
        anchors.top: parent.top
        x: 20
    }

    function applyRandomShit() {
        if (Math.random() > 1/3) {
            pendingEvent = randomEventSelector()
            messageDialog.showDialog(randomEvents[pendingEvent])
        }
        randomEventSelector()
    }

    function randomEventSelector() {
        var numEvents = randomEvents.length;
        var event = Math.floor(Math.random() *numEvents)
        return event
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
        if (sol == totalDaysToRescue)
            onClicked: gameWon.show()

        nextSol()
        var p = potatoList
        var hasRipePotato = false;
        for (var i in p) {
            if (p[i] < 3)p[i]++;
            if (p[i] == 3) {
                harvestButton.enabled = true;
            }
        }
        potatoList = p;
    }


    function harvestPotatoes() {
        potatoes += 5;
        energy = 0;

        var p = potatoList;
        for (var i in potatoList) {
            if (potatoList[i] === 3) {
                potatoList[i] = -1;
            }
        }
        harvestButton.enabled = false;
        potatoList = p;

    }

    Component {
        id: potatoComponent
        Potato {}
    }

    function plantPotato() {
        potatoes -= 1;
        energy -= .2;

        var _list = potatoList;
        // If a spot is available, plant there
        for (var a in _list) {
            if (_list[a] < 0) {
                _list[a] = 0;
                potatoList = _list;
                return;
            }
        }

        // Add new spot
        if (potatoList.length < 7) {
            var _list = potatoList;
            _list.push(0);
            potatoList = _list;
        }
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
        fillMode: Image.PreserveAspectFit
        height: window.height/4
        Behavior on x { NumberAnimation {} }
        source: "qrc:///images/mattdamon_happy.png"
        //            y: window.height - height + 10 - 10 * Math.sin(x / 50.5)
        onXChanged: { playerMoved(); }
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
    //        FutureText {
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

    Row {
        z: 1
        anchors.bottom: ground.top
        anchors.bottomMargin: -101
        anchors.left: parent.left
        anchors.leftMargin: 30
        spacing: 10
        Repeater {
            id: potatoRepeater
            model: potatoList
            Potato { id: potato }
        }
    }

    Rectangle {
        id: ground
        height: 110
        opacity: 0.9
        z:1
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#f3834b"
        Rectangle {
            height: 2
            width: parent.width
            color: Qt.darker(parent.color, 1.5)
        }
    }

    Button {
        id: plantPotatoButton
        z: 2
        buttonText: "Plant"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 30
        onClicked: plantPotato()
    }

    Button {
        id: harvestButton
        z: 3
        enabled: false
        buttonText: "Harvest"
        anchors.left: plantPotatoButton.right
        anchors.bottom: parent.bottom
        anchors.margins: 30
        onClicked: harvestPotatoes()
    }

}
