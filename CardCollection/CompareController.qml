import QtQuick

QtObject {
    id: controller

    property var leftCompareButton: null
    property var rightCompareButton: null

    function setLeft(button) {
        if (leftCompareButton) {
            leftCompareButton.deactivateLeft();  // Deactivate previous left compare
        }
        leftCompareButton = button;
        leftCompareButton.activateLeft();
    }

    function setRight(button) {
        if (rightCompareButton) {
            rightCompareButton.deactivateRight();  // Deactivate previous right compare
        }
        rightCompareButton = button;
        rightCompareButton.activateRight();
    }

    function clearLeft() {
        if (leftCompareButton) {
            leftCompareButton.deactivateLeft();
            leftCompareButton = null;
        }
    }

    function clearRight() {
        if (rightCompareButton) {
            rightCompareButton.deactivateRight();
            rightCompareButton = null;
        }
    }
}
