import QtQuick 2.9

Item{
    signal clicked
    Image {
        id: image
        source: "../Images/arrow.png"
        width: 50
        height: 50
    }
    MouseArea{
        anchors.fill: image
        onPressed: {image.source="../Images/arrow_pressed.png";}
        onReleased: {image.source="../Images/arrow.png";}
        onClicked: {parent.clicked();}
    }
    states: [
        State {
            name: "Normal"
            PropertyChanges {
                target: image.source="../Images/arrow.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: image.source="../Images/arrow_pressed.png"
            }
        },
        State {
            name: "Released"
            PropertyChanges {
                target: image.source="../Images/arrow.png"
            }
        }
    ]
}
