import QtQuick 2.13
import QtQuick.Controls 2.13

Button {
    id: collectionButton
    // text: "Mark for collection"  // You can replace this with an icon if preferred

    property bool oldCheckedStatus: false
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
        // var cardExists = false;
        // for(var i = 0; i < markedCards.length; i++) {
        //     if(alreadyMarkedCards[i].id === card.id) {
        //         cardExists = true;
        //     }
        // }

        // if(!cardExists) {
        //     if(checked) console.log("Card Doesn't exist but is already checked somehow");
        //     else if (!checked) console.log("Card doesn't exist and is rightly unchecked");
        // }
        // else if(cardExists) {
        //     if(checked) console.log("Card exists and is alrady checked as it should be");
        //     else if (!checked) console.log("Unchecked but should because it already exists");
        // }

        // if (checked) {
        //     // Mark the card for collection when the button is checked
        //     console.log("Card marked:", card);
        // } else if(!checked){
        //     // Unmark the card from collection when unchecked
        //     console.log("Card unmarked:", card);
        // }
    }

    // Listen for changes in the checked state and trigger necessary actions
    onCheckedChanged: {
        // var cardExists = false;
        // for(var i = 0; i < markedCards.length; i++) {
        //     if(alreadyMarkedCards[i].id === card.id) {
        //         cardExists = true;
        //         console.log("Card found in alreadyMarkedCards:", card.id);
        //     }
        // }


        // if(cardExists && oldCheckedStatus) { // if card exists and was already checked
        //     console.log("Card already marked and checked:", card.id);
        // }
        // else if(cardExists && !oldCheckedStatus) { // if card exists and was not already checked
        //     console.log("Card found but wasn't checked, now checking:", card.id);
        // }
        // else if(!cardExists && oldCheckedStatus) { // if card doesn't exist and was already checked
        //     console.log("Card was checked but doesn't exist in the list:", card.id);
        // }
        // else if(!cardExists && !oldCheckedStatus) { // if card doesn't exist and wasn't already checked
        //     console.log("Card doesn't exist and isn't checked:", card.id);
        // }

        // oldCheckedStatus = !oldCheckedStatus;
    }


        // oldCheckedStatus = !oldCheckedStatus


        // if(!cardExists) {



        // }
    }
