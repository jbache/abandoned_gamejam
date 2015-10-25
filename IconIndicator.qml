import QtQuick 2.5

Row {
    id: indicator
    property alias iconSource: icon.source
    property alias text: textItem.text
    spacing: 10

    Image {
        id: icon
        source: "qrc:///images/potato.png"
        width: 40
        height: 40
        fillMode: Image.PreserveAspectFit
        mipmap: true
        anchors.bottom: parent.bottom
    }

    FutureText {
        id: textItem
        anchors.bottom: parent.bottom
    }
}
