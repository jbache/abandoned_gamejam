import QtQuick 2.0

FutureText {
    onTextChanged: bounceAnim.restart()
    font.family: "SF UI"
    NumberAnimation on scale {
        id: bounceAnim
        from: 1.2
        to: 1
        easing.type: Easing.OutCubic
        duration: 500
    }
}

