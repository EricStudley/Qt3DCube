import QtQuick 2.14
import Qt3D.Core 2.14
import Qt3D.Extras 2.14

import Cube 1.0

Entity {
    id: cubeCell
    components: [material, mesh, transform]

    property alias model: model.model

    property matrix4x4 matrix

    Connections {
        target: cubeModel

        function onRotateCell(cellIndex, axis, instant) {
            if (index === cellIndex) {

                if (instant) {
                    transform.matrix = cubeCell.matrix
                }
                else {
                    transform.rotationAxis = axis
                    animation.restart()
                }
            }
        }
    }

    SequentialAnimation {
        id: animation

        property matrix4x4 initialPosition: Qt.matrix4x4()

        ScriptAction { script: animation.initialPosition = transform.matrix }

        PropertyAnimation {
            target: transform
            property: "rotationAngle"
            from: 0
            to: 90
            duration: 100
        }

        ScriptAction { script: transform.matrix = cubeCell.matrix }
    }

    PhongMaterial { id: material; shininess: .5; ambient: "#000000"; diffuse: "#000000"; specular: "#000000" }

    CuboidMesh {
        id: mesh
        xExtent: cellSize - 1
        yExtent: cellSize - 1
        zExtent: cellSize - 1
    }

    Transform {
        id: transform

        Component.onCompleted: matrix = parent.matrix

        property vector3d rotationAxis: Qt.vector3d(0, 0, 0)

        property real rotationAngle: 0

        onRotationAngleChanged: {
            matrix = animation.initialPosition
            rotateAroundAxis(rotationAngle, rotationAxis)
        }

        function rotateAroundAxis(angle, axis) {
            var m = Qt.matrix4x4()
            m.rotate(angle, axis)
            matrix = m.times(matrix)
        }
    }

    NodeInstantiator {
        id: model

        CubeFace {
            x:       switch (modelData) {
                     case Side.Right: return cellSize / 2
                     case Side.Left:  return -(cellSize / 2)
                     default: return 0
                     }
            xExtent: switch (modelData) {
                     case Side.Up:    return cellSize
                     case Side.Front:  return cellSize
                     case Side.Right:  return 1
                     case Side.Back:   return cellSize
                     case Side.Left:   return 1
                     case Side.Down: return cellSize
                     }

            y:       switch (modelData) {
                     case Side.Up:    return cellSize / 2
                     case Side.Down: return -(cellSize / 2)
                     default: return 0
                     }
            yExtent: switch (modelData) {
                     case Side.Up:    return 1
                     case Side.Front:  return cellSize
                     case Side.Right:  return cellSize
                     case Side.Back:   return cellSize
                     case Side.Left:   return cellSize
                     case Side.Down: return 1
                     }

            z:       switch (modelData) {
                     case Side.Front: return cellSize / 2
                     case Side.Back:  return -(cellSize / 2)
                     default: return 0
                     }
            zExtent: switch (modelData) {
                     case Side.Up:    return cellSize
                     case Side.Front:  return 1
                     case Side.Right:  return cellSize
                     case Side.Back:   return 1
                     case Side.Left:   return cellSize
                     case Side.Down: return cellSize
                     }
            color:   switch (modelData) {
                     case Side.Up:    return Color.White
                     case Side.Front:  return Color.Green
                     case Side.Right:  return Color.Red
                     case Side.Back:   return Color.Blue
                     case Side.Left:   return Color.Orange
                     case Side.Down: return Color.Yellow
                     }
        }
    }
}
