import QtQuick 2.9
import 'Contents'

Item {
    visible: true

    property string touchPoint1: ''
    property string touchPoint2: ''

    function pressHandler(){
        if(point1.pressed){
            if(touchArea.childAt(point1.sceneX,point1.sceneY).objectName === 'leftThumb'){
                touchPoint1 = 'leftThumb';
                leftThumb.pointX = point1.sceneX;
                leftThumb.pointY = point1.sceneY;
            }
            else if(touchArea.childAt(point1.sceneX,point1.sceneY).objectName === 'rightThumb'){
                touchPoint1 = 'rightThumb';
                rightThumb.pointX = point1.sceneX;
                rightThumb.pointY = point1.sceneY;
            }
        }
        if(point2.pressed){
            if(touchArea.childAt(point2.sceneX,point2.sceneY).objectName === 'leftThumb' && touchPoint1 !== 'leftThumb'){
                touchPoint2 = 'leftThumb';
                leftThumb.pointX = point2.sceneX;
                leftThumb.pointY = point2.sceneY;
            }
            else if(touchArea.childAt(point2.sceneX,point2.sceneY).objectName === 'rightThumb' && touchPoint1 !== 'rightThumb'){
                touchPoint2 = 'rightThumb';
                rightThumb.pointX = point2.sceneX;
                rightThumb.pointY = point2.sceneY;
            }
        }
//        console.log("point 1 = " + touchPoint1 + " point 2 = " + touchPoint2);
    }


    MultiPointTouchArea {
            id: touchArea
            anchors.fill: parent
            mouseEnabled: false
            touchPoints: [
                TouchPoint { id: point1 },
                TouchPoint { id: point2 }
            ]
            onPressed: {
                pressHandler();
            }
            onUpdated: {
                //pressHandler();
                if(touchPoint1 === 'leftThumb'){
                    leftThumb.pointX = point1.x;
                    leftThumb.pointY = point1.y;
                }
                else if(touchPoint1 === 'rightThumb'){
                    rightThumb.pointX = point1.x;
                    rightThumb.pointY = point1.y;
                }
                if(touchPoint2 === 'leftThumb'){
                    leftThumb.pointX = point2.x;
                    leftThumb.pointY = point2.y;
                }
                else if(touchPoint2 === 'rightThumb'){
                    rightThumb.pointX = point2.x;
                    rightThumb.pointY = point2.y;
                }
//                console.log("Updating");
//                console.log("Point 1 Scene" + point1.sceneX +" "+ point1.sceneY);
//                console.log("Point 2 Scene" + point2.sceneX +" "+ point2.sceneY);
//                console.log("Point 1 Real" + point1.x +" "+ point1.y);
//                console.log("Point 2 Real" + point2.x +" "+ point2.y);
            }
            onReleased: {
                if(point1.pressed){
                    touchPoint2 = '';
//                    console.log("Released point 2");
                }
                else{
                    touchPoint1 = '';
//                    console.log("Released point 1");
                }
            }
            Joystick{
                id:leftThumb
                objectName: "leftThumb"
                anchors.left: parent.left
                anchors.bottom: parent.bottom
            }
            Joystick{
                id:rightThumb
                objectName: "rightThumb"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
    }
}

