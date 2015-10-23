import QtQuick 2.0

Item {
    id: dialog
    anchors.fill: parent

    opacity: 0
    visible: opacity > 0
    Behavior on opacity { NumberAnimation {} }

    function showDialog(messagetext) {
        message.text = messagetext;
        dialog.opacity = 1;
        print ("message ", messagetext )
    }

    MouseArea {
        anchors.fill: parent
        onClicked: dialog.opacity = 0
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 50
        radius: 50
        color: "#cc000000"
        border.color: "#77ffffff"
        border.width: 2
        Text {
            id: message
            anchors.fill:parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 50
            color: "white"
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
           // text: "<b>Random shit just happened!</b><p>Some more text"
        }
    }

}

