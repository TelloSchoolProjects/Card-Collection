import QtQuick 2.13
import QtQuick.Controls 2.13

Flow {
    id: collectionFlow

    property alias cards: repeaterModel.model  // Collection of cards
    property int viewportHeight: 0
    property int viewportY: 0

    property bool collectionButtonVisible: false

    // Signals to emit for comparison and collection
    signal cardFlowLeftCompare(string imageUrl)
    signal cardFlowRightCompare(string imageUrl)

    signal cardEntered;
    signal cardExited;

    property string collectionFlowImageUrl  // URL for the card image (for comparison)
    property int numCardColumns: 4
    flow: Flow.LeftToRight

    Repeater {
        id: repeaterModel

        model: []

        delegate: Item {
            width: collectionFlow.width / numCardColumns
            height: width * 3.5 / 2.5

            property bool isVisible: (y + height) > collectionFlow.viewportY &&
                                     y < (collectionFlow.viewportY + collectionFlow.viewportHeight)

            Image {
                id: cardImage
                visible: parent.isVisible
                source: modelData.imageUrl

                fillMode: Image.PreserveAspectFit
                smooth: true
                sourceSize.width: parent.width
                sourceSize.height: parent.height * 3.5 / 2.5
                anchors.margins: 5
                anchors.fill: parent

                MouseArea {
                    //anchors.fill: parent

                    anchors.fill: cardImage
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    anchors.topMargin: 20
                    anchors.bottomMargin: 20
                    // anchors.rightMargin: cardImage.right - cardImage.width * 0.25;

                    hoverEnabled: true

                    onEntered: {
                        cardEntered();
                        cardImage.scale += .1;
                        z = 1;
                    }
                    onExited: {
                        cardImage.scale -= .1;
                        cardExited();
                        z = 0
                    }
                }
            }

            // Add CompareButton to handle left and right image toggling
            CompareButton {
                anchors.top: parent.top
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.right: parent.right
                width: Math.min(cardImage.width, cardImage.height) * 0.25
                height: width
                opacity: 0.7
                controller: compareController
                cardImageUrl: modelData.imageUrl  // Pass the image URL directly

                // Emit signals from CardFlow on button clicks for comparison
                onLeftCompare: {
                    collectionFlowImageUrl = cardImageUrl
                    collectionFlow.cardFlowLeftCompare(cardImageUrl)
                }

                onRightCompare: {
                    collectionFlowImageUrl = cardImageUrl
                    collectionFlow.cardFlowRightCompare(cardImageUrl)
                }
            }

            // Add CollectionButton to handle adding/removing card to/from collection
            CollectionButton {
                id: collectionButton
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.topMargin: 10
                width: Math.min(cardImage.width, cardImage.height) * 0.25
                height: width
                card: modelData  // Pass only the individual card data
                visible: collectionButtonVisible
                // Handle marking/unmarking of the card for collection
                checked: true // collectionFlow.cards.includes(card)  // Check if the card is already marked

                onCheckedChanged: {
                    console.log("CollectionFlow.CollectionButton.onCheckedChanged");
                    if(!checked){ // used to be checked

                        var removeIndex = -1
                        for(var i = 0; i < collectionFlow.cards.length; i++) {
                            if(card.id === collectionFlow.cards[i].id) {
                                removeIndex = i;
                            }
                        }

                        if (removeIndex !== -1) {
                            console.log("splicing collectionFlow.cards[index]: " + collectionFlow.cards[removeIndex].name + ": " + collectionFlow.cards[removeIndex].id);
                            collectionFlow.cards.splice(removeIndex, 1)
                            // Iterate over the model and assign to markedCards
                                for (var i = 0; i < collectionFlow.cards.length; i++) {
                                    processedCards.push(collectionFlow.cards[i]);  // Get data from model and push to markedCards
                                }

                        }

                    }
                    // if (checked) {
                    //     // Mark card for collection (add to internal cards list)
                    //     if (!collectionFlow.cards.includes(card)) {
                    //         collectionFlow.cards.push(card)
                    //     }
                    // } else {
                    //     // Unmark card from collection (remove from internal cards list)
                    //     var index = collectionFlow.cards.indexOf(card)
                    //     if (index !== -1) {
                    //         collectionFlow.cards.splice(index, 1)
                    //     }
                    // }
                }

            }

        }
    }
}
