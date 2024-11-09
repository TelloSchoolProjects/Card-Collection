import QtQuick 2.13
import QtQuick.Controls 2.13

Button {
    id: collectionButton
   // text: "Mark for collection"  // You can replace this with an icon if preferred

    property var alreadyMarkedCards: []
    // Checkable state
    //property bool checked: false  // Track whether the card is marked

    property var card  // Property to store the card data
    checkable: true

    // Change the visual appearance of the button based on the checked state
    background: Rectangle {
        color: checked ? "lightgreen" : "lightblue"
        radius: 5
    }

    // Handle the click to toggle the checked state
    onClicked: {
        //checked = !checked  // Toggle the checked state when clicked

    }

    // Listen for changes in the checked state and trigger necessary actions
    onCheckedChanged: {
        if (checked) {
            // Mark the card for collection when the button is checked
            console.log("Card marked:", card);
        } else if(!checked){
            // Unmark the card from collection when unchecked
            console.log("Card unmarked:", card);
        }
    }
}
