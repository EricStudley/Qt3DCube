import QtQuick
import Qt3D.Input

import Cube 1.0

MouseHandler {
    sourceDevice: MouseDevice { }

    property point mousePoint
    property real pan
    property real tilt

    onPanChanged: camera.panAboutViewCenter(pan)

    onTiltChanged: camera.tiltAboutViewCenter(tilt)

    onPressed: (mouse) => mousePoint = Qt.point(mouse.x, mouse.y)

    onPositionChanged: (mouse) => mouseMove(mouse)

    function mouseMove(mouse) {
        if (mouse.buttons === 1) {
            pan = -(mouse.x - mousePoint.x)
            tilt = (mouse.y - mousePoint.y)
            mousePoint = Qt.point(mouse.x, mouse.y)
        }
    }

    Connections {
        target: root

        function onRotateCamera(side) {
            var position, upVector

            switch (side) {
            case Side.Up:
                position = Qt.vector3d(0, cellSize * 9, 0);
                upVector = Qt.vector3d(0, 0, -1);
                break
            case Side.Down:
                position = Qt.vector3d(0, -(cellSize * 9), 0);
                upVector = Qt.vector3d(0, 0, 1);
                break
            case Side.Front:
                position = Qt.vector3d(0, 0, cellSize * 9);
                upVector = Qt.vector3d(0, 1, 0);
                break
            case Side.Back:
                position = Qt.vector3d(0, 0, -(cellSize * 9));
                upVector = Qt.vector3d(0, 1, 0);
                break
            case Side.Right:
                position = Qt.vector3d(cellSize * 9, 0, 0);
                upVector = Qt.vector3d(0, 1, 0);
                break
            case Side.Left:
                position = Qt.vector3d(-(cellSize * 9), 0, 0);
                upVector = Qt.vector3d(0, 1, 0);
                break
            }

            camera.position = position
            camera.upVector = upVector
        }
    }
}
