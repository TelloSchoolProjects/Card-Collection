// main_refactor.qml
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
    title: qsTr("Card Collection")

    // Collection State - Single Source of Truth
    property var collectionState: []
    property string updateSource: ""

    // Navigation State
    property int selectedTabIndex: 1

    // Theme Colors
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

    // Collection Management Functions
    function handleAddToCollection(card, source) {
        updateSource = source
        backendController.request_collection_update(card.id, true)
    }
    
    function handleRemoveFromCollection(card, source) {
        updateSource = source
        backendController.request_collection_update(card.id, false)
    }

        // Main Layout Container
    Rectangle {
        id: mainContainer
        color: borderColor
        anchors.fill: parent

        // Navigation TabBar
        TabBar {
            id: tabBar
            width: parent.width
            height: 35
            currentIndex: selectedTabIndex

            TabButton {
                id: searchTab
                text: qsTr("Search")
                width: implicitWidth
                font.pointSize: 12
                font.styleName: "Bold Italic"
            }

            TabButton {
                id: discoverTab
                text: qsTr("Discover")
                width: implicitWidth
                font.pointSize: 12
                font.styleName: "Bold Italic"
            }

            TabButton {
                id: collectionTab
                text: qsTr("Collection")
                width: implicitWidth
                font.pointSize: 12
                font.styleName: "Bold Italic"
            }
        }

        // Page Stack
        StackLayout {
            id: stackLayout
            width: 700
            height: 615
            currentIndex: tabBar.currentIndex
            anchors {
                top: tabBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Search {
                id: searchPage
                currentCollection: window.collectionState

                onRequestAddToCollection: (card, source) => {
                    window.handleAddToCollection(card, source)
                }
                onRequestRemoveFromCollection: (card, source) => {
                    window.handleRemoveFromCollection(card, source)
                }
            }

            Discover {
                id: discoverPage
                currentCollection: window.collectionState

                onRequestAddToCollection: (card, source) => {
                    window.handleAddToCollection(card, source)
                }
                onRequestRemoveFromCollection: (card, source) => {
                    window.handleRemoveFromCollection(card, source)
                }
            }

            Collection {
                id: collectionPage
                cards: window.collectionState

                onRequestAddToCollection: (card, source) => {
                    window.handleAddToCollection(card, source)
                }
                onRequestRemoveFromCollection: (card, source) => {
                    window.handleRemoveFromCollection(card, source)
                }
            }
        }
    }

        // Backend Connections
    Connections {
        target: backendController
        
        function onUpdateResults(response) {
            const data = JSON.parse(response)
            if (!data.error) {
                collectionState = data
                
                // Update pages except source
                if (updateSource !== "search") {
                    searchPage.updateCollection(collectionState)
                }
                if (updateSource !== "discover") {
                    discoverPage.updateCollection(collectionState)
                }
                if (updateSource !== "collection") {
                    collectionPage.updateCollection(collectionState)
                }
                
                updateSource = ""
            }
        }

        function onLoadResults(response) {
            const data = JSON.parse(response)
            if (!data.error) {
                collectionState = data
                searchPage.updateCollection(collectionState)
                discoverPage.updateCollection(collectionState)
                collectionPage.updateCollection(collectionState)
            }
        }
    }
} // close Window