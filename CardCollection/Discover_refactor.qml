// Discover_refactor.qml
import QtQuick 2.13
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D
import Qt5Compat.GraphicalEffects

Item {
    id: discoverPage
    objectName: "discoverPage"
    
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
    property var cards: []  // Discover results
    property var currentCollection: []  // Collection state from main.qml
    property var currentCard: cards[selectedIndex]
    property int selectedIndex: 0
    
    // UI State
    property bool isDrawerOpen: false
    property bool isDrawer2Open: false
    
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
        currentCollection = collection
        if (collectionButton && currentCard) {
            collectionButton.syncing = true
            collectionButton.checked = collection.some(c => c.id === currentCard.id)
            collectionButton.syncing = false
        }
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

    function resetCardRotation() {
        momentumTimer.stop()
        cardNode.eulerRotation.y = 0
    }

        // Timer Component
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

        // Left Card Display Drawer
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
                    discoverPage.requestAddToCollection(card, "discover")
                }
                
                onRequestRemoveFromCollection: (card) => {
                    discoverPage.requestRemoveFromCollection(card, "discover")
                }
            }
        }

            // Right Info Drawer
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

        // Card info components will go here
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

        // Both Drawers Toggle Button
    RoundButton {
        id: toggleBothButton
        width: 40
        height: 40
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 115
        }
        enabled: !toggleLockTimer.running
        
        Image {
            id: ballToggleImage
            width: 100
            height: 100
            source: "newBall.png"
            scale: 0.35
            anchors.centerIn: parent
        }
        
        onReleased: {
            if (isDrawerOpen && !isDrawer2Open) {
                toggleRightDrawer()
            }
            else if (isDrawer2Open && !isDrawerOpen) {
                toggleLeftDrawer()
            }
            else {
                toggleBothDrawers()
            }
        }
    }

    // Backend Connections
    Connections {
        target: backendController
        
        function onDiscoverResults(response) {
            const data = JSON.parse(response)
            if (!data.error) {
                cards = data
                selectedIndex = 0
                resetCardRotation()
                view.visible = true
            }
        }
    }

        } // close mainContainer
    } // close discoverPage