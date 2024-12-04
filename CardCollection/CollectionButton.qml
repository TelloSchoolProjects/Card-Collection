import QtQuick 2.13
import QtQuick.Controls 2.13

Button {
    id: collectionButton
    width: 100
    height: 100
    clip: true  // Property to store the card data
    checkable: true

    property real pressedOpacity: 1
    property real unpressedOpacity: 0.5

    // Listen for changes in the checked state and trigger necessary actions
    onCheckedChanged: {

        if(checked) checkedImage.opacity = pressedOpacity
        else checkedImage.opacity = unpressedOpacity
    }

    Rectangle {
        id: rectangle
        x: -50
        y: -95
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
            x: -25
            y: 77
            width: 250
            height: 250
            opacity: 0.5
            source: "https://images.pokemontcg.io/g1/65_hires.png"
            sourceSize.height: 400
            sourceSize.width: 400
            fillMode: Image.PreserveAspectCrop
            scale: 1
        }
    }
}
