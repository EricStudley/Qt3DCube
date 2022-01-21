import QtQuick 2.14

import Cube 1.0

Item {

    Shortcut { sequence: "H"; onActivated: helper = !helper }

    Shortcut { sequence: "U";      onActivated: cubeController.rotateCubeSide(Side.Up, true) }
    Shortcut { sequence: "Alt+U";  onActivated: cubeController.rotateCubeSide(Side.Up, false) }
    Shortcut { sequence: "Ctrl+U"; onActivated: rotateCamera(Side.Up) }

    Shortcut { sequence: "F";      onActivated: cubeController.rotateCubeSide(Side.Front, true) }
    Shortcut { sequence: "Alt+F";  onActivated: cubeController.rotateCubeSide(Side.Front, false) }
    Shortcut { sequence: "Ctrl+F"; onActivated: rotateCamera(Side.Front) }

    Shortcut { sequence: "R";      onActivated: cubeController.rotateCubeSide(Side.Right, true) }
    Shortcut { sequence: "Alt+R";  onActivated: cubeController.rotateCubeSide(Side.Right, false) }
    Shortcut { sequence: "Ctrl+R"; onActivated: rotateCamera(Side.Right) }

    Shortcut { sequence: "B";      onActivated: cubeController.rotateCubeSide(Side.Back, true) }
    Shortcut { sequence: "Alt+B";  onActivated: cubeController.rotateCubeSide(Side.Back, false) }
    Shortcut { sequence: "Ctrl+B"; onActivated: rotateCamera(Side.Back) }

    Shortcut { sequence: "L";      onActivated: cubeController.rotateCubeSide(Side.Left, true) }
    Shortcut { sequence: "Alt+L";  onActivated: cubeController.rotateCubeSide(Side.Left, false) }
    Shortcut { sequence: "Ctrl+L"; onActivated: rotateCamera(Side.Left) }

    Shortcut { sequence: "D";      onActivated: cubeController.rotateCubeSide(Side.Down, true) }
    Shortcut { sequence: "Alt+D";  onActivated: cubeController.rotateCubeSide(Side.Down, false) }
    Shortcut { sequence: "Ctrl+D"; onActivated: rotateCamera(Side.Down) }
}
