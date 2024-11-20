// Search_refactor.qml
import QtQuick 2.13
import QtQuick.Controls 2.2
import QtQuick.Layouts
import QtQuick.Window 2.15
import QtQuick.Controls.Fusion 2.15
import Qt5Compat.GraphicalEffects
import QtQuick3D

Item {
    id: searchPage
    objectName: "searchPage"
    width: 700
    height: 615
    visible: true
    Layout.preferredHeight: 560
    Layout.preferredWidth: 600
    Layout.fillHeight: false
    Layout.fillWidth: false

    // State Properties 
    property int selectedIndex: 0
    property var cards: []  // Search results
    property var cachedSets: []  // For set filtering
    property var currentCollection: []  // Collection state from main.qml
    property var currentCard: cards[selectedIndex]
    property bool isDrawerOpen: false

    // Collection Signals
    signal requestAddToCollection(var card, string source)
    signal requestRemoveFromCollection(var card, string source)

    // Update collection state
    function updateCollection(collection) {
        currentCollection = collection
        if (collectionButton && currentCard) {
            collectionButton.syncing = true
            collectionButton.checked = collection.some(c => c.id === currentCard.id)
            collectionButton.syncing = false
        }
    }

    // Navigation Functions
    function onNextCard() {
        if (selectedIndex < cards.length - 1) {
            selectedIndex++
            updateCardInfo()
            resetViews()
        }
    }

    function onPrevCard() {
        if (selectedIndex > 0) {
            selectedIndex--
            updateCardInfo()
            resetViews()
        }
    }

    // Info Update Functions
    function updateCardInfo() {
        updateAttackInfo()
        updateAbilityInfo()
        updateSubTypeInfo()
        updateSuperTypeInfo()
        updateTypeInfo()
        updateFlavorText()
        updateLeftScrollView()
        updateRightScrollView()
    }

    function resetViews() {
        resetLeftColumnScroll()
        resetRightColumnScroll()
        resetCardRotation()
    }

    // Drawer Toggle
    function toggleDrawer() {
        if (customDrawer.x < 0) {
            customDrawer.x = 8
            isDrawerOpen = true
            rotateAnimation.from = ballButton.rotation
            rotateAnimation.to = 270
            rotateAnimation.start()
        } else {
            customDrawer.x = -customDrawer.width + 6
            isDrawerOpen = false
            rotateAnimation.from = ballButton.rotation
            rotateAnimation.to = 90
            rotateAnimation.start()
        }
    }

        // Main Layout Container
    Rectangle {
        id: mainContainer
        anchors.fill: parent
        color: deepBG

        // Card Display Drawer
        Rectangle {
            id: customDrawer
            width: 330
            height: 415
            color: screenColor
            radius: 4
            border.color: screenHighlightColor
            border.width: 6
            x: -width + 6
            
            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }

            // Card Display
            View3D {
                id: view
                anchors.fill: parent
                
                PerspectiveCamera {
                    position: Qt.vector3d(0, 200, 300)
                    lookAtNode: cardNode
                }

                DirectionalLight {
                    eulerRotation.x: -30
                }

                Node {
                    id: cardNode
                    x: 0
                    y: 200
                    z: -25
                    scale.y: 3.5
                    scale.x: 2.5

                    Model {
                        id: frontCard
                        source: "#Rectangle"
                        materials: [
                            DefaultMaterial {
                                diffuseMap: Texture {
                                    sourceItem: Image {
                                        width: 413
                                        height: 577
                                        source: currentCard?.imageUrl || ""
                                    }
                                }
                            }
                        ]
                    }
                }
            }

            // Collection Button
            CollectionButton {
                id: collectionButton
                width: 77
                height: width
                anchors {
                    top: parent.top
                    left: parent.left
                    margins: 10
                }
                card: currentCard
                
                onRequestAddToCollection: (card) => {
                    searchPage.requestAddToCollection(card, "search")
                }
                
                onRequestRemoveFromCollection: (card) => {
                    searchPage.requestRemoveFromCollection(card, "search")
                }
            }
        }

            // Drawer Toggle Button
    MouseArea {
        id: openButton
        width: 28
        height: customDrawer.height
        anchors {
            verticalCenter: customDrawer.verticalCenter
            left: customDrawer.right
            leftMargin: -1
        }
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: toggleDrawer()

        Rectangle {
            anchors.fill: parent
            color: "#ee1414"
            border {
                color: "#620808"
                width: 2
            }

            Image {
                id: ballButton
                width: 60
                height: 60
                anchors.centerIn: parent
                source: "newBall.png"
                scale: 0.6

                NumberAnimation {
                    id: rotateAnimation
                    target: ballButton
                    property: "rotation"
                    duration: 500
                }
            }
        }
    }

    // Search Tools Column
    Column {
        id: searchToolsColumn
        width: 700
        height: 100
        spacing: 0

        MySearchFilterTools {
            id: searchFilterTools
            height: 60
            Layout.fillWidth: true
            typesRowSpacing: 14
            borderColor: primaryColor
            blockBorderWidth: 2
            toolsBorderColor: primaryColor
            toolsFillColor: "#00541515"

            setsModel: ListModel {
                id: setsModel
            }
        }

        ToolBar {
            id: searchTools
            width: 700
            height: 40

            Row {
                id: searchRow
                width: 700
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5

                ComboBox {
                    id: setComboBox
                    width: 260
                    height: 25
                    displayText: "Sets"
                    model: setsModel
                }

                TextField {
                    id: txtSearchBox
                    width: 282
                    height: 25
                    placeholderText: qsTr("Enter card name")
                }

                Button {
                    id: btnSearch
                    width: 135
                    height: 35
                    text: qsTr("Search")
                    onClicked: performSearch()
                }
            }
        }
    }

        // Search Function
    function performSearch() {
        let searchParams = []
        
        // Add name parameter if search box has text
        if (txtSearchBox.text.trim() !== "") {
            searchParams.push(['', 'name', txtSearchBox.text])
        }
        
        // Add selected sets
        let setsParams = []
        for (let i = 0; i < setsModel.count; i++) {
            let item = setsModel.get(i)
            if (item.selected) {
                setsParams.push(['set', 'name', item.name])
            }
        }
        
        // Add selected types
        let typesParams = []
        if (searchFilterTools.fireChecked) typesParams.push(['types', '', 'fire'])
        if (searchFilterTools.waterChecked) typesParams.push(['types', '', 'water'])
        if (searchFilterTools.grassChecked) typesParams.push(['types', '', 'grass'])
        if (searchFilterTools.lightningChecked) typesParams.push(['types', '', 'lightning'])
        if (searchFilterTools.psychicChecked) typesParams.push(['types', '', 'psychic'])
        if (searchFilterTools.fightingChecked) typesParams.push(['types', '', 'fighting'])
        if (searchFilterTools.darknessChecked) typesParams.push(['types', '', 'darkness'])
        if (searchFilterTools.metalChecked) typesParams.push(['types', '', 'metal'])
        if (searchFilterTools.fairyChecked) typesParams.push(['types', '', 'fairy'])
        if (searchFilterTools.dragonChecked) typesParams.push(['types', '', 'dragon'])
        if (searchFilterTools.colorlessChecked) typesParams.push(['types', '', 'colorless'])
        
        searchParams = searchParams.concat(typesParams, setsParams)
        
        if (searchParams.length > 0) {
            backendController.request_search(searchParams)
        }
    }

    // Backend Connections
    Connections {
        target: backendController
        
        function onSearchResults(response) {
            const data = JSON.parse(response)
            if (!data.error) {
                cards = data
                selectedIndex = 0
                updateCardInfo()
                resetViews()
                view.visible = true
            }
        }

        function onSetsResults(response) {
            var data = JSON.parse(response)
            setsModel.clear()
            
            if (!data.error) {
                var tempSets = data.map(set => ({
                    name: set.name,
                    selected: false
                }))
                
                tempSets.sort((a, b) => a.name.localeCompare(b.name))
                tempSets.forEach(set => setsModel.append(set))
                cachedSets = tempSets
            }
        }
    }

        } // close mainContainer
    } // close searchPage