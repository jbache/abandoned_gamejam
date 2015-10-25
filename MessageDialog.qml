import QtQuick 2.0

Item {
    id: dialog
    parent: window.contentItem
    anchors.fill: parent

    opacity: 0
    visible: opacity > 0
    Behavior on opacity { NumberAnimation {} }
    signal clicked

    function showDialog(messagetext) {
        message.text = messagetext ;
        dialog.opacity = 1;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialog.clicked()
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#f26522"
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

