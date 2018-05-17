import QtQuick 2.0

Rectangle {
    id:root
    width: joystick.width
    height: joystick.height
    color: "transparent"
    property double pointX: 0
    property double pointY: 0
    signal joystick_moved(double x, double y)

    Image {
        id: joystick

        property real angle : 0
        property real distance : 0
        source: "../Images/background.png"
        anchors.centerIn: parent

        ParallelAnimation {
            id: returnAnimation
            NumberAnimation { target: thumb.anchors; property: "horizontalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
            NumberAnimation { target: thumb.anchors; property: "verticalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
        }

        MultiPointTouchArea{
            property real fingerAngle : Math.atan2(pointX, pointY)
            property int mcx : pointX - width * 0.5
            property int mcy : pointY - height * 0.5
            property bool fingerInBounds : fingerDistance2 < distanceBound2
            property real fingerDistance2 : mcx * mcx + mcy * mcy
            property real distanceBound : width * 0.5 - thumb.width * 0.5
            property real distanceBound2 : distanceBound * distanceBound

            property double signal_x : (pointX - joystick.width/2) / distanceBound
            property double signal_y : -(pointY - joystick.height/2) / distanceBound

            anchors.fill: parent

            onPressed: {
                returnAnimation.stop();
            }

            onReleased: {
                returnAnimation.restart()
                joystick_moved(0, 0);
            }
            onUpdated: {
                if (fingerInBounds) {
                    thumb.anchors.horizontalCenterOffset = mcx
                    thumb.anchors.verticalCenterOffset = mcy
                } else {
                    var angle = Math.atan2(mcy, mcx)
                    thumb.anchors.horizontalCenterOffset = Math.cos(angle) * distanceBound
                    thumb.anchors.verticalCenterOffset = Math.sin(angle) * distanceBound
                }

                // Fire the signal to indicate the joystick has moved
                angle = Math.atan2(signal_y, signal_x)

                if(fingerInBounds) {
                    joystick_moved(
                                Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound,
                                Math.sin(angle) * Math.sqrt(fingerDistance2) / distanceBound
                                );
                } else {
                    joystick_moved(
                                Math.cos(angle) * 1,
                                Math.sin(angle) * 1
                                );
                }
                console.log(angle);
            }
        }


        Image {
            id: thumb
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            source: "../Images/finger.png"
            anchors.centerIn: parent
        }
    }

}
