import QtQuick 2.0

Item {
    id: dialog
    anchors.fill: parent

    opacity: 0
    visible: opacity > 0
    Behavior on opacity { NumberAnimation {} }
    signal clicked

    function showDialog(messagetext) {
        message.text = messagetext ;
        dialog.opacity = 1;
        print ("message ", messagetext )
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialog.clicked()
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 50
        radius: 50
        color: "#cc000000"
        border.color: "#77ffffff"
        border.width: 2
        FutureText {
            id: message
            anchors.fill:parent
            width: parent.width * .7
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 40
            color: "white"
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

    }



}

