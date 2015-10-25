import QtQuick 2.5

Item {
    id: game
    property var actionItems: []
    property var potatoList: []
    signal nextSol()

    property int pendingEvent: -1
    property var randomEvents: ["Your H20 maker exploded. <br> Lose 50% water!",
        "Martian zombies came for your potatos. <br> You must give them 10 potatos or they eat your brains!",
        "Your radio to NASA broke. <br> You must spend 50% of your energy today to fix it."]


    function getPlantCount() {
        var count = 0
        for (var i in potatoList) {
            if (potatoList[i] !== -1) {
                count ++
            }
        }
        return count;
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
        sol +=1
        potatoes -= 1;
        energy = 1;
        messageText.showMessage("Sol " + sol);
        applyRandomShit()
        calculateDistanceTraveledEachDay();
        if (sol == totalDaysToRescue)
            onClicked: gameWon.show()

        if (isGameLost() === 1)
            onClicked: gameLost.show()

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

    function isGameLost() {
        var gameLost = 0
        if (window.potatoes < -1) {
            gameLost = 1
        }
        if (window.h2o <= 0) {
            gameLost = 1
        }
        return gameLost
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

    function waterPotatoes() {
        var num_potatoes = getPlantCount()
        print("potatoes planted: "+ num_potatoes)
        h2o = h2o - num_potatoes * 2
    }

    function makeWater() {
        makingWater.show()
        h2o = h2o + 10
        energy = energy - .5
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
        source: "qrc:///images/ground.png"
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            color: "#eeec7b"
            opacity: 0.5
        }
    }

    ProgressBar {
        id: energyBar
        width: 200
        progress: energy
        z: 1
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
    }

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        spacing: 10
        IconIndicator {
            text:"Potatoes: " + window.potatoes
            iconSource: "qrc:///images/potato.png"
        }
        IconIndicator {
            text:"Water: " +  window.h2o
            iconSource: "qrc:///images/water.png"
        }
    }

    Button {
        id: endSolButton
        anchors.top: energyBar.bottom
        anchors.margins: 20
        buttonText: "End sol"
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

    Button {
        id: waterPotatoesButton
        z: 3
        enabled: true
        buttonText: "Water <br>potatoes"
        anchors.left: harvestButton.right
        anchors.bottom: parent.bottom
        anchors.margins: 30
        onClicked: waterPotatoes()
    }

    Button {
        id: makeWaterButton
        z: 3
        enabled: true
        buttonText: "Make<br>water"
        anchors.left: waterPotatoesButton.right
        anchors.bottom: parent.bottom
        anchors.margins: 30
        onClicked: makeWater()
    }


}
