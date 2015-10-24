import QtQuick 2.0


Rectangle {

    property int sol_count: 1
    color: "#333"
    width: parent.width
    height: 60

    Image {
        id: rocket
        source: "qrc:///images/rocket.png"
        height: 50
        width: 50
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        x: sol_count * 10;
        //Behavior on x: NumberAnimation { easing.type: Easing.OutCubic } }

    }


    Image {
        id: earth
        source: "qrc:///images/earth.png"
        height: 90
        width: 90
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }

    Image {
        id: mars
        source: "qrc:///images/mars_360.png"
        height: 40
        width: 40
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 20
    }

}

