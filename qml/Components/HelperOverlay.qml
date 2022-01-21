import QtQuick 2.14
import Qt3D.Core 2.14
import Qt3D.Extras 2.14

import Cube 1.0

NodeInstantiator {
    model: ListModel {
        ListElement { modelData: Side.Up }
        ListElement { modelData: Side.Front }
        ListElement { modelData: Side.Right }
        ListElement { modelData: Side.Back }
        ListElement { modelData: Side.Left }
        ListElement { modelData: Side.Down }
    }

    Entity {
        components: [textMaterial, textMesh, textTransform]

        property PhongMaterial textMaterial: {
            switch (modelData) {
            default:      return whiteMaterial
            case Side.Up: return blackMaterial
            }
        }

        PhongMaterial { id: whiteMaterial; shininess: .5; ambient: "#E4E2E5"; diffuse: "#FFFFFF"; specular: "#D4CED2" }
        PhongMaterial { id: blackMaterial; shininess: .5; ambient: "#000000"; diffuse: "#000000"; specular: "#000000" }

        ExtrudedTextMesh {
            id: textMesh
            depth: 0.1
            text: switch (modelData) {
                  case Side.Up:    return "U"
                  case Side.Front: return "F"
                  case Side.Right: return "R"
                  case Side.Back:  return "B"
                  case Side.Left:  return "L"
                  case Side.Down:  return "D"
                  }
        }

        Transform {
            id: textTransform
            scale: helper ? cellSize : 0
            rotationX: switch (modelData) {
                       default:        return 0
                       case Side.Up:   return -90
                       case Side.Down: return 90
                       }
            rotationY: switch (modelData) {
                       default:         return 0
                       case Side.Right: return 90
                       case Side.Back:  return 180
                       case Side.Left:  return -90
                       }
            translation: switch (modelData) {
                         case Side.Up:    return Qt.vector3d(-(cellSize / 2), cellSize + (cellSize / 2), (cellSize / 2))
                         case Side.Front: return Qt.vector3d(-(cellSize / 2), -(cellSize / 2), cellSize + (cellSize / 2))
                         case Side.Right: return Qt.vector3d(cellSize + (cellSize / 2), -(cellSize / 2), cellSize / 2)
                         case Side.Back:  return Qt.vector3d(cellSize / 2, -(cellSize / 2), -(cellSize + (cellSize / 2)))
                         case Side.Left:  return Qt.vector3d(-(cellSize + (cellSize / 2)), -(cellSize / 2), -(cellSize / 2))
                         case Side.Down:  return Qt.vector3d(-(cellSize / 2), -(cellSize + (cellSize / 2)), -(cellSize / 2))
                         }
        }
    }
}
