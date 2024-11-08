import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick3D
import Qt5Compat.GraphicalEffects 1.0

Flow {
    id: collectionFlow

    property alias cards: repeaterModel.model
    property int viewportHeight: 0
    property int viewportY: 0

    Repeater {
        id: repeaterModel
        model: []

        delegate: Item {
            width: collectionFlow.width / 1  // Maintain aspect ratio without forcing layout
            height: width * 3.5 / 2.5

            property bool isVisible: (y + height) > collectionFlow.viewportY &&
                                     y < (collectionFlow.viewportY + collectionFlow.viewportHeight)

            Image {
                visible: parent.isVisible
                source: modelData.imageUrl
                fillMode: Image.PreserveAspectFit
                anchors.margins: 5
                anchors.fill: parent
            }

            Component.onCompleted: {
                console.log("Item index:", index, "y position:", y, "isVisible:", isVisible)
            }
        }
    }

    Item {
        id: __materialLibrary__
    }
}
