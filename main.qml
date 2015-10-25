import QtQuick 2.3
import QtQuick.Window 2.2
import QtMultimedia 5.0

Window {
    id: window
    visible: true
    width: 800
    height: 600

    property int sol: 0
    property int potatoes: 3
    property int totalDaysToRescue: 10
    property int h2o: 100
    property real energy: 1
    property ActionItem activeItem: null
    property bool modalDialog: messageDialog.visible

    function calculateDistanceTraveledEachDay() {
        var distance = width - gameProgress.earth.width - gameProgress.mars.width;
        var travelEachDay = distance/(totalDaysToRescue+1);
        print ("travel Each Day: " + travelEachDay);
        return travelEachDay;
    }

    SoundEffect {
        id: dropSound
        source: "qrc:///sounds/drop.wav"
    }

    SpaceshipIndicator {
        distance_traveled_each_day: calculateDistanceTraveledEachDay(totalDaysToRescue)
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

    Splash {
        id: splash
        z: 1
        text: "Team Rocket Science"
        anchors.fill: parent
        opacity: 1
    }

    Splash {
        id: gameWon
        z: 1
        opacity: 0
        anchors.fill: parent
        imageSource: "qrc:///images/VictoryMeme.png"
    }

    Splash {
            id: gameLost
            splashText: "Game over. You died :("
            z: 1
            opacity: 0
            anchors.fill: parent
            imageSource: "qrc:///images/dead_astronaut.png"
        }

    Splash {
            id: makingWater
            splashText: "Sciencing Water..."
            z: 1
            opacity: 0
            anchors.fill: parent
            imageSource: "qrc:///images/make_water.png"
        }

    MessageText { id: messageText }

    MessageDialog { id: messageDialog
        onClicked: {
            print("Message dialog: " + gameCanvas.pendingEvent)
            if (gameCanvas.pendingEvent !== -1) {
                if (gameCanvas.pendingEvent == 0) {
                    h2o = h2o * .5
                } else if (gameCanvas.pendingEvent == 1) {
                    potatoes = potatoes - 10
                } else if (gameCanvas.pendingEvent == 2) {
                    energy = .5
                }
                gameCanvas.pendingEvent = -1
                messageDialog.opacity = 0
            }
        }
    }
}

