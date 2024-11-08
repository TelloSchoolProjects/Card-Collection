import QtQuick 2.13
import QtQuick.Controls 2.2
import QtQuick.Layouts
import QtQuick.Controls.Fusion 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: _root
    width: 100
    height: 100

    property QtObject controller  // Reference to CompareController

    function toggleImages(mouse) {
        if (mouse.button === Qt.LeftButton) {
            if (!leftHalfImage.visible) {
                controller.setLeft(_root);  // Set this button as the active left
            } else {
                controller.clearLeft();  // Clear left compare if clicked again
            }
        } else if (mouse.button === Qt.RightButton) {
            if (!rightHalfImage.visible) {
                controller.setRight(_root);  // Set this button as the active right
            } else {
                controller.clearRight();  // Clear right compare if clicked again
            }
        }
    }

    // Activate and deactivate image visibility from controller
    function activateLeft() {
        leftHalfImage.visible = true;
    }

    function deactivateLeft() {
        leftHalfImage.visible = false;
    }

    function activateRight() {
        rightHalfImage.visible = true;
    }

    function deactivateRight() {
        rightHalfImage.visible = false;
    }

    Button {
        width: 100
        height: 100
        opacity: 0.5
        anchors.fill: parent

        MouseArea {
            id: clickArea
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                _root.toggleImages(mouse);  // Call toggle function in the parent Item
            }
        }
    }

    Image {
        id: leftHalfImage
        x: -100
        y: -100
        width: 300
        height: 300
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: "topBall.png"
        fillMode: Image.PreserveAspectFit
        scale: 0.32
        rotation: 90
    }

    Image {
        id: rightHalfImage
        x: -100
        y: -100
        width: 300
        height: 300
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: "bottomBall.png"
        fillMode: Image.PreserveAspectFit
        scale: 0.32
        rotation: -90
    }
}
