import QtQuick 2.0

Rectangle {
    color: "#333"
    width: parent.width
    height: 60

    Image {
        source: "qrc:///images/earth.png"
        height: 90
        width: 90
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }

    Image {
        source: "qrc:///images/mars_360.png"
        height: 40
        width: 40
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 20
    }

}

