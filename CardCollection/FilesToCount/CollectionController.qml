import QtQuick

QtObject {
    id: controller

    property var collectionCards: []  // Array to store collected cards

    signal addToCollection(string imageUrl)
    signal removeFromCollection(string imageUrl)

    function addToCollection(button) {
        collectionCards.push(button.cardImageUrl);  // Add card to collection
        console.log("Added to collection:", button.cardImageUrl);
    }

    function removeFromCollection(button) {
        var index = collectionCards.indexOf(button.cardImageUrl);
        if (index !== -1) {
            collectionCards.splice(index, 1);  // Remove card from collection
            console.log("Removed from collection:", button.cardImageUrl);
        }
    }
}
