import QtQuick 2.3
import QtQuick.Window 2.2
import QtMultimedia 5.0

Window {
    id: window
    visible: true
    width: 800
    height: 600

//    visibility: "FullScreen"
    color: "#333"

    property real scaleFactor: window.width/800
    property int sol: 0
    property int potatoes: 8
    property int totalDaysToRescue: 10
    property int h2o: 100
    property real energy: 1
    property ActionItem activeItem: null
    property bool modalDialog: messageDialog.visible
    property int martianStealsNPotatoes: 2

    function calculateDistanceTraveledEachDay() {
        var distance = width - gameProgress.earth.width - gameProgress.mars.width;
        var travelEachDay = distance/(totalDaysToRescue+1);
        //print ("travel Each Day: " + travelEachDay);
        return travelEachDay;
    }

    SoundEffect {
        id: dropSound
        source: "qrc:///sounds/drop.wav"
    }

    SoundEffect {
        id: endSound
        source: "qrc:///sounds/end.wav"
    }

    MediaPlayer {
        id: music
        source: "qrc:///music/rebuilding.mp3"
        autoLoad: true
        autoPlay: false
    }

    MediaPlayer {
        id: intromusic
        source: "qrc:///music/breakdown.mp3"
        autoLoad: true
        autoPlay: true
    }


    SpaceshipIndicator {
        distance_traveled_each_day: calculateDistanceTraveledEachDay(totalDaysToRescue)
        days_til_rescue: totalDaysToRescue
        id: gameProgress
        z: 1
        sol_count: sol
        visible: false
    }

    GameCanvas {
        id: gameCanvas
        anchors.top: gameProgress.bottom
        width: parent.width
        anchors.bottom: parent.bottom
        visible: false
    }

    Component.onCompleted: splash1.show()


    Splash {
        id: splash1
        z: 1
        imageSource: "qrc:///images/rocketscience.png"
        text: "Team Rocket Science"
        anchors.fill: parent
        opacity: 0
        onClicked: {
            splash2.show()
        }
    }

    Splash {
        id: splash2
        z: 1
        font.pixelSize: 60
        imageSource: "qrc:///images/splash.png"
        text: "Stuck on Mars!"
        anchors.fill: parent
        opacity: 0
        onClicked: {
            intromusic.stop()
            music.play()
            gameCanvas.visible = true;
            gameProgress.visible = true;
        }
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

        FutureText {
            anchors.bottom: parent.bottom
            anchors.margins: 10
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Tap to restart"
        }
        onClicked: music.start()

    }

    Splash {
        id: makingWater
        splashText: "Sciencing Water..."
        color: "#FFDE17"
        z: 1
        opacity: 0
        anchors.fill: parent
        imageSource: "qrc:///images/make_water.png"
    }

    MessageText { id: messageText }

    MessageDialog {
        id: messageDialog
        onClicked: {
            print("Message dialog: " + gameCanvas.pendingEvent)
            if (gameCanvas.pendingEvent !== -1) {
                if (gameCanvas.pendingEvent == 0) {
                    h2o = h2o * .5
                } else if (gameCanvas.pendingEvent == 1) {
                    potatoes = potatoes - martianStealsNPotatoes
                } else if (gameCanvas.pendingEvent == 2) {
                    energy = .5
                }
                gameCanvas.pendingEvent = -1
                messageDialog.opacity = 0
            }
        }
    }
}

