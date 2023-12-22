import QtQuick 2.5
import QtQuick.Window 2.2

Item {
    id: joystick

    //手柄偏移度（横向纵向都是-1~+1）
    property point pointInput
    //property double inputX
    //property double inputY
    property int nFixPrecision: 5  //偏移度的精度(先乘取整再除）

    property bool pressed: false   //是否按下
    property alias fingerOutOfBounds: multiPointTouchArea.fingerOutOfBounds


    implicitWidth: 20 * Screen.pixelDensity
    implicitHeight: 20 * Screen.pixelDensity


    //外圆
    Rectangle {
        anchors.fill: parent
        border.width: 2 * Screen.pixelDensity
        border.color: "#1e1b18"
        radius: width / 2
    }

    //内圆
    Rectangle {
        id: handle

        width: 6 * Screen.pixelDensity
        height: 6 * Screen.pixelDensity

        anchors.centerIn: joystick

        /*anchors.onHorizontalCenterOffsetChanged: {
            let dx = anchors.horizontalCenterOffset / (joystick.width / 2 - handle.width / 2);
            //if(joystick.pointInput.x !== Math.round(dx * nFixPrecision) / nFixPrecision)
                joystick.pointInput.x = Math.round(dx * nFixPrecision) / nFixPrecision;
        }
        anchors.onVerticalCenterOffsetChanged: {
            let dy = anchors.verticalCenterOffset / (joystick.height / 2 - handle.height / 2);
            //if(joystick.pointInput.y !== Math.round(dy * nFixPrecision) / nFixPrecision)
                joystick.pointInput.y = Math.round(dy * nFixPrecision) / nFixPrecision;
        }*/

        radius: width / 2
        color: "#1e1b18"
    }

    //返回动画
    NumberAnimation {
        id: returnAnimation
        target: handle.anchors
        properties: "horizontalCenterOffset,verticalCenterOffset"
        to: 0
        duration: 200
        easing.type: Easing.OutSine
    }

    MultiPointTouchArea {
        id: multiPointTouchArea

        touchPoints : [
            TouchPoint { id: mouseArea }
        ]

        anchors.fill: parent
        property point pointStart   //按下的坐标
        property bool fingerOutOfBounds:    //内圆是否超出了边界（注意不是手指超出了外面）
            (mouseArea.x - pointStart.x) * (mouseArea.x - pointStart.x) + (mouseArea.y-pointStart.y) * (mouseArea.y-pointStart.y) < (joystick.width / 2 - handle.width / 2) * (joystick.width / 2 - handle.width / 2)

        onPressed: {
            //保存按下的坐标
            pointStart.x = mouseArea.x
            pointStart.y = mouseArea.y

            //里圆位置
            //handle.anchors.horizontalCenterOffset = mouseArea.x - width / 2
            //handle.anchors.verticalCenterOffset = mouseArea.y - height / 2

            joystick.pressed = true;
        }

        onUpdated: {
            //超出圈外
            if (fingerOutOfBounds) {
                _private.updateHandlePosition(mouseArea.x - pointStart.x, mouseArea.y - pointStart.y);
            }
            else {
                var angle = Math.atan2(mouseArea.y - pointStart.y, mouseArea.x - pointStart.x)

                _private.updateHandlePosition(Math.cos(angle) * (joystick.width / 2 - handle.width / 2), Math.sin(angle) * (joystick.width / 2 - handle.width / 2));

            }
        }

        onReleased: {
            returnAnimation.start()

            joystick.pressed = false;
        }
    }

    QtObject {
        id: _private

        function updateHandlePosition(xOffset, yOffset) {
            let dx = (xOffset) / (joystick.width / 2 - handle.width / 2);
            //if(joystick.pointInput.x !== Math.round(dx * nFixPrecision) / nFixPrecision)
                joystick.pointInput.x = Math.round(dx * nFixPrecision) / nFixPrecision;

            let dy = (yOffset) / (joystick.height / 2 - handle.height / 2);
            //if(joystick.pointInput.y !== Math.round(dy * nFixPrecision) / nFixPrecision)
                joystick.pointInput.y = Math.round(dy * nFixPrecision) / nFixPrecision;


            handle.anchors.horizontalCenterOffset = xOffset;
            handle.anchors.verticalCenterOffset = yOffset;
        }
    }
}
