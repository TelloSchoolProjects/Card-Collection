// CollectionButton.qml
import QtQuick 2.13
import QtQuick.Controls 2.13

Button {
    id: collectionButton

    // Replace cardId with full card object
    property var card: null
    property bool syncing: false
    property real pressedOpacity: 1
    property real unpressedOpacity: 0.5

    // Updated signals to pass full card
    signal requestAddToCollection(var card)
    signal requestRemoveFromCollection(var card)

    width: 100
    height: 100
    clip: true
    checkable: true

    // Handle state changes with full card
    onCheckedChanged: {
        if (!syncing && card) {
            if (checked) {
                requestAddToCollection(card)
            } else {
                requestRemoveFromCollection(card)
            }
        }
    }

    Rectangle {
        id: rectangle
        width: 200
        height: 200
        opacity: 1
        color: "#ffffff"
        radius: 0
        border.width: 0
        z: 0
        clip: true

        Image {
            id: checkedImage
            width: 250
            height: 250
            opacity: checked ? pressedOpacity : unpressedOpacity
            source: "https://images.pokemontcg.io/g1/65_hires.png"
            sourceSize.height: 400
            sourceSize.width: 400
            fillMode: Image.PreserveAspectCrop
        }
    }
}