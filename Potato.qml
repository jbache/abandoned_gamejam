import QtQuick 2.0

Image {
    width: 100
    height: 280
    fillMode: Image.PreserveAspectFit
    source: modelData> -1 ?"qrc:///images/potatoplant_" + modelData + ".png" : ""
    property int old
    onSourceChanged: {
        if (modelData !== old)
            bounceAnim.restart()
        old = modelData
    }
    transformOrigin: Item.Top
    NumberAnimation on scale {
        from: 1.2
        to: 1
        easing.type: Easing.OutCubic
        id: bounceAnim
        duration: 250
    }
}
