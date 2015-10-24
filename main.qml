import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 800
    height: 600

    property int sol: 0
    property int potatoes: 10
    property int totalDaysToRescue: 50;
    property int h2o: 100
    property real energy: 1
    property ActionItem activeItem: null
    property bool modalDialog: messageDialog.visible


    function calculateDistanceTraveledEachDay(totTravelDays) {
        var distance = width - gameProgress.earth.width - gameProgress.mars.width;
        var travelEachDay = distance/totTravelDays;
        print ("travel Each Day: " + travelEachDay);
        return travelEachDay;
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

    MessageText { id: messageText }

    MessageDialog { id: messageDialog }

}

