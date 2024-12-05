import QtQuick 2.13
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Window 2.15
import QtQuick.Controls.Fusion 2.15


Window {
    id: window
    width: 700
    height: 650
    minimumWidth: 700
    minimumHeight: 650
    maximumWidth: 700
    maximumHeight: 650

    visible: true
    color: borderColor

    title: qsTr("Card Collection")


    // property int selectedIndex: 0
    // property var cards: [] // List of card objects
    property int selectedTabIndex: 1

    // Define color scheme properties
    property color primaryColor: "#c80d0d"
    property color blockBG: "#ff0000"
    property color blockBorderHightlight: "#ee0000"
    property color bezelColor: "#b2b2b2"
    property color bezelBorderColor: "#616161"
    property color screenColor: "#02d20b"
    property color screenShadeColor: "#128c17"
    property color screenHighlightColor: "#25fb2e"
    property color textColor: "#095f0c"
    property color dropTextColor: "#c5002a02"
    property color borderColor: "#6c0101"
    property color dropBorderColor: "#25fb2e"


    //onActiveFocusItemChanged: console.log(activeFocusItem)

    // Save list property to store tuples
    property var saveList: []
    property var saveCards: []
    property var processedCards: []
    property var markedCards: []

    // // Compile the save list based on card data
    // function compileSaveList() {
    //     window.saveList = [] // Initialize the save list
    //     console.log("Debug: Starting to compile saveList...");

    //     console.log("window.saveCards.length = " + window.saveCards.length);
    //     for (var i = 0; i < window.saveCards.length; i++) {
    //         var card = window.saveCards[i];  // Access card at index i
    //         var cardIdTuple = ["", "id", card.id];  // Create tuple for card
    //         window.saveList.push(cardIdTuple);  // Push the tuple into the save list
    //         console.log("Debug: cardIdTuple created:", cardIdTuple);
    //     }

    //     console.log("Debug: Final saveList:", saveList);

    //     //backendController.request_save_collection(window.saveList);
    // }

    // Connections {
    //     target: backendController
    //     function onSaveResults(response) {

    //         console.log("backendController called back after saving with response: " + response);

    //         // for(var i = 0; i < cards.length; i++) {
    //         //     //console.log((i+1) + ": " + cards[i].imageUrl);
    //         // }


    //     }
    // }

    onProcessedCardsChanged: {

        discoverPage.loadedCards = window.processedCards
        searchPage.loadedCards = window.processedCards
        // console.log("Window.onProcessedCardsChanged: discoverPage.loadedCards now length: " + discoverPage.loadedCards.length);
    }




    // Component.onDestruction: {
    //     console.log("Window destruction Beginning!")
    //     console.log("Debug: saveCards before destruction:");
    //     for(var i = 0; i < window.saveCards.length; i++) {
    //         console.log(window.saveCards[i].name)
    //     }

    //     console.log("Debug: saveList before Window destruction:", window.saveList);
    //     backendController.request_save_collection(window.saveList);
    //     console.log("Window request backendController.request_save.");
    // }


    Rectangle {
        id: columnLayout1
        color: "#ffffff"
        anchors.fill: parent

        // TabBar for navigation
        TabBar {
            id: tabBar
            Layout.fillWidth: true
            currentIndex: selectedTabIndex
            width: parent.width
            Layout.preferredHeight: parent.height * 0.08
            height: 35

            TabButton {
                opacity: 1
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                // Set button background color based on the selected index
                palette {
                    button: selectedTabIndex === 0 ? borderColor : "#c80d0d" // Dark red for selected, light red for unselected
                }

                hoverEnabled: true

                ToolTip.delay: 800
                ToolTip.timeout: 5000
                ToolTip.visible: hovered
                ToolTip.text: qsTr("Search by Set, Type, and Name.")

                // Use a Text element for the label
                Text {
                    text: "Search"
                    font.pointSize: 14
                    font.styleName: "Bold Italic"
                    color: selectedTabIndex
                           === 0 ? "#ffffff" : "#000000" // White for selected, black for unselected
                    anchors.centerIn: parent
                }

                onClicked: {
                    selectedTabIndex = 0
                    stackLayout.currentIndex = selectedTabIndex
                }
            }

            TabButton {
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                // Set button background color based on the selected index
                palette {
                    button: selectedTabIndex === 1 ? borderColor : "#c80d0d" // Dark red for selected, light red for unselected
                }

                hoverEnabled: true
                ToolTip.delay: 800
                ToolTip.timeout: 5000
                ToolTip.visible: hovered
                ToolTip.text: qsTr("Discover a random card, optionally filtered by Set and Type.")

                Text {
                    text: "Discover"
                    font.pointSize: 14
                    font.styleName: "Bold Italic"
                    color: selectedTabIndex
                           === 1 ? "#ffffff" : "#000000" // White for selected, black for unselected
                    anchors.centerIn: parent


                }

                onClicked: {
                    selectedTabIndex = 1
                    stackLayout.currentIndex = selectedTabIndex
                }
            }

            TabButton {
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                // Set button background color based on the selected index
                palette {
                    button: selectedTabIndex === 2 ? borderColor : "#c80d0d" // Dark red for selected, light red for unselected
                }

                hoverEnabled: true
                ToolTip.delay: 800
                ToolTip.timeout: 5000
                ToolTip.visible: hovered
                ToolTip.text: qsTr("Collect your favorite cards found in Search and Discover.")
                Text {
                    text: "Collection"
                    font.pointSize: 14
                    font.styleName: "Bold Italic"
                    color: selectedTabIndex
                           === 2 ? "#ffffff" : "#000000" // White for selected, black for unselected
                    anchors.centerIn: parent
                }

                onClicked: {
                    selectedTabIndex = 2
                    stackLayout.currentIndex = selectedTabIndex
                }
            }
        }

        StackLayout {
            id: stackLayout
            width: 700
            height: 615
            visible: true
            anchors.top: tabBar.bottom
            anchors.topMargin: 0
            z: 1
            Layout.fillHeight: true
            Layout.fillWidth: true
            currentIndex: selectedTabIndex
            clip: false

            Search {
                id: searchPage
                width: 700
                height: 615
                Layout.maximumHeight: 615
                Layout.maximumWidth: 700
                Layout.minimumHeight: 615
                Layout.minimumWidth: 700
                Layout.preferredHeight: 615
                Layout.preferredWidth: 700
                activeFocusOnTab: true

                onCardsChanged: {

                }

                onUpdateMarkedCards: {
                    window.markedCards = searchPage.markedCards;
                    collectionPage.markedCards = window.markedCards;
                }

                }

                    Discover {
                        id: discoverPage
                        width: 700
                        height: 615
                        Layout.maximumHeight: 615
                        Layout.maximumWidth: 700
                        Layout.minimumHeight: 615
                        Layout.minimumWidth: 700
                        Layout.preferredHeight: 615
                        Layout.preferredWidth: 700
                        activeFocusOnTab: true


                        onUpdateMarkedCards: {

                            // Log specific properties of each card object
                            // for (var i = 0; i < discoverPage.markedCards.length; i++) {
                            //     var card = discoverPage.markedCards[i];
                            //     console.log("Window: card marked - id:", card.id, "name:", card.name); // Example
                            // }

                            window.markedCards = discoverPage.markedCards;
                            collectionPage.markedCards = window.markedCards;


                        }

                    }


                    Collection {
                        id: collectionPage
                        width: 700
                        Layout.maximumHeight: 615
                        Layout.maximumWidth: 700
                        Layout.minimumHeight: 615
                        Layout.minimumWidth: 700
                        Layout.preferredHeight: 615
                        Layout.preferredWidth: 700
                        activeFocusOnTab: true


                        onProcessedCardsChanged: {

                            window.processedCards = collectionPage.processedCards
                        }


                    }
                }
            }
        }


