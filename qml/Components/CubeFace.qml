import Qt3D.Core 2.14
import Qt3D.Extras 2.14

import Cube 1.0

Entity {
    id: cube
    components: [material, cubeMesh, transform]

    property real x: 0
    property real xExtent: 0

    property real y: 0
    property real yExtent: 0

    property real z: 0
    property real zExtent: 0

    property int color: Color.White

    property PhongMaterial material: {
        switch (color) {
        case Color.White:  return whiteMaterial
        case Color.Green:  return greenMaterial
        case Color.Red:    return redMaterial
        case Color.Blue:   return blueMaterial
        case Color.Orange: return orangeMaterial
        case Color.Yellow: return yellowMaterial
        }
    }

    PhongMaterial { id: whiteMaterial;  shininess: .5; ambient: "#E4E2E5"; diffuse: "#FFFFFF"; specular: "#D4CED2" }
    PhongMaterial { id: greenMaterial;  shininess: .5; ambient: "#007325"; diffuse: "#45BB6D"; specular: "#046E2E" }
    PhongMaterial { id: redMaterial;    shininess: .5; ambient: "#CF292D"; diffuse: "#FD595A"; specular: "#CA171B" }
    PhongMaterial { id: blueMaterial;   shininess: .5; ambient: "#0066bA"; diffuse: "#0097e8"; specular: "#005aa3" }
    PhongMaterial { id: orangeMaterial; shininess: .5; ambient: "orange"; diffuse: "orange"; specular: "orange" }
    PhongMaterial { id: yellowMaterial; shininess: .5; ambient: "#ebbe01"; diffuse: "#fff001"; specular: "#ffcc00" }

    CuboidMesh {
        id: cubeMesh
        xExtent: parent.xExtent === 1 ? parent.xExtent : parent.xExtent - 5
        yExtent: parent.yExtent === 1 ? parent.yExtent : parent.yExtent - 5
        zExtent: parent.zExtent === 1 ? parent.zExtent : parent.zExtent - 5
    }

    Transform {
        id: transform
        translation: Qt.vector3d(x, y, z)
    }
}
