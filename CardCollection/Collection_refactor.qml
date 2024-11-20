// Collection_refactor.qml
import QtQuick 2.13
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D
import Qt5Compat.GraphicalEffects

Item {
    id: collectionPage
    objectName: "collectionPage"
    
    // Layout Properties
    width: 700
    height: 615
    Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
    Layout.preferredWidth: 600
    Layout.preferredHeight: 600
    Layout.fillHeight: false
    Layout.fillWidth: false
    focus: true

    // Collection State
    property var cards: []  // Collection from main.qml
    property var cachedSets: []  // For filtering
    
    // UI State
    property bool isDrawerOpen: true
    property bool isDrawer2Open: true
    property bool isFilterDrawerOpen: true
    property int cardWidth: 300
    
    // Compare State
    property string leftCardImage
    property string rightCardImage
    
    // Animation Properties
    property int drawerAnimationDuration: 200
    property int lockTimerDuration: 500
    
    // Collection Signals
    signal requestAddToCollection(var card, string source)
    signal requestRemoveFromCollection(var card, string source)
    
    // Theme Colors
    property color pressedToggleColor: "#02d20b"
    property color releasedToggleColor: "#c80d0d"
    property color primaryColor: "#c80d0d"
    property color blockBG: "#ff0000"
    property color deepBG: "#541515"
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

    // Core Functions
function updateCollection(collection) {
    cards = collection
}

function updateColumns(num: int) {
    collectionFlow.numCardColumns = num
}

// Drawer Functions
function toggleLeftDrawer() {
    toggleLockTimer.start()
    if (customDrawer.x < 0) {
        customDrawer.x = 0
        isDrawerOpen = true
        rotateAnimation.from = ballButton.rotation
        rotateAnimation.to = 90
        rotateAnimation.start()
    } else {
        customDrawer.x = -customDrawer.width
        isDrawerOpen = false
        rotateAnimation.from = ballButton.rotation
        rotateAnimation.to = 270
        rotateAnimation.start()
    }
}

function toggleRightDrawer() {
    toggleLockTimer.start()
    if (customDrawer2.x >= 700) {
        customDrawer2.x = 700 - customDrawer2.width
        isDrawer2Open = true
        rotateAnimation2.from = ballButton2.rotation
        rotateAnimation2.to = 270
        rotateAnimation2.start()
    } else {
        customDrawer2.x = 700
        isDrawer2Open = false
        rotateAnimation2.from = ballButton2.rotation
        rotateAnimation2.to = 90
        rotateAnimation2.start()
    }
}

function toggleBothDrawers() {
    toggleLockTimer.start()
    toggleLeftDrawer()
    toggleRightDrawer()
}

function toggleFilterDrawer() {
    if (filtersColumn.y >= collectionPage.height) {
        filtersColumn.y = collectionPage.height - filtersColumn.height
        isFilterDrawerOpen = true
        rotateAnimationFilterDrawer.from = ballButtonFilterDrawer.rotation
        rotateAnimationFilterDrawer.to = 0
        rotateAnimationFilterDrawer.start()
    } else {
        filtersColumn.y = collectionPage.height
        isFilterDrawerOpen = false
        rotateAnimationFilterDrawer.from = ballButtonFilterDrawer.rotation
        rotateAnimationFilterDrawer.to = 180
        rotateAnimationFilterDrawer.start()
    }
}

// Compare Functions
function onLeftCompareSignal(leftCompareImageUrl: string) {
    leftImage.source = leftCompareImageUrl
}

function onRightCompareSignal(rightCompareImageUrl: string) {
    rightImage.source = rightCompareImageUrl
}

function resetCardRotation() {
    momentumTimer.stop()
    cardNode.eulerRotation.y = 0
}

// Timer Components
Timer {
    id: toggleLockTimer
    interval: lockTimerDuration
    repeat: false
}

// Main Layout Container
Rectangle {
    id: mainContainer
    anchors.fill: parent
    color: deepBG
    
    // Left Drawer
    Rectangle {
        id: customDrawer
        width: 330
        height: 415
        color: screenColor
        radius: 4
        border.color: screenHighlightColor
        border.width: 6
        x: -width
        
        Behavior on x {
            NumberAnimation {
                duration: drawerAnimationDuration
                easing.type: Easing.OutQuad
            }
        }
        
        // Collection Card Display
        CardFlow {
            id: collectionFlow
            anchors {
                fill: parent
                margins: 10
            }
            cards: collectionPage.cards
            
            // delegate: Item {
            //     CollectionButton {
            //         card: modelData
            //         onRequestAddToCollection: (card) => {
            //             collectionPage.requestAddToCollection(card, "collection")
            //         }
            //         onRequestRemoveFromCollection: (card) => {
            //             collectionPage.requestRemoveFromCollection(card, "collection")
            //         }
            //     }
            // }
        }
    }

        // Right Drawer
    Rectangle {
        id: customDrawer2
        width: 330
        height: 415
        color: screenColor
        radius: 4
        border.color: screenHighlightColor
        border.width: 6
        x: parent.width
        
        Behavior on x {
            NumberAnimation {
                duration: drawerAnimationDuration
                easing.type: Easing.OutQuad
            }
        }
        
        // Left Compare View
        Image {
            id: leftImage
            width: parent.width / 2 - 10
            height: parent.height - 20
            anchors {
                left: parent.left
                top: parent.top
                margins: 10
            }
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            cache: false
            
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: screenShadeColor
                border.width: 2
                radius: 4
            }
        }

        // Right Compare View
        Image {
            id: rightImage
            width: parent.width / 2 - 10
            height: parent.height - 20
            anchors {
                right: parent.right
                top: parent.top
                margins: 10
            }
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            cache: false
            
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: screenShadeColor
                border.width: 2
                radius: 4
            }
        }
    }

        // Bottom Filter Drawer
    Rectangle {
        id: filtersColumn
        width: parent.width
        height: 200
        color: screenColor
        y: parent.height
        
        Behavior on y {
            NumberAnimation {
                duration: drawerAnimationDuration
                easing.type: Easing.OutQuad
            }
        }
        
        // Filter Tools Row
        Row {
            id: filterToolsRow
            width: parent.width
            height: 60
            spacing: 5
            
            ComboBox {
                id: setComboBox
                width: 260
                height: 25
                displayText: "Sets"
                model: ListModel { id: setsModel }
                
                delegate: Item {
                    width: parent.width
                    height: checkDelegate.height
                    
                    function toggle() {
                        checkDelegate.toggle()
                    }
                    
                    CheckDelegate {
                        id: checkDelegate
                        anchors.fill: parent
                        text: model.name
                        highlighted: setComboBox.highlightedIndex == index
                        checked: model.selected
                        onCheckedChanged: {
                            model.selected = checked
                        }
                    }
                }
                
                Component.onCompleted: {
                    backendController.request_sets_retrieve()
                }
            }
            
            // Type Filter Buttons
            MySearchFilterTools {
                id: searchFilterTools
                height: 60
                width: parent.width - setComboBox.width - clearButton.width - 10
                
                typesRowSpacing: 14
                borderColor: primaryColor
                blockBorderWidth: 2
                toolsBorderColor: primaryColor
                toolsFillColor: "#00541515"
            }
            
            Button {
                id: clearButton
                width: 80
                height: 35
                text: "Clear"
                onClicked: {
                    setsModel.clear()
                    for(var i = 0; i < cachedSets.length; i++) {
                        setsModel.append(cachedSets[i])
                    }
                    searchFilterTools.clearFilters()
                }
            }
        }
    }

        // Left Drawer Toggle
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
        onClicked: toggleLeftDrawer()
        
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

    // Right Drawer Toggle
    MouseArea {
        id: openButton2
        width: 28
        height: customDrawer2.height
        anchors {
            verticalCenter: customDrawer2.verticalCenter
            right: customDrawer2.left
            rightMargin: -1
        }
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: toggleRightDrawer()
        
        Rectangle {
            anchors.fill: parent
            color: "#ee1414"
            border {
                color: "#620808"
                width: 2
            }
            
            Image {
                id: ballButton2
                width: 60
                height: 60
                anchors.centerIn: parent
                source: "bottomBall.png"
                scale: 0.6
                
                NumberAnimation {
                    id: rotateAnimation2
                    target: ballButton2
                    property: "rotation"
                    duration: 500
                }
            }
        }
    }

    // Sets Results Handler
    Connections {
        target: backendController
        
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

} // close root Item
