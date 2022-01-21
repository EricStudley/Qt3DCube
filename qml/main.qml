import QtQuick 2.14
import QtQuick.Scene3D 2.14
import QtQuick.Controls 2.14

import "Components"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    color: "black"
    title: qsTr("Rubix Qube")

    property bool helper: true

    signal rotateCamera(int side)

    Shortcuts { }

    Scene3D {
        anchors { fill: parent }
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio
        aspects: ["input", "logic"]
        multisample: true

        RubiksCube { }
    }

    Button {
        text: "Shuffle"

        onClicked: cubeController.shuffleCube()
    }

    Button {
        enabled: !cubeController.processingCommands
        anchors { right: parent.right }
        text: "Solve"

        onClicked: cubeController.solveCube()
    }
}
