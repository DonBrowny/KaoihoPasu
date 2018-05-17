import QtQuick 2.9
import 'Contents'


Item {
    id: root
    visible: true
    width: 640
    height: 340

    Rectangle{
        id:background
        anchors.fill: root
        color: '#57b3f1'
    }

    Image {
        id: name
        width: 150
        height: 150
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./Images/direction_gyro.png"
    }
    Navigator{
        width: root.width
        height: root.height
    }
}

