import QtQuick 2.14
import Qt3D.Core 2.14
import Qt3D.Render 2.14
import Qt3D.Input 2.14
import Qt3D.Extras 2.14

Entity {
    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                camera: camera
                clearColor: "black"
            }
        },
        InputSettings { }
    ]

    property int cellSize: 100

    Component.onCompleted: {
        camera.panAboutViewCenter(45)
        camera.tiltAboutViewCenter(45)
    }

    CustomOrbitCameraController { }

    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        nearPlane: 10
        farPlane: 1000
        position: Qt.vector3d(0, 0, cellSize * 9)
        upVector: Qt.vector3d(0, 1, 0)
        viewCenter: Qt.vector3d(0, 0, 0)
    }

    HelperOverlay { }

    NodeInstantiator {
        model: cubeModel

        CubeCell {
            matrix: role_matrix
            model: role_sideList
        }
    }
}
