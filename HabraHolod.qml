import QtQuick 1.0
import Qt3D 1.0

Rectangle {
    color: "black"
    width: 400
    height: 600

    Viewport {
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                fullScene.openDoor();
            }
        }

        camera: Camera {
            id: viewCamera
            eye: Qt.vector3d(15,10,40)
            center: Qt.vector3d(-2,10,0)
        }

        Item3D {
            id: fullScene
            function openDoor()
            {
                doorOpenAndClose.loops = 1;
                doorOpenAndClose.start();

                ufoFlyOutAndTeleportBack.loops = 1;
                ufoFlyOutAndTeleportBack.start();
            }

            Mesh { id: refrigirator; source: "refr.3ds" }
            Mesh { id: ufo; source: "ufo.3ds" }
            Mesh { id: bottom_door; source: "door.3ds" }

            Item3D { mesh: refrigirator }
            Item3D { mesh: ufo; transform: [ufoFlyOut]}
            Item3D { mesh: bottom_door;  transform: [doorOpen] }

            // ------------------ Transform + Animations ------------------
            Rotation3D {
                id: doorOpen
                angle: 0
                axis: Qt.vector3d(0, 1, 0)
                origin: Qt.vector3d(-3, 0,  0)
            }

            Rotation3D {
                id: ufoFlyOut
                angle: 0
                axis: Qt.vector3d(0, 3, -1)
                origin: Qt.vector3d(10, 0,  0)
            }

            SequentialAnimation { id: doorOpenAndClose;
                NumberAnimation { target: doorOpen; property: "angle"; from: 0; to : -80.0; duration: 800; easing.type: Easing.OutBounce}
                NumberAnimation { target: doorOpen; property: "angle"; from: -80; to : 0.0; duration: 1200; easing.type: Easing.OutCubic}
            }

            SequentialAnimation { id: ufoFlyOutAndTeleportBack;
                NumberAnimation { target: ufoFlyOut; property: "angle"; from: 0; to : 100.0; duration: 1700; easing.type: Easing.OutCurve}
                NumberAnimation { target: ufoFlyOut; property: "angle"; from: 100; to : 0.0; duration: 0; easing.type: Easing.OutCubic}
            }
        }
    }
}
