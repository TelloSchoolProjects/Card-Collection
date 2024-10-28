import QtQuick 2.13
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Window 2.15
import QtQuick.Controls.Fusion 2.15
import Qt5Compat.GraphicalEffects
import QtQuick3D


Window {
    id: window
    width: 500
    height: 600
    minimumWidth: 500
    minimumHeight: 600
    maximumWidth: 500
    maximumHeight: 600

    visible: true
    color: "#611b1b"

    title: qsTr("Card Collection")

    property int selectedIndex: -1
    property var cards: [] // List of card objects
    property int selectedTabIndex: 0

    // Define color scheme properties
    property color primaryColor: "#c80d0d"
    property color bezelColor: "#b2b2b2"
    property color bezelBorderColor: "#616161"
    property color screenColor: "#02d20b"
    property color screenShadeColor: "#128c17"
    property color screenHighlightColor: "#25fb2e"
    property color textColor: "#095f0c"
    property color dropTextColor: "#c5002a02"
    property color borderColor: "#6c0101"
    property color dropBorderColor: "#25fb2e"

    // Function to update attack information based on selectedIndex
    function updateAttackInfo() {
        if (cards[selectedIndex]) {

            const defaultCost1 = "Cost 1";
            const defaultCost2 = "Cost 2";
            const defaultCost3 = "Cost 3";
            const defaultCost4 = "Cost 4";
            const defaultCost5 = "Cost 5";



            // Create costs objects from the selected card for each attack
            const attack1Costs = {
                cost1: cards[selectedIndex].attack1Cost1 || defaultCost1,
                cost2: cards[selectedIndex].attack1Cost2 || defaultCost2,
                cost3: cards[selectedIndex].attack1Cost3 || defaultCost3,
                cost4: cards[selectedIndex].attack1Cost4 || defaultCost4,
                cost5: cards[selectedIndex].attack1Cost5 || defaultCost5
            };

            const attack2Costs = {
                cost1: cards[selectedIndex].attack2Cost1 || defaultCost1,
                cost2: cards[selectedIndex].attack2Cost2 || defaultCost2,
                cost3: cards[selectedIndex].attack2Cost3 || defaultCost3,
                cost4: cards[selectedIndex].attack2Cost4 || defaultCost4,
                cost5: cards[selectedIndex].attack2Cost5 || defaultCost5

            };

            const attack3Costs = {
                cost1: cards[selectedIndex].attack3Cost1 || defaultCost1,
                cost2: cards[selectedIndex].attack3Cost2 || defaultCost2,
                cost3: cards[selectedIndex].attack3Cost3 || defaultCost3,
                cost4: cards[selectedIndex].attack3Cost4 || defaultCost4,
                cost5: cards[selectedIndex].attack3Cost5 || defaultCost5

            };

            const attack4Costs = {
                cost1: cards[selectedIndex].attack4Cost1 || defaultCost1,
                cost2: cards[selectedIndex].attack4Cost2 || defaultCost2,
                cost3: cards[selectedIndex].attack4Cost3 || defaultCost3,
                cost4: cards[selectedIndex].attack4Cost4 || defaultCost4,
                cost5: cards[selectedIndex].attack4Cost5 || defaultCost5

            };

            // Update attack blocks
            attack1Block.updateAttack(cards[selectedIndex].attack1Name, cards[selectedIndex].attack1Text, 0, attack1Costs);
            attack2Block.updateAttack(cards[selectedIndex].attack2Name, cards[selectedIndex].attack2Text, 1, attack2Costs);
            attack3Block.updateAttack(cards[selectedIndex].attack3Name, cards[selectedIndex].attack3Text, 2, attack3Costs);
            attack4Block.updateAttack(cards[selectedIndex].attack4Name, cards[selectedIndex].attack4Text, 3, attack4Costs);

        }
    }

    // Function to update ability information based on selectedIndex
    function updateAbilityInfo() {
        // console.log("updateAbilityInfo called...");
        if (cards[selectedIndex]) {
            // Update ability text fields first
            ability1NameText.text = cards[selectedIndex].ability1Name
                    || "Ability 1"
            ability1DescriptionDropText.text = cards[selectedIndex].ability1Text
                    || "No description available."
            ability1TypeText.text = cards[selectedIndex].ability1Type || "Ability 1 Type"

            ability2NameText.text = cards[selectedIndex].ability2Name
                    || "Ability 2"
            ability2DescriptionDropText.text = cards[selectedIndex].ability2Text
                    || "No description available."
            ability2TypeText.text = cards[selectedIndex].ability2Type || "Ability 2 Type"

            // Set visibility for each ability based on the card data
            ability1NameBlock.visible = cards[selectedIndex].ability1Name !== "Ability 1" && cards[selectedIndex].ability1Name !== ""
            ability1DescriptionBlock.visible = ability1NameBlock.visible
            ability1TypeBlock.visible = ability1NameBlock.visible
            //ability1TypeBlock.visible = ability1NameBlock.visible && ability1DescriptionDropText.text === "No description available." ? 75 : 136

            ability2NameBlock.visible = cards[selectedIndex].ability2Name !== "Ability 2"
                    && cards[selectedIndex].ability2Name !== ""
            ability2DescriptionBlock.visible = ability2NameBlock.visible
            ability2TypeBlock.visible = ability2NameBlock.visible
            ability2DescriptionBlock.height = ability2DescriptionBlock.visible
                    && ability2DescriptionDropText.text === "No description available." ? 75 : 136
        }
    }

    function updateSubTypeInfo() {
        if(cards[selectedIndex]) {
            subtype1Text.text = cards[selectedIndex].subtype1
                    || "Sub Type 1"
        }

        if(cards[selectedIndex]) {
            subtype2Text.text = cards[selectedIndex].subtype2
                    || "Sub Type 2"
        }

        if(cards[selectedIndex]) {
            subtype3Text.text = cards[selectedIndex].subtype3
                    || "Sub Type 3"
        }

        if(cards[selectedIndex]) {
            subtype4Text.text = cards[selectedIndex].subtype4
                    || "Sub Type 4"
        }

        // Set visibility for each ability based on the card data
        subtype1Block.visible = cards[selectedIndex].subtype1 !== "Sub Type 1" && cards[selectedIndex].subtype1 !== ""
        subtype2Block.visible = cards[selectedIndex].subtype2 !== "Sub Type 2" && cards[selectedIndex].subtype2 !== ""
        subtype3Block.visible = cards[selectedIndex].subtype3 !== "Sub Type 3" && cards[selectedIndex].subtype3 !== ""
        subtype4Block.visible = cards[selectedIndex].subtype4 !== "Sub Type 4" && cards[selectedIndex].subtype4 !== ""

        if (subtype1Block.visible && !subtype2Block.visible && !subtype3Block.visible && !subtype4Block.visible ||
                subtype1Block.visible && subtype2Block.visible && subtype3Block.visible && !subtype4Block.visible) {
            subtype1Block.width = 175;
        } else if (subtype1Block.visible && subtype2Block.visible && !subtype3Block.visible && !subtype4Block.visible) {
            subtype1Block.width = 85;
        } else {
            subtype1Block.width = 85; // Set a fallback width if needed
        }        //subtype2Block.width = subtype3Block.visible ? 85 : 175

        subtypeBlock.height = subtype3Block.visible ? subtype1Block.height * 2 : subtype1Block.height
    }

    function updateSuperTypeInfo() {
        if(cards[selectedIndex]) {
            supertypeText.text = cards[selectedIndex].supertype
                    || "Super Type"
        }

    }

    function updateTypeInfo() {
        if(cards[selectedIndex]) {
            type1Text.text = cards[selectedIndex].type1
                    || "Type 1"
        }

        if(cards[selectedIndex]) {
            type2Text.text = cards[selectedIndex].type2
                    || "Type 2"
        }

        // Set visibility for each ability based on the card data
        type1Block.visible = type1Text.text !== "Type 1" && cards[selectedIndex].type1 !== ""
        type2Block.visible = type2Text.text !== "Type 2" && cards[selectedIndex].type2 !== ""

        type1Block.width = type2Block.visible ? 85 : 175

    }

    function resetCardRotation() {
        momentumTimer.stop()

        cardNode.eulerRotation.y = 0;
        //TODO
    }
    function resetLeftColumnScroll() {
        leftScrollView.contentX = 0;
        leftScrollView.contentY = 0;
    }

    function resetRightColumnScroll() {
        rightScrollView.contentX = 0;
        rightScrollView.contentY = 0;
    }

    // Function to handle next button click
    function onNextCard() {
        if (selectedIndex < cards.length - 1) {
            selectedIndex++
            updateAttackInfo(); // Update UI for the new selectedIndex
            updateAbilityInfo();
            updateSubTypeInfo();
            updateSuperTypeInfo();
            updateTypeInfo();
            resetLeftColumnScroll();
            resetRightColumnScroll();
            resetCardRotation();
        }
    }

    // Function to handle next button click
    function onPrevCard() {
        if (selectedIndex >= 0) {
            selectedIndex--
            updateAttackInfo(); // Update UI for the new selectedIndex
            updateAbilityInfo();
            updateSubTypeInfo();
            updateSuperTypeInfo();
            updateTypeInfo();
            resetLeftColumnScroll();
            resetRightColumnScroll();
            resetCardRotation();
        }
    }

    ColumnLayout {
        id: columnLayout1
        anchors.fill: parent
        spacing: 0

        // TabBar for navigation
        TabBar {
            id: tabBar
            Layout.fillWidth: true
            currentIndex: selectedTabIndex
            width: parent.width
            Layout.preferredHeight: parent.height * 0.08
            height: 40

            TabButton {
                opacity: 1
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                // Set button background color based on the selected index
                palette {
                    button: selectedTabIndex === 0 ? "#6c0101" : "#c80d0d" // Dark red for selected, light red for unselected
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
                    button: selectedTabIndex === 1 ? "#6c0101" : "#c80d0d" // Dark red for selected, light red for unselected
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
                    button: selectedTabIndex === 2 ? "#6c0101" : "#c80d0d" // Dark red for selected, light red for unselected
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
            visible: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            currentIndex: selectedTabIndex
            clip: false

            // Page 1: Search Page
            Item {
                id: searchPage
                width: parent.width
                height: 600
                visible: false
                Layout.fillHeight: true
                Layout.fillWidth: true

                ColumnLayout {
                    id: searchTabColumn
                    anchors.fill: parent
                    spacing: 0

                    ColumnLayout {
                        id: searchToolsColumn
                        width: 500
                        height: 80
                        Layout.preferredWidth: 500
                        Layout.preferredHeight: 80
                        spacing: 0
                        Layout.columnSpan: 1
                        z: 0
                        Layout.fillWidth: true
                        Layout.fillHeight: false

                        MySearchFilterTools {
                            id: searchFilterTools
                            Layout.fillHeight: false
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            Layout.topMargin: 0
                            bottomPadding: 0
                            contentHeight: 30
                            height: 40
                            Layout.preferredWidth: 500
                            fairyChecked: false
                            dragonChecked: false
                            horizontalPadding: 0
                            verticalPadding: 0
                            width: 500

                            // Dynamic ListModel for sets
                            setsModel: ListModel {
                                id: setsModel
                            }
                        }

                        ToolBar {
                            id: searchTools
                            width: 500
                            height: 40
                            anchors.verticalCenter: searchFilterTools.verticalCenter
                            anchors.left: searchFilterTools.right
                            anchors.right: searchFilterTools.left
                            anchors.top: searchFilterTools.bottom
                            anchors.bottom: searchFilterTools.top
                            anchors.leftMargin: -500
                            anchors.rightMargin: -500
                            RowLayout {
                                id: searchRow
                                anchors.fill: parent
                                anchors.leftMargin: 0
                                anchors.rightMargin: 0
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                                z: 1
                                spacing: 5

                                TextField {
                                    id: txtSearchBox
                                    width: 250
                                    Layout.fillHeight: false
                                    //anchors.verticalCenter: btnSearch.verticalCenter
                                    //anchors.left: parent.left
                                    //anchors.left: btnSearch.right
                                    // anchors.top: parent.top
                                    // anchors.bottom: parent.bottom
                                    //anchors.leftMargin: 4
                                    //anchors.topMargin: 4
                                    //anchors.bottomMargin: 4
                                    //anchors.top: parent.top
                                    //anchors.bottom: parent.bottom
                                    z: 1
                                    Layout.leftMargin: 6
                                    Layout.preferredHeight: -1
                                    Layout.preferredWidth: -1
                                    placeholderText: qsTr("Enter card name")
                                    Layout.fillWidth: true

                                    Rectangle {
                                        id: rectangle7
                                        color: "#00951111"
                                        radius: 4
                                        border.color: "#6c0101"
                                        border.width: 2
                                        anchors.fill: parent
                                        anchors.leftMargin: 0
                                        anchors.rightMargin: 0
                                        anchors.topMargin: 0
                                        anchors.bottomMargin: 0
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        clip: false
                                        scale: 1
                                        z: 0
                                    }
                                }

                                Button {
                                    id: btnSearch
                                    width: 100
                                    height: 40
                                    text: qsTr("Search")
                                    z: 1
                                    font.styleName: "Bold Italic"
                                    Layout.fillHeight: false
                                    Layout.rightMargin: 6
                                    Layout.fillWidth: false
                                    palette {
                                        button: "blue"
                                    }
                                    hoverEnabled: true

                                    ToolTip.delay: 800
                                    ToolTip.timeout: 5000
                                    ToolTip.visible: hovered
                                    ToolTip.text: qsTr("Search the database with the selected filters")

                                    // Change scale when hovered
                                    scale: hovered ? 1.05 : 1.0


                                    onClicked: {
                                        // Initialize an empty array for the search parameters
                                        var searchParams = []

                                        // Check if the search box is not empty
                                        if (txtSearchBox.text.trim() !== "") {
                                            // Create a tuple with the entered name
                                            searchParams.push(
                                                        ['', 'name', txtSearchBox.text])
                                        }

                                        // Collecting selected items from the ComboBox
                                        for (var i = 0; i < setsModel.count; i++) {
                                            var item = setsModel.get(i)
                                            if (item.selected) {
                                                // Build the tuple for each selected set item
                                                searchParams.push(
                                                            ['set', 'name', item.name])
                                            }
                                        }

                                        // Check the state of each Pokémon TCG type button and add to search parameters if checked
                                        if (searchFilterTools.fireChecked) {
                                            searchParams.push(
                                                        ['types', '', 'fire'])
                                        }
                                        if (searchFilterTools.waterChecked) {
                                            searchParams.push(
                                                        ['types', '', 'water'])
                                        }
                                        if (searchFilterTools.grassChecked) {
                                            searchParams.push(
                                                        ['types', '', 'grass'])
                                        }
                                        if (searchFilterTools.lightningChecked) {
                                            searchParams.push(
                                                        ['types', '', 'lightning'])
                                        }
                                        if (searchFilterTools.psychicChecked) {
                                            searchParams.push(
                                                        ['types', '', 'psychic'])
                                        }
                                        if (searchFilterTools.fightingChecked) {
                                            searchParams.push(
                                                        ['types', '', 'fighting'])
                                        }
                                        if (searchFilterTools.darknessChecked) {
                                            searchParams.push(
                                                        ['types', '', 'darkness'])
                                        }
                                        if (searchFilterTools.fairyChecked) {
                                            searchParams.push(
                                                        ['types', '', 'fairy'])
                                        }
                                        if (searchFilterTools.dragonChecked) {
                                            searchParams.push(
                                                        ['types', '', 'dragon'])
                                        }
                                        if (searchFilterTools.metalChecked) {
                                            searchParams.push(
                                                        ['types', '', 'metal'])
                                        }
                                        if (searchFilterTools.colorlessChecked) {
                                            searchParams.push(
                                                        ['types', '', 'colorless'])
                                        }

                                        // Call the request_search function with the built tuples if there are any
                                        if (searchParams.length > 0) {
                                            //Print each tuple as a string to the console
                                            for (var i = 0; i < searchParams.length; i++) {
                                                var tupleString = "[" + searchParams[i][0] + ", "
                                                        + searchParams[i][1] + ", "
                                                        + searchParams[i][2] + "]"

                                            }
                                            backendController.request_search(
                                                        searchParams)
                                            resetLeftColumnScroll()
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                id: pitShadowBorder
                                color: "#00ffffff"
                                radius: 4
                                border.color: "#6c0101"
                                border.width: 2
                                anchors.fill: parent
                                z: 1

                                Rectangle {
                                    id: highlightBorder
                                    color: "#00ffffff"
                                    radius: 4
                                    border.color: "#ee0000"
                                    border.width: 1
                                    anchors.fill: parent
                                    anchors.leftMargin: 4
                                    anchors.rightMargin: 4
                                    anchors.topMargin: 4
                                    anchors.bottomMargin: 4
                                    z: 1
                                }
                            }

                            Rectangle {
                                id: bgRect
                                color: "#cc1c1c"
                                border.color: "#00000000"
                                anchors.fill: parent
                                anchors.leftMargin: 0
                                anchors.rightMargin: 0
                            }
                        }
                    }

                    Item {
                        id: _item
                        width: 200
                        height: 200
                        Layout.margins: 0
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        // Add a boolean variable to track the drawer's state
                        property bool isDrawerOpen: false // Start with the drawer closed


                        // function toggleDrawer() {
                        //     if (customDrawer.x < 0) {
                        //         customDrawer.x = 0
                        //         _item.isDrawerOpen = true

                        //         // Animate rotation on drawer open
                        //         rotateAnimation.from = ballButton.rotation
                        //         rotateAnimation.to = 270 // Rotate by 90 degrees
                        //         rotateAnimation.start()
                        //     } else {
                        //         customDrawer.x = -customDrawer.width + 12
                        //         _item.isDrawerOpen = false

                        //         // Animate rotation on drawer close
                        //         rotateAnimation.from = ballButton.rotation
                        //         rotateAnimation.to
                        //                 = 90 // Reset to 0 degrees rotation
                        //         rotateAnimation.start()
                        //     }
                        // }

                        // The main Pane with no margin or padding
                        Rectangle {
                            id: _itemOuterRedMid
                            visible: true
                            color: "#00ccf2ff"
                            radius: 0
                            border.color: "#cc1c1c"
                            border.width: 6
                            anchors.fill: parent
                            z: 3
                        }

                        Rectangle {
                            id: _itemOuterRedShade
                            height: 404
                            visible: true
                            color: "#00ccf2ff"
                            radius: 4
                            border.color: "#6c0101"
                            border.width: 2
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 0
                            anchors.topMargin: 0
                            z: 4
                        }

                        Rectangle {
                            id: _itemOuterRedShade1
                            visible: true
                            color: "#00ccf2ff"
                            radius: 4
                            border.color: "#6c0101"
                            border.width: 2
                            anchors.fill: parent
                            anchors.rightMargin: 5
                            anchors.topMargin: 5
                            anchors.bottomMargin: 5
                            z: 4
                        }

                        Pane {
                            id: viewPane
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            topPadding: 0
                            rightPadding: 0
                            leftPadding: 0
                            verticalPadding: 6 // Padding inside the pane
                            horizontalPadding: 6 // Padding inside the pane
                            contentWidth: 468
                            contentHeight: 300
                            bottomPadding: 0
                            Layout.margins: 0 // No margins for the pane
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            // Border Rectangle around the Pane
                            Rectangle {
                                visible: true
                                anchors.fill: parent
                                z: 0
                                color: dataFlow.color // Set background to transparent
                                border.color: "#00255864" // Darker grey color for the border
                                border.width: 0
                                radius: 0 // Optional: Set radius for rounded corners
                            }

                            // Drawer
                            Rectangle {
                                id: customDrawer
                                x: -270
                                width: 280
                                height: 426
                                opacity: 1
                                // Start hidden
                                color: screenColor
                                radius: 4
                                border.color: "#25fb2e"
                                border.width: 6
                                anchors.verticalCenter: parent.verticalCenter
                                clip: true
                                scale: 0.95
                                z: 1

                                // Animate the x position when it changes
                                Behavior on x {
                                    NumberAnimation {
                                        duration: 500 // Adjust the duration for the desired speed
                                        easing.type: Easing.OutQuad // Smooth easing effect
                                    }
                                }

                                MouseArea {
                                    visible: true
                                    anchors.fill: parent
                                    anchors.leftMargin: 1
                                    anchors.rightMargin: -1
                                    anchors.topMargin: 0
                                    anchors.bottomMargin: 0
                                }

                                // Frame that holds the card images on both sides
                                Frame {
                                    id: frame
                                    anchors.fill: parent

                                    View3D {
                                        id: view
                                        anchors.fill: parent
                                        z: 3
                                        visible: false

                                        PerspectiveCamera {
                                            y: 0
                                            position: Qt.vector3d(0, 200, 300)
                                            frustumCullingEnabled: false
                                            z: 161
                                            eulerRotation.x: 0
                                        }

                                        DirectionalLight {
                                            eulerRotation.x: -30
                                        }

                                        Node {
                                            id: cardNode
                                            x: 0
                                            y: 200
                                            z: -25
                                            scale.y: 3
                                            scale.x: 2

                                            // Front side of the card
                                            Model {
                                                id: frontCard
                                                source: "#Rectangle"
                                                receivesShadows: false
                                                castsShadows: false
                                                scale: Qt.vector3d(1, 1, 1) // Adjust dimensions for card thickness
                                                eulerRotation.y: 0

                                                materials: [
                                                    DefaultMaterial {
                                                        diffuseMap: Texture {
                                                            sourceItem: Image {
                                                                anchors.centerIn: parent
                                                                width: 413
                                                                height: 577
                                                                source: (selectedIndex >= 0 && selectedIndex < cards.length) ? cards[selectedIndex].imageUrl : ""
                                                                sourceSize: Qt.size(width, height)
                                                                cache: false
                                                            }
                                                        }
                                                    }
                                                ]
                                            }

                                            // Back side of the card, rotated 180 degrees
                                            Model {
                                                id: backCard
                                                source: "#Rectangle"
                                                scale: Qt.vector3d(1, 1, 1)
                                                eulerRotation.y: 180 // Rotated to face the opposite direction

                                                materials: [
                                                    DefaultMaterial {
                                                        diffuseColor: "#ffffff"
                                                        diffuseMap: Texture {
                                                            sourceItem: Image {
                                                                anchors.centerIn: parent
                                                                width: 413
                                                                height: 577
                                                                source: "cardback.png" // URL for the back image
                                                                sourceSize: Qt.size(width, height)
                                                                cache: false
                                                            }
                                                        }
                                                    }
                                                ]
                                            }
                                        }

                                        MouseArea {
                                            id: dragArea
                                            anchors.fill: parent
                                            anchors.leftMargin: 0
                                            anchors.rightMargin: 0
                                            anchors.topMargin: 0
                                            anchors.bottomMargin: 0
                                            property real previousX: 0
                                            property real velocityY: 0
                                            property real dragSensitivity: 0.2
                                            property real momentumDecay: 0.98 // Controls how quickly momentum fades

                                            onPressed: {
                                                previousX = mouse.x
                                                velocityY = 0
                                                momentumTimer.stop()
                                            }

                                            onPositionChanged: {
                                                var deltaX = mouse.x - previousX
                                                velocityY = deltaX * dragSensitivity
                                                cardNode.eulerRotation.y += velocityY
                                                previousX = mouse.x
                                            }

                                            onReleased: {
                                                momentumTimer.start()
                                            }
                                        }

                                        // Timer for applying momentum after drag release
                                        Timer {
                                            id: momentumTimer
                                            interval: 16 // About 60 FPS
                                            repeat: true
                                            onTriggered: {
                                                if (Math.abs(dragArea.velocityY) < 0.1) {
                                                    momentumTimer.stop()
                                                } else {
                                                    cardNode.eulerRotation.y += dragArea.velocityY
                                                    dragArea.velocityY *= dragArea.momentumDecay
                                                }
                                            }
                                        }
                                    }
                                }

                                Rectangle {
                                    id: rectangle1
                                    width: 280
                                    height: 426
                                    visible: true
                                    color: "#00ffffff"
                                    radius: 3
                                    border.color: "#128c17"
                                    border.width: 4
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                            // Trigger button to open/close drawer
                            MouseArea {
                                id: openButton
                                width: 28 // Width of the button
                                height: parent.height
                                opacity: 1
                                anchors.verticalCenter: customDrawer.verticalCenter
                                anchors.left: customDrawer.right // Keep the button attached to the right edge of the drawer
                                anchors.leftMargin: -7

                                cursorShape: Qt.PointingHandCursor // Change cursor to hand when hovering

                                z: 1
                                hoverEnabled: true
                                onEntered: {
                                    // Scale up on hover
                                    ballButton.scale = 0.7
                                }
                                onExited: {
                                    // Scale down when not hovered
                                    ballButton.scale = 0.6
                                }
                                onClicked: {
                                    if (customDrawer.x < 0) {

                                        customDrawer.x = 0
                                        _item.isDrawerOpen = true

                                        // Animate ball button rotation on drawer open
                                        rotateAnimation.from = ballButton.rotation
                                        rotateAnimation.to = 270 // Rotate by 90 degrees
                                        rotateAnimation.start()
                                    } else {

                                        customDrawer.x = -customDrawer.width + 12 // hide drawer
                                        _item.isDrawerOpen = false

                                        // Animate rotation on drawer close
                                        rotateAnimation.from = ballButton.rotation
                                        rotateAnimation.to = 90 // Reset to 0 degrees rotation
                                        rotateAnimation.start()
                                    }
                                }

                                // Background of the button
                                Rectangle {
                                    id: buttonBackground
                                    anchors.fill: parent
                                    color: "#ee1414" // Background color of the button
                                    radius: 0 // Rounded corners
                                    border.color: "#620808" // Darker border for a subtle effect
                                    border.width: 2
                                    MouseArea {
                                        onClicked: {
                                            if (customDrawer.x < 0) {
                                                customDrawer.x = 0
                                                _item.isDrawerOpen = true

                                                // Animate rotation on drawer open
                                                rotateAnimation.from = ballButton.rotation
                                                rotateAnimation.to = 270 // Rotate by 90 degrees
                                                rotateAnimation.start()
                                            } else {
                                                customDrawer.x = -customDrawer.width + 12
                                                _item.isDrawerOpen = false

                                                // Animate rotation on drawer close
                                                rotateAnimation.from = ballButton.rotation
                                                rotateAnimation.to
                                                        = 90 // Reset to 0 degrees rotation
                                                rotateAnimation.start()
                                            }
                                        }
                                    }


                                    Rectangle {
                                        id: rectangle29
                                        color: "#00ffffff"
                                        radius: 3
                                        border.color: "#ee0000"
                                        border.width: 2
                                        anchors.fill: parent
                                        anchors.leftMargin: 5
                                        anchors.rightMargin: 5
                                        anchors.topMargin: 10
                                        anchors.bottomMargin: 10
                                    } // Thin border
                                }

                                // Circle for the caret background
                                Rectangle {
                                    id: drawerCircle
                                    x: 8
                                    width: 26
                                    height: 26
                                    visible: false
                                    color: "#6c0101" // Circle color
                                    radius: 9
                                    border.color: "#c80d0d"
                                    border.width: 2
                                    anchors.verticalCenter: parent.verticalCenter // Make it a circle
                                    anchors.right: parent.right
                                    anchors.rightMargin: -10
                                    // Position the circle on the right side of the button

                                    // Smooth scaling animation
                                    Behavior on scale {
                                        NumberAnimation {
                                            duration: 200
                                            // easing: Easing.InOutQuad
                                        }
                                    }

                                    // MouseArea to detect hover events
                                    MouseArea {
                                        id: mouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor // Change cursor to hand when hovering

                                        onEntered: {
                                            // Scale up on hover
                                            drawerCircle.scale = 1.2
                                        }
                                        onExited: {
                                            // Scale down when not hovered
                                            drawerCircle.scale = 1
                                        }

                                        onClicked: {
                                            if (customDrawer.x < 0) {
                                                customDrawer.x = 0
                                                //customDrawer.isHoverEnabled = false

                                                // Slide in
                                                _item.isDrawerOpen = true
                                                // Animate rotation on drawer open
                                                rotateAnimation.from = ballButton.rotation
                                                rotateAnimation.to = 270 // Rotate by 90 degrees
                                                rotateAnimation.start()
                                            } else {
                                                customDrawer.x = -customDrawer.width
                                                        + 12 // Slide out

                                                //customDrawer.isHoverEnabled = true
                                                _item.isDrawerOpen = false
                                                // Animate rotation on drawer close
                                                rotateAnimation.from = ballButton.rotation
                                                rotateAnimation.to
                                                        = 90 // Reset to 0 degrees rotation
                                                rotateAnimation.start()
                                            }
                                        }
                                    }
                                }


                                Image {
                                    id: ballButton
                                    x: -4
                                    width: 60
                                    height: 60
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "ball.png"
                                    anchors.verticalCenterOffset: 0
                                    scale: 0.6
                                    mirror: false
                                    sourceSize.height: 50
                                    autoTransform: false
                                    mipmap: false
                                    fillMode: Image.Stretch
                                    rotation: 90 // Start with no rotation

                                    // Rotation animation
                                    NumberAnimation {
                                        id: rotateAnimation
                                        target: ballButton
                                        property: "rotation"
                                        duration: 500 // Duration of the rotation (in milliseconds)
                                    }

                                    // MouseArea to detect hover events
                                    MouseArea {
                                        id: ballMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor // Change cursor to hand when hovering

                                        onEntered: {
                                            // Scale up on hover
                                            ballButton.scale = 0.7
                                        }
                                        onExited: {
                                            // Scale down when not hovered
                                            ballButton.scale = 0.6
                                        }

                                        onClicked: {
                                            if (customDrawer.x < 0) {
                                                customDrawer.x = 0
                                                //customDrawer.isHoverEnabled = false

                                                // Slide in
                                                _item.isDrawerOpen = true
                                                // Animate rotation on drawer open
                                                rotateAnimation.from = ballButton.rotation
                                                rotateAnimation.to = 270 // Rotate by 90 degrees
                                                rotateAnimation.start()
                                            } else {
                                                customDrawer.x = -customDrawer.width
                                                        + 12 // Slide out

                                                //customDrawer.isHoverEnabled = true
                                                _item.isDrawerOpen = false
                                                // Animate rotation on drawer close
                                                rotateAnimation.from = ballButton.rotation
                                                rotateAnimation.to
                                                        = 90 // Reset to 0 degrees rotation
                                                rotateAnimation.start()
                                            }
                                        }
                                    }
                                }
                            }

                            // Define the animation
                            PropertyAnimation {
                                id: drawerAnimation
                                target: customDrawer
                                property: "x"
                                duration: 200  // Duration of the animation in milliseconds
                                easing.type: Easing.InOutQuad  // Easing function for smoothness
                            }

                            Rectangle {
                                id: dataFlow
                                opacity: 1
                                visible: true
                                color: "#541515"
                                border.width: 0
                                anchors.fill: parent
                                anchors.leftMargin: 35
                                anchors.rightMargin: 6
                                anchors.topMargin: 5
                                anchors.bottomMargin: 6
                                clip: true

                                Flickable {
                                    id: rightScrollView
                                    height: 399
                                    anchors.left: leftScrollView.right
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.leftMargin: 4
                                    anchors.rightMargin: 4
                                    anchors.topMargin: 4
                                    contentX: 0
                                    contentWidth: 250
                                    flickableDirection: Flickable.VerticalFlick
                                    clip: false
                                    boundsBehavior: Flickable.DragOverBounds
                                    boundsMovement: Flickable.FollowBoundsBehavior
                                    // Adjust width as needed
                                    // Set a height that fits your layout
                                    contentHeight: 500 // Set a suitable height for your content

                                    Column {
                                        id: rightSideColumn
                                        x: 0
                                        y: 0
                                        width: 186
                                        height: 400

                                        spacing: 3


                                        Rectangle {
                                            id: nameBlock
                                            width: 180
                                            height: 70
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            Rectangle {
                                                id: rectangle12
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 3
                                                anchors.bottomMargin: 3
                                            }

                                            Rectangle {
                                                id: nameScreen
                                                color: screenColor
                                                radius: 4
                                                border.color: "#128c17"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 11
                                                anchors.rightMargin: 11
                                                anchors.topMargin: 7
                                                anchors.bottomMargin: 7
                                                clip: true

                                                Text {
                                                    id: nameText
                                                    color: "#c5002a02"
                                                    // Safely access the name property
                                                    text: (selectedIndex >= 0
                                                           && selectedIndex < cards.length) ? cards[selectedIndex].name || "No Name Available" // Fallback if name is undefined
                                                                                            : "Name"
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    anchors.top: parent.top
                                                    anchors.bottom: parent.bottom
                                                    anchors.leftMargin: 4
                                                    anchors.rightMargin: 4
                                                    anchors.topMargin: 4
                                                    anchors.bottomMargin: 4
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    wrapMode: Text.Wrap
                                                    minimumPointSize: 8
                                                    minimumPixelSize: 8
                                                    font.pointSize: 30
                                                    z: 1
                                                    font.styleName: "Bold Italic"
                                                    fontSizeMode: Text.Fit
                                                }
                                                // Apply a DropShadow effect to the image
                                                DropShadow {
                                                    anchors.fill: nameText
                                                    source: nameText
                                                    // The image to which we are applying the shadow
                                                    horizontalOffset: 3 // Adjust X-axis shadow offset
                                                    verticalOffset: 3 // Adjust Y-axis shadow offset
                                                    radius: 3.8 // Blur effect, adjust for smoothness
                                                    samples: 16 // Higher value for smoother shadows
                                                    color: "#095f0c" // Color of the shadow
                                                    opacity: 0.8 // Transparency of the shadow
                                                }

                                                Text {
                                                    id: nameDropText
                                                    visible: false
                                                    color: "#2a7b2d"
                                                    text: nameText.text
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    anchors.top: parent.top
                                                    anchors.bottom: parent.bottom
                                                    anchors.leftMargin: 6
                                                    anchors.rightMargin: 2
                                                    anchors.topMargin: 7
                                                    anchors.bottomMargin: 1
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    wrapMode: Text.Wrap
                                                    minimumPointSize: 8
                                                    minimumPixelSize: 8
                                                    z: 0
                                                    fontSizeMode: Text.Fit
                                                    font.styleName: "Bold Italic"
                                                    font.pointSize: 30
                                                }

                                                Rectangle {
                                                    id: rectangle25
                                                    x: -8
                                                    y: -4
                                                    color: "#00ffffff"
                                                    radius: 4
                                                    border.color: "#25fb2e"
                                                    border.width: 1
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 3
                                                    anchors.rightMargin: 3
                                                    anchors.topMargin: 3
                                                    anchors.bottomMargin: 3
                                                }
                                            }
                                        }



                                        Rectangle {
                                            id: subtypeBlock
                                            width: 175
                                            height: 125
                                            color: "#00c80d0d"
                                            radius: 6
                                            border.color: "#006c0101"
                                            border.width: 0
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            Flow {
                                                id: subtypeFlow
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                layoutDirection: Qt.LeftToRight
                                                spacing: 3
                                                flow: Flow.LeftToRight

                                                Rectangle {
                                                    id: subtype1Block
                                                    width: 85
                                                    height: 60
                                                    visible: true
                                                    color: "#c80d0d"
                                                    radius: 6
                                                    border.color: "#6c0101"
                                                    border.width: 2

                                                    Rectangle {
                                                        id: subtype1Bezel
                                                        visible: true
                                                        color: "#b2b2b2"
                                                        radius: 8
                                                        border.color: "#616161"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        Layout.preferredHeight: 60
                                                        Layout.preferredWidth: 60
                                                        Layout.fillHeight: true
                                                        Layout.fillWidth: true

                                                        Rectangle {
                                                            id: subtype1Screen
                                                            x: 7
                                                            y: 4
                                                            color: screenColor
                                                            radius: 4
                                                            border.color: "#128c17"
                                                            border.width: 2
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            anchors.topMargin: 6
                                                            anchors.bottomMargin: 6
                                                            Text {
                                                                id: subtype1Text
                                                                color: "#c5002a02"
                                                                text: "Sub Type 1"
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                state: "base state4"
                                                                z: 1
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            DropShadow {
                                                                id: subtype1DropShadow
                                                                opacity: 0.8
                                                                color: "#095f0c"
                                                                radius: 3.8
                                                                anchors.fill: subtype1Text
                                                                source: subtype1Text
                                                                verticalOffset: 3
                                                                samples: 16
                                                                horizontalOffset: 3
                                                            }

                                                            Text {
                                                                id: subtype1DropText
                                                                visible: false
                                                                color: "#2a7b2d"
                                                                text: subtype1Text.text
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 0
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            Rectangle {
                                                                id: subtype1BlockHighlight
                                                                x: -8
                                                                y: -4
                                                                color: "#00ffffff"
                                                                radius: 4
                                                                border.color: "#25fb2e"
                                                                border.width: 1
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 3
                                                                anchors.rightMargin: 3
                                                                anchors.topMargin: 3
                                                                anchors.bottomMargin: 3
                                                            }
                                                            clip: true
                                                        }
                                                    }

                                                }

                                                Rectangle {
                                                    id: subtype2Block
                                                    width: 85
                                                    height: 60
                                                    visible: true
                                                    color: "#c80d0d"
                                                    radius: 6
                                                    border.color: "#6c0101"
                                                    border.width: 2
                                                    Rectangle {
                                                        id: subtype2Bezel
                                                        color: "#b2b2b2"
                                                        radius: 8
                                                        border.color: "#616161"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        Layout.preferredWidth: 60
                                                        Layout.preferredHeight: 60
                                                        Layout.fillHeight: true
                                                        Layout.fillWidth: true
                                                        Rectangle {
                                                            id: subtype2Screen
                                                            x: 7
                                                            y: 4
                                                            color: screenColor
                                                            radius: 4
                                                            border.color: "#128c17"
                                                            border.width: 2
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            anchors.topMargin: 6
                                                            anchors.bottomMargin: 6
                                                            Text {
                                                                id: subtype2Text
                                                                color: "#c5002a02"
                                                                text: "Sub Type 2"
                                                                // anchors.verticalCenter: subtype2DropShadow.verticalCenter
                                                                //anchors.right: subtype2DropShadow.left
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 1
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            DropShadow {
                                                                id: subtype2DropShadow
                                                                opacity: 0.8
                                                                color: "#095f0c"
                                                                radius: 3.8
                                                                anchors.fill: subtype2Text
                                                                source: subtype2Text
                                                                verticalOffset: 3
                                                                samples: 16
                                                                horizontalOffset: 3
                                                            }

                                                            Text {
                                                                id: subtype2DropText
                                                                visible: false
                                                                color: "#2a7b2d"
                                                                text: subtype2Text.text
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 0
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            Rectangle {
                                                                id: subtype2BlockHighlight
                                                                x: -8
                                                                y: -4
                                                                color: "#00ffffff"
                                                                radius: 4
                                                                border.color: "#25fb2e"
                                                                border.width: 1
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 3
                                                                anchors.rightMargin: 3
                                                                anchors.topMargin: 3
                                                                anchors.bottomMargin: 3
                                                            }
                                                            clip: true
                                                        }
                                                    }
                                                }

                                                Rectangle {
                                                    id: subtype3Block
                                                    width: 85
                                                    height: 60
                                                    visible: true
                                                    color: "#c80d0d"
                                                    radius: 6
                                                    border.color: "#6c0101"
                                                    border.width: 2
                                                    Rectangle {
                                                        id: subtype3Bezel
                                                        color: "#b2b2b2"
                                                        radius: 8
                                                        border.color: "#616161"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        Rectangle {
                                                            id: subtype3Screen
                                                            x: 7
                                                            y: 4
                                                            color: screenColor
                                                            radius: 4
                                                            border.color: "#128c17"
                                                            border.width: 2
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            anchors.topMargin: 6
                                                            anchors.bottomMargin: 6
                                                            Text {
                                                                id: subtype3Text
                                                                color: "#c5002a02"
                                                                text: "Sub Type 3"
                                                                //anchors.verticalCenter: subtype3DropShadow.verticalCenter
                                                                //anchors.right: subtype3DropShadow.left
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 1
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            DropShadow {
                                                                id: subtype3DropShadow
                                                                opacity: 0.8
                                                                color: "#095f0c"
                                                                radius: 3.8
                                                                anchors.fill: subtype3Text
                                                                source: subtype3Text
                                                                verticalOffset: 3
                                                                samples: 16
                                                                horizontalOffset: 3
                                                            }

                                                            Text {
                                                                id: subtype3DropText
                                                                visible: false
                                                                color: "#2a7b2d"
                                                                text: "Sub Type 3"
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 0
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            Rectangle {
                                                                id: subtype3BlockHighlight
                                                                x: -8
                                                                y: -4
                                                                color: "#00ffffff"
                                                                radius: 4
                                                                border.color: "#25fb2e"
                                                                border.width: 1
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 3
                                                                anchors.rightMargin: 3
                                                                anchors.topMargin: 3
                                                                anchors.bottomMargin: 3
                                                            }
                                                            clip: true
                                                        }
                                                        Layout.preferredWidth: 60
                                                        Layout.preferredHeight: 60
                                                        Layout.fillWidth: true
                                                        Layout.fillHeight: true
                                                    }
                                                }

                                                Rectangle {
                                                    id: subtype4Block
                                                    width: 85
                                                    height: 60
                                                    visible: true
                                                    color: "#c80d0d"
                                                    radius: 6
                                                    border.color: "#6c0101"
                                                    border.width: 2

                                                    Rectangle {
                                                        id: subtype4Bezel
                                                        color: "#b2b2b2"
                                                        radius: 8
                                                        border.color: "#616161"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        Rectangle {
                                                            id: subtype4Screen
                                                            x: 7
                                                            y: 4
                                                            color: screenColor
                                                            radius: 4
                                                            border.color: "#128c17"
                                                            border.width: 2
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            anchors.topMargin: 6
                                                            anchors.bottomMargin: 6
                                                            Text {
                                                                id: subtype4Text
                                                                color: "#c5002a02"
                                                                text: "Sub Type 4"
                                                                //                                       anchors.right: subtype4DropShadow.left
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 1
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            DropShadow {
                                                                id: subtype4DropShadow
                                                                opacity: 0.8
                                                                color: "#095f0c"
                                                                radius: 3.8
                                                                anchors.fill: subtype4Text
                                                                source: subtype4Text
                                                                verticalOffset: 3
                                                                samples: 16
                                                                horizontalOffset: 3
                                                            }

                                                            Text {
                                                                id: subtype4DropText
                                                                visible: false
                                                                color: "#2a7b2d"
                                                                text: "Sub Type 3"
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 0
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            Rectangle {
                                                                id: subtype4BlockHighlight
                                                                x: -8
                                                                y: -4
                                                                color: "#00ffffff"
                                                                radius: 4
                                                                border.color: "#25fb2e"
                                                                border.width: 1
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 3
                                                                anchors.rightMargin: 3
                                                                anchors.topMargin: 3
                                                                anchors.bottomMargin: 3
                                                            }
                                                            clip: true
                                                        }
                                                        Layout.preferredWidth: 60
                                                        Layout.preferredHeight: 60
                                                        Layout.fillWidth: true
                                                        Layout.fillHeight: true
                                                    }

                                                }
                                            }
                                        }

                                        Rectangle {
                                            id: typeBlock
                                            width: 175
                                            height: type1Block.height
                                            color: "#00c80d0d"
                                            radius: 6
                                            border.color: "#006c0101"
                                            border.width: 0
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            Flow {
                                                id: typeFlow
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                layoutDirection: Qt.LeftToRight
                                                spacing: 3
                                                flow: Flow.LeftToRight

                                                Rectangle {
                                                    id: type1Block
                                                    width: 85
                                                    height: 45
                                                    visible: true
                                                    color: "#c80d0d"
                                                    radius: 6
                                                    border.color: "#6c0101"
                                                    border.width: 2

                                                    Rectangle {
                                                        id: type1Bezel
                                                        visible: true
                                                        color: "#b2b2b2"
                                                        radius: 8
                                                        border.color: "#616161"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        Layout.preferredHeight: 60
                                                        Layout.preferredWidth: 60
                                                        Layout.fillHeight: true
                                                        Layout.fillWidth: true

                                                        Rectangle {
                                                            id: type1Screen
                                                            x: 7
                                                            y: 4
                                                            color: screenColor
                                                            radius: 4
                                                            border.color: "#128c17"
                                                            border.width: 2
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            anchors.topMargin: 6
                                                            anchors.bottomMargin: 6
                                                            Text {
                                                                id: type1Text
                                                                color: "#c5002a02"
                                                                text: "Type 1"
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                state: "base state4"
                                                                z: 1
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            DropShadow {
                                                                id: type1DropShadow
                                                                opacity: 0.8
                                                                color: "#095f0c"
                                                                radius: 3.8
                                                                anchors.fill: type1Text
                                                                source: type1Text
                                                                verticalOffset: 3
                                                                samples: 16
                                                                horizontalOffset: 3
                                                            }

                                                            Text {
                                                                id: type1DropText
                                                                visible: false
                                                                color: "#2a7b2d"
                                                                text: type1Text.text
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 0
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            Rectangle {
                                                                id: type1BlockHighlight
                                                                x: -8
                                                                y: -4
                                                                color: "#00ffffff"
                                                                radius: 4
                                                                border.color: "#25fb2e"
                                                                border.width: 1
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 3
                                                                anchors.rightMargin: 3
                                                                anchors.topMargin: 3
                                                                anchors.bottomMargin: 3
                                                            }
                                                            clip: true
                                                        }
                                                    }

                                                }

                                                Rectangle {
                                                    id: type2Block
                                                    width: type1Block.width
                                                    height: type1Block.height
                                                    visible: true
                                                    color: "#c80d0d"
                                                    radius: 6
                                                    border.color: "#6c0101"
                                                    border.width: 2
                                                    Rectangle {
                                                        id: type2Bezel
                                                        color: "#b2b2b2"
                                                        radius: 8
                                                        border.color: "#616161"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        Layout.preferredWidth: 60
                                                        Layout.preferredHeight: 60
                                                        Layout.fillHeight: true
                                                        Layout.fillWidth: true
                                                        Rectangle {
                                                            id: type2Screen
                                                            x: 7
                                                            y: 4
                                                            color: screenColor
                                                            radius: 4
                                                            border.color: "#128c17"
                                                            border.width: 2
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            anchors.topMargin: 6
                                                            anchors.bottomMargin: 6
                                                            Text {
                                                                id: type2Text
                                                                color: "#c5002a02"
                                                                text: "Type 2"
                                                                //anchors.verticalCenter: type2DropShadow.verticalCenter
                                                                //anchors.right: type2DropShadow.left
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 1
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            DropShadow {
                                                                id: type2DropShadow
                                                                opacity: 0.8
                                                                color: "#095f0c"
                                                                radius: 3.8
                                                                anchors.fill: type2Text
                                                                source: type2Text
                                                                verticalOffset: 3
                                                                samples: 16
                                                                horizontalOffset: 3
                                                            }

                                                            Text {
                                                                id: type2DropText
                                                                visible: false
                                                                color: "#2a7b2d"
                                                                text: type2Text.text
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 4
                                                                anchors.rightMargin: 4
                                                                anchors.topMargin: 4
                                                                anchors.bottomMargin: 4
                                                                horizontalAlignment: Text.AlignHCenter
                                                                verticalAlignment: Text.AlignVCenter
                                                                wrapMode: Text.Wrap
                                                                z: 0
                                                                minimumPointSize: 6
                                                                minimumPixelSize: 6
                                                                fontSizeMode: Text.Fit
                                                                font.styleName: "Bold Italic"
                                                                font.pointSize: 30
                                                            }

                                                            Rectangle {
                                                                id: type2BlockHighlight
                                                                x: -8
                                                                y: -4
                                                                color: "#00ffffff"
                                                                radius: 4
                                                                border.color: "#25fb2e"
                                                                border.width: 1
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 3
                                                                anchors.rightMargin: 3
                                                                anchors.topMargin: 3
                                                                anchors.bottomMargin: 3
                                                            }
                                                            clip: true
                                                        }
                                                    }
                                                }
                                            }
                                        }






                                        Rectangle {
                                            id: supertypeBlock
                                            width: 155
                                            height: 40
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            Rectangle {
                                                id: rectangle30
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 3
                                                anchors.bottomMargin: 3
                                            }

                                            Rectangle {
                                                id: supertypeScreen
                                                color: screenColor
                                                radius: 4
                                                border.color: "#128c17"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 11
                                                anchors.rightMargin: 11
                                                anchors.topMargin: 7
                                                anchors.bottomMargin: 7
                                                Text {
                                                    id: supertypeText
                                                    color: "#c5002a02"
                                                    text: "Super Type"
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    anchors.top: parent.top
                                                    anchors.bottom: parent.bottom
                                                    anchors.leftMargin: 4
                                                    anchors.rightMargin: 4
                                                    anchors.topMargin: 4
                                                    anchors.bottomMargin: 4
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    wrapMode: Text.Wrap
                                                    z: 1
                                                    minimumPointSize: 8
                                                    minimumPixelSize: 8
                                                    fontSizeMode: Text.Fit
                                                    font.styleName: "Bold Italic"
                                                    font.pointSize: 30
                                                }

                                                DropShadow {
                                                    opacity: 0.8
                                                    color: "#095f0c"
                                                    radius: 3.8
                                                    anchors.fill: supertypeText
                                                    source: supertypeText
                                                    verticalOffset: 3
                                                    samples: 16
                                                    horizontalOffset: 3
                                                }

                                                Text {
                                                    id: supertypeDropText
                                                    visible: false
                                                    color: "#2a7b2d"
                                                    text: supertypeText.text
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    anchors.top: parent.top
                                                    anchors.bottom: parent.bottom
                                                    anchors.leftMargin: 6
                                                    anchors.rightMargin: 2
                                                    anchors.topMargin: 7
                                                    anchors.bottomMargin: 1
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    wrapMode: Text.Wrap
                                                    z: 0
                                                    minimumPointSize: 8
                                                    minimumPixelSize: 8
                                                    fontSizeMode: Text.Fit
                                                    font.styleName: "Bold Italic"
                                                    font.pointSize: 30
                                                }

                                                Rectangle {
                                                    id: rectangle31
                                                    x: -8
                                                    y: -4
                                                    color: "#00ffffff"
                                                    radius: 4
                                                    border.color: "#25fb2e"
                                                    border.width: 1
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 3
                                                    anchors.rightMargin: 3
                                                    anchors.topMargin: 3
                                                    anchors.bottomMargin: 3
                                                }
                                                clip: true
                                            }
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }



                                        Rectangle {
                                            id: setLogoBlock
                                            width: 175
                                            height: 130
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            Rectangle {
                                                id: setLogoBezel
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 6
                                                anchors.rightMargin: 6
                                                anchors.topMargin: 6
                                                anchors.bottomMargin: 6
                                                state: "base state4"

                                                Rectangle {
                                                    id: setLogoScreen
                                                    x: 8
                                                    y: -1
                                                    color: screenColor
                                                    radius: 6
                                                    border.color: "#095f0c"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 10
                                                    anchors.rightMargin: 10
                                                    anchors.topMargin: 6
                                                    anchors.bottomMargin: 6
                                                    clip: true

                                                    Text {
                                                        id: setLogoText
                                                        color: "#c5002a02"
                                                        text: (selectedIndex >= 0
                                                               && selectedIndex < cards.length) ? "" // Fallback if name is undefined
                                                                                                : "Set Logo"
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        lineHeight: 0.8
                                                        wrapMode: Text.Wrap
                                                        font.family: "Ubuntu Sans"
                                                        z: 1
                                                        font.styleName: "ExtraBold Italic"
                                                        font.italic: false
                                                        font.bold: false
                                                        font.pointSize: 32
                                                        fontSizeMode: Text.Fit
                                                    }

                                                    // Apply a DropShadow effect to the image
                                                    DropShadow {
                                                        anchors.fill: setLogoText
                                                        source: setLogoText // The image to which we are applying the shadow
                                                        horizontalOffset: 5 // Adjust X-axis shadow offset
                                                        verticalOffset: 5 // Adjust Y-axis shadow offset
                                                        radius: 3.8 // Blur effect, adjust for smoothness
                                                        samples: 16 // Higher value for smoother shadows
                                                        color: "#095f0c" // Color of the shadow
                                                        opacity: 0.8 // Transparency of the shadow
                                                    }

                                                    Image {
                                                        id: setLogoImage
                                                        anchors.verticalCenter: setLogoText.verticalCenter
                                                        anchors.right: parent.right
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 6
                                                        anchors.rightMargin: 6
                                                        anchors.topMargin: 6
                                                        anchors.bottomMargin: 6
                                                        source: (selectedIndex >= 0
                                                                 && selectedIndex < cards.length) ? cards[selectedIndex].setLogo : ""
                                                        z: 1

                                                        scale: 1
                                                        fillMode: Image.PreserveAspectFit
                                                    }
                                                    // Apply a DropShadow effect to the image
                                                    DropShadow {
                                                        anchors.fill: setLogoImage
                                                        source: setLogoImage // The image to which we are applying the shadow
                                                        horizontalOffset: 5 // Adjust X-axis shadow offset
                                                        verticalOffset: 5 // Adjust Y-axis shadow offset
                                                        radius: 3.8 // Blur effect, adjust for smoothness
                                                        samples: 16 // Higher value for smoother shadows
                                                        color: "#095f0c" // Color of the shadow
                                                        opacity: 0.8 // Transparency of the shadow
                                                    }

                                                    Text {
                                                        id: setLogoDropText
                                                        x: 1
                                                        y: 2
                                                        visible: false
                                                        color: "#2a7b2d"
                                                        text: (selectedIndex >= 0
                                                               && selectedIndex < cards.length) ? "" // Fallback if name is undefined
                                                                                                : "Set Logo"
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: -4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: -4
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        lineHeight: 0.8
                                                        wrapMode: Text.Wrap
                                                        z: 0
                                                        fontSizeMode: Text.Fit
                                                        font.styleName: "ExtraBold Italic"
                                                        font.pointSize: 32
                                                        font.italic: false
                                                        font.family: "Ubuntu Sans"
                                                        font.bold: false
                                                    }

                                                    Rectangle {
                                                        id: rectangle28
                                                        x: -13
                                                        y: -9
                                                        color: "#00ffffff"
                                                        radius: 4
                                                        border.color: "#25fb2e"
                                                        border.width: 1
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 3
                                                        anchors.rightMargin: 3
                                                        anchors.topMargin: 3
                                                        anchors.bottomMargin: 3
                                                    }
                                                }
                                            }
                                        }


                                        // Rectangle {
                                        //     id: setLogoBlock
                                        //     width: 175
                                        //     height: 130
                                        //     color: "#c80d0d"
                                        //     radius: 8
                                        //     border.color: "#6c0101"
                                        //     border.width: 2
                                        //     anchors.horizontalCenter: parent.horizontalCenter

                                        //     Rectangle {
                                        //         id: setLogoBezel
                                        //         color: "#b2b2b2"
                                        //         radius: 8
                                        //         border.color: "#616161"
                                        //         border.width: 2
                                        //         anchors.fill: parent
                                        //         anchors.leftMargin: 6
                                        //         anchors.rightMargin: 6
                                        //         anchors.topMargin: 6
                                        //         anchors.bottomMargin: 6
                                        //         state: "base state4"

                                        //         Rectangle {
                                        //             id: setLogoScreen
                                        //             x: 8
                                        //             y: -1
                                        //             color: screenColor
                                        //             radius: 6
                                        //             border.color: "#095f0c"
                                        //             border.width: 2
                                        //             anchors.fill: parent
                                        //             anchors.leftMargin: 10
                                        //             anchors.rightMargin: 10
                                        //             anchors.topMargin: 6
                                        //             anchors.bottomMargin: 6
                                        //             clip: true

                                        //             Text {
                                        //                 id: setLogoText
                                        //                 color: "#c5002a02"
                                        //                 text: (selectedIndex >= 0
                                        //                        && selectedIndex < cards.length) ? "" // Fallback if name is undefined
                                        //                                                         : "Set Logo"
                                        //                 anchors.fill: parent
                                        //                 horizontalAlignment: Text.AlignHCenter
                                        //                 verticalAlignment: Text.AlignVCenter
                                        //                 lineHeight: 0.8
                                        //                 wrapMode: Text.Wrap
                                        //                 font.family: "Ubuntu Sans"
                                        //                 z: 1
                                        //                 font.styleName: "ExtraBold Italic"
                                        //                 font.italic: false
                                        //                 font.bold: false
                                        //                 font.pointSize: 32
                                        //                 fontSizeMode: Text.Fit
                                        //             }

                                        //             // Apply a DropShadow effect to the image
                                        //             DropShadow {
                                        //                 anchors.fill: setLogoText
                                        //                 source: setLogoText // The image to which we are applying the shadow
                                        //                 horizontalOffset: 5 // Adjust X-axis shadow offset
                                        //                 verticalOffset: 5 // Adjust Y-axis shadow offset
                                        //                 radius: 3.8 // Blur effect, adjust for smoothness
                                        //                 samples: 16 // Higher value for smoother shadows
                                        //                 color: "#095f0c" // Color of the shadow
                                        //                 opacity: 0.8 // Transparency of the shadow
                                        //             }

                                        //             Image {
                                        //                 id: setLogoImage
                                        //                 anchors.verticalCenter: setLogoText.verticalCenter
                                        //                 anchors.right: parent.right
                                        //                 anchors.fill: parent
                                        //                 anchors.leftMargin: 6
                                        //                 anchors.rightMargin: 6
                                        //                 anchors.topMargin: 6
                                        //                 anchors.bottomMargin: 6
                                        //                 source: (selectedIndex >= 0
                                        //                          && selectedIndex < cards.length) ? cards[selectedIndex].setLogo : ""
                                        //                 z: 1

                                        //                 scale: 1
                                        //                 fillMode: Image.PreserveAspectFit
                                        //             }
                                        //             // Apply a DropShadow effect to the image
                                        //             DropShadow {
                                        //                 anchors.fill: setLogoImage
                                        //                 source: setLogoImage // The image to which we are applying the shadow
                                        //                 horizontalOffset: 5 // Adjust X-axis shadow offset
                                        //                 verticalOffset: 5 // Adjust Y-axis shadow offset
                                        //                 radius: 3.8 // Blur effect, adjust for smoothness
                                        //                 samples: 16 // Higher value for smoother shadows
                                        //                 color: "#095f0c" // Color of the shadow
                                        //                 opacity: 0.8 // Transparency of the shadow
                                        //             }

                                        //             Text {
                                        //                 id: setLogoDropText
                                        //                 x: 1
                                        //                 y: 2
                                        //                 visible: false
                                        //                 color: "#2a7b2d"
                                        //                 text: (selectedIndex >= 0
                                        //                        && selectedIndex < cards.length) ? "" // Fallback if name is undefined
                                        //                                                         : "Set Logo"
                                        //                 anchors.fill: parent
                                        //                 anchors.leftMargin: 4
                                        //                 anchors.rightMargin: -4
                                        //                 anchors.topMargin: 4
                                        //                 anchors.bottomMargin: -4
                                        //                 horizontalAlignment: Text.AlignHCenter
                                        //                 verticalAlignment: Text.AlignVCenter
                                        //                 lineHeight: 0.8
                                        //                 wrapMode: Text.Wrap
                                        //                 z: 0
                                        //                 fontSizeMode: Text.Fit
                                        //                 font.styleName: "ExtraBold Italic"
                                        //                 font.pointSize: 32
                                        //                 font.italic: false
                                        //                 font.family: "Ubuntu Sans"
                                        //                 font.bold: false
                                        //             }

                                        //             Rectangle {
                                        //                 id: rectangle28
                                        //                 x: -13
                                        //                 y: -9
                                        //                 color: "#00ffffff"
                                        //                 radius: 4
                                        //                 border.color: "#25fb2e"
                                        //                 border.width: 1
                                        //                 anchors.fill: parent
                                        //                 anchors.leftMargin: 3
                                        //                 anchors.rightMargin: 3
                                        //                 anchors.topMargin: 3
                                        //                 anchors.bottomMargin: 3
                                        //             }
                                        //         }
                                        //     }
                                        // }


                                        Row {
                                            id: row
                                            width: 176
                                            height: 66
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            spacing: 3

                                            Rectangle {
                                                id: setSymbolBlock
                                                width: 75
                                                height: 65
                                                color: "#c80d0d"
                                                radius: 8
                                                border.color: "#6c0101"
                                                border.width: 2

                                                Rectangle {
                                                    id: setSymbolBezel
                                                    color: "#b2b2b2"
                                                    radius: 8
                                                    border.color: "#616161"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 4
                                                    anchors.rightMargin: 4
                                                    anchors.topMargin: 3
                                                    anchors.bottomMargin: 3

                                                    Rectangle {
                                                        id: setSymbolScreen
                                                        color: screenColor
                                                        radius: 6
                                                        border.color: "#128c17"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        clip: true

                                                        Image {
                                                            id: setSymbolImage
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            anchors.topMargin: 6
                                                            anchors.bottomMargin: 6

                                                            source: (selectedIndex >= 0
                                                                     && selectedIndex < cards.length) ? cards[selectedIndex].setSymbol : ""
                                                            z: 1
                                                            fillMode: Image.PreserveAspectFit
                                                        }
                                                        // Apply a DropShadow effect to the image
                                                        DropShadow {
                                                            anchors.fill: setSymbolImage
                                                            source: setSymbolImage // The image to which we are applying the shadow
                                                            horizontalOffset: 5 // Adjust X-axis shadow offset
                                                            verticalOffset: 5 // Adjust Y-axis shadow offset
                                                            radius: 3.8 // Blur effect, adjust for smoothness
                                                            samples: 16 // Higher value for smoother shadows
                                                            color: "#095f0c" // Color of the shadow
                                                            opacity: 0.8 // Transparency of the shadow
                                                        }

                                                        Text {
                                                            id: setSymbolText
                                                            color: "#c5002a02"
                                                            text: (selectedIndex >= 0
                                                                   && selectedIndex < cards.length) ? "" // Fallback if name is undefined
                                                                                                    : "Set Symbol"
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 2
                                                            anchors.rightMargin: 2
                                                            anchors.topMargin: 2
                                                            anchors.bottomMargin: 2
                                                            horizontalAlignment: Text.AlignHCenter
                                                            verticalAlignment: Text.AlignVCenter
                                                            wrapMode: Text.Wrap
                                                            minimumPointSize: 6
                                                            minimumPixelSize: 6
                                                            z: 1
                                                            font.pointSize: 10
                                                            font.styleName: "ExtraBold Italic"
                                                            fontSizeMode: Text.Fit
                                                        }

                                                        // Apply a DropShadow effect to the image
                                                        DropShadow {
                                                            anchors.fill: setSymbolText
                                                            source: setSymbolText // The image to which we are applying the shadow
                                                            horizontalOffset: 3 // Adjust X-axis shadow offset
                                                            verticalOffset: 3 // Adjust Y-axis shadow offset
                                                            radius: 3.8 // Blur effect, adjust for smoothness
                                                            samples: 16 // Higher value for smoother shadows
                                                            color: "#095f0c" // Color of the shadow
                                                            opacity: 0.8 // Transparency of the shadow
                                                        }

                                                        Text {
                                                            id: setSymbolDropText
                                                            color: "#095f0c"
                                                            text: setSymbolText.text
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 2
                                                            anchors.rightMargin: 2
                                                            anchors.topMargin: 2
                                                            anchors.bottomMargin: 2
                                                            horizontalAlignment: Text.AlignHCenter
                                                            verticalAlignment: Text.AlignVCenter
                                                            wrapMode: Text.Wrap
                                                            minimumPointSize: 6
                                                            minimumPixelSize: 6
                                                            z: 0
                                                            fontSizeMode: Text.Fit
                                                            font.styleName: "ExtraBold Italic"
                                                            font.pointSize: 10
                                                        }

                                                        Rectangle {
                                                            id: rectangle27
                                                            x: -5
                                                            y: -4
                                                            color: "#00ffffff"
                                                            radius: 4
                                                            border.color: "#25fb2e"
                                                            border.width: 1
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 3
                                                            anchors.rightMargin: 3
                                                            anchors.topMargin: 3
                                                            anchors.bottomMargin: 3
                                                        }
                                                    }
                                                }
                                            }

                                            Rectangle {
                                                id: setBlock
                                                width: 98
                                                height: 65
                                                color: "#c80d0d"
                                                radius: 8
                                                border.color: "#6c0101"
                                                border.width: 2

                                                Rectangle {
                                                    id: setNameBezel
                                                    color: "#b2b2b2"
                                                    radius: 8
                                                    border.color: "#6c0101"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 4
                                                    anchors.rightMargin: 4
                                                    anchors.topMargin: 3
                                                    anchors.bottomMargin: 3

                                                    Rectangle {
                                                        id: setNameScreen
                                                        x: 10
                                                        y: 4
                                                        color: screenColor
                                                        radius: 6
                                                        border.color: "#128c17"
                                                        border.width: 2
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 6
                                                        anchors.rightMargin: 6
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        clip: true

                                                        Text {
                                                            id: setNameText
                                                            color: "#c5002a02"
                                                            // Safely access the name property
                                                            text: (selectedIndex >= 0
                                                                   && selectedIndex < cards.length) ? cards[selectedIndex].set || "No Name Available" // Fallback if name is undefined
                                                                                                    : "Set Name"
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 4
                                                            anchors.rightMargin: 4
                                                            anchors.topMargin: 4
                                                            anchors.bottomMargin: 4

                                                            // Fallback when no card is selected
                                                            horizontalAlignment: Text.AlignHCenter
                                                            verticalAlignment: Text.AlignVCenter
                                                            wrapMode: Text.Wrap
                                                            font.pointSize: 13
                                                            minimumPointSize: 6
                                                            minimumPixelSize: 6
                                                            z: 1
                                                            font.styleName: "ExtraBold Italic"
                                                            fontSizeMode: Text.Fit
                                                        }
                                                        // Apply a DropShadow effect to the image
                                                        DropShadow {
                                                            anchors.fill: setNameText
                                                            source: setNameText // The image to which we are applying the shadow
                                                            horizontalOffset: 5 // Adjust X-axis shadow offset
                                                            verticalOffset: 5 // Adjust Y-axis shadow offset
                                                            radius: 3.8 // Blur effect, adjust for smoothness
                                                            samples: 16 // Higher value for smoother shadows
                                                            color: "#095f0c" // Color of the shadow
                                                            opacity: 0.8 // Transparency of the shadow
                                                        }

                                                        Text {
                                                            id: setNameDropText
                                                            color: "#095f0c"
                                                            text: setNameText.text
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 4
                                                            anchors.rightMargin: 4
                                                            anchors.topMargin: 4
                                                            anchors.bottomMargin: 4
                                                            horizontalAlignment: Text.AlignHCenter
                                                            verticalAlignment: Text.AlignVCenter
                                                            wrapMode: Text.Wrap
                                                            font.pointSize: 13
                                                            z: 0
                                                            minimumPointSize: 6
                                                            minimumPixelSize: 6
                                                            fontSizeMode: Text.Fit
                                                            font.styleName: "ExtraBold Italic"
                                                        }

                                                        Rectangle {
                                                            id: rectangle26
                                                            x: -7
                                                            y: -4
                                                            color: "#00ffffff"
                                                            radius: 4
                                                            border.color: "#25fb2e"
                                                            border.width: 1
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 3
                                                            anchors.rightMargin: 3
                                                            anchors.topMargin: 3
                                                            anchors.bottomMargin: 3
                                                        }
                                                    }
                                                }
                                            }
                                        }



                                    }
                                }

                                Flickable {
                                    id: leftScrollView
                                    width: 250
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.leftMargin: 15
                                    anchors.topMargin: 4
                                    anchors.bottomMargin: 4
                                    contentWidth: 250
                                    clip: false
                                    boundsBehavior: Flickable.DragOverBounds
                                    boundsMovement: Flickable.FollowBoundsBehavior
                                    flickableDirection: Flickable.VerticalFlick
                                    // Adjust width as needed
                                    // Set a height that fits your layout
                                    contentHeight: 1170 // Set a suitable height for your content

                                    // First attack
                                    Column {
                                        id: column
                                        x: 0
                                        width: 250
                                        height: 1132
                                        anchors.top: parent.top
                                        anchors.topMargin: 4
                                        spacing: 8

                                        AttackInfoBlock {
                                            id: attack1Block
                                            width: 250
                                            height: 200
                                            nameText: "Attack 1"
                                            mainColor: window.primaryColor
                                            bezelColor: window.bezelColor
                                            screenColor: window.screenColor
                                            textColor: window.textColor
                                            dropTextColor: window.dropTextColor
                                            borderColor: window.borderColor
                                            dropBorderColor: window.dropBorderColor
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        AttackInfoBlock {
                                            id: attack2Block
                                            width: 250
                                            height: 200
                                            nameText: "Attack 2"
                                            mainColor: window.primaryColor
                                            bezelColor: window.bezelColor
                                            screenColor: window.screenColor
                                            textColor: window.textColor
                                            dropTextColor: window.dropTextColor
                                            borderColor: window.borderColor
                                            dropBorderColor: window.dropBorderColor
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        AttackInfoBlock {
                                            id: attack3Block
                                            width: 250
                                            height: 200
                                            nameText: "Attack 3"
                                            mainColor: window.primaryColor
                                            bezelColor: window.bezelColor
                                            screenColor: window.screenColor
                                            textColor: window.textColor
                                            dropTextColor: window.dropTextColor
                                            borderColor: window.borderColor
                                            dropBorderColor: window.dropBorderColor
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        AttackInfoBlock {
                                            id: attack4Block
                                            width: 250
                                            height: 200
                                            nameText: "Attack 4"
                                            mainColor: window.primaryColor
                                            bezelColor: window.bezelColor
                                            screenColor: window.screenColor
                                            textColor: window.textColor
                                            dropTextColor: window.dropTextColor
                                            borderColor: window.borderColor
                                            dropBorderColor: window.dropBorderColor
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Rectangle {
                                            id: ability1NameBlock
                                            width: 200
                                            height: 45
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            Rectangle {
                                                id: ability1NameBezel
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 3
                                                anchors.bottomMargin: 3
                                                Rectangle {
                                                    id: ability1NameScreen
                                                    x: 10
                                                    y: 4
                                                    color: screenColor
                                                    radius: 4
                                                    border.color: "#128c17"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 5
                                                    anchors.rightMargin: 5
                                                    anchors.topMargin: 6
                                                    anchors.bottomMargin: 6
                                                    Text {
                                                        id: ability1NameText
                                                        color: "#c5002a02"
                                                        text: "Ability 1"
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        minimumPointSize: 10
                                                        minimumPixelSize: 10
                                                        z: 1
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Text {
                                                        id: ability1NameDropText
                                                        color: "#095f0c"
                                                        text: ability1NameText.text
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        minimumPointSize: 10
                                                        minimumPixelSize: 10
                                                        z: 0
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Rectangle {
                                                        id: rectangle16
                                                        x: -6
                                                        y: -6
                                                        color: "#00ffffff"
                                                        radius: 4
                                                        border.color: "#25fb2e"
                                                        border.width: 1
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 3
                                                        anchors.rightMargin: 3
                                                        anchors.topMargin: 3
                                                        anchors.bottomMargin: 3
                                                    }
                                                }
                                            }
                                        }


                                        Rectangle {
                                            id: ability1TypeBlock
                                            width: 175
                                            height: 45
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            Rectangle {
                                                id: ability1TypeBezel
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 3
                                                anchors.bottomMargin: 3
                                                Rectangle {
                                                    id: ability1TypeScreen
                                                    x: 10
                                                    y: 4
                                                    color: screenColor
                                                    radius: 4
                                                    border.color: "#128c17"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 5
                                                    anchors.rightMargin: 5
                                                    anchors.topMargin: 6
                                                    anchors.bottomMargin: 6
                                                    Text {
                                                        id: ability1TypeText
                                                        color: "#c5002a02"
                                                        text: "Ability 1 Type"
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        z: 1
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Text {
                                                        id: ability1TypeDropText
                                                        color: "#095f0c"
                                                        text: ability1TypeText.text
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Rectangle {
                                                        id: rectangle17
                                                        x: -6
                                                        y: -6
                                                        color: "#00ffffff"
                                                        radius: 4
                                                        border.color: "#25fb2e"
                                                        border.width: 1
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 3
                                                        anchors.rightMargin: 3
                                                        anchors.topMargin: 3
                                                        anchors.bottomMargin: 3
                                                    }
                                                }
                                            }
                                        }


                                        Rectangle {
                                            id: ability1DescriptionBlock
                                            width: 250
                                            height: 136
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            Rectangle {
                                                id: ability1DescriptionBezel
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 4
                                                anchors.bottomMargin: 4
                                                Rectangle {
                                                    id: ability1DescriptionScreen
                                                    x: 10
                                                    y: 4
                                                    color: screenColor
                                                    radius: 6
                                                    border.color: "#128c17"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 6
                                                    anchors.rightMargin: 6
                                                    anchors.topMargin: 6
                                                    anchors.bottomMargin: 6
                                                    Text {
                                                        id: ability1DescriptionDropText
                                                        visible: true
                                                        color: "#c5002a02"
                                                        text: "Ability 1 Description"
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        z: 1
                                                        minimumPointSize: 6
                                                        minimumPixelSize: 6
                                                        fontSizeMode: Text.Fit
                                                        font.styleName: "ExtraBold Italic"
                                                        font.pointSize: ability1DescriptionText.font.pointSize
                                                    }

                                                    Text {
                                                        id: ability1DescriptionText
                                                        color: "#095f0c"
                                                        text: ability1DescriptionDropText.text
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        z: 0
                                                        minimumPointSize: 6
                                                        minimumPixelSize: 6
                                                        fontSizeMode: Text.Fit
                                                        font.styleName: "ExtraBold Italic"
                                                        font.pointSize: ability1DescriptionDropText.font.pointSize
                                                    }

                                                    Rectangle {
                                                        id: rectangle21
                                                        x: -7
                                                        y: 13
                                                        color: "#00ffffff"
                                                        radius: 4
                                                        border.color: "#25fb2e"
                                                        border.width: 1
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 3
                                                        anchors.rightMargin: 3
                                                        anchors.topMargin: 3
                                                        anchors.bottomMargin: 3
                                                    }
                                                }
                                            }
                                        }


                                        Rectangle {
                                            id: ability2NameBlock
                                            width: 200
                                            height: 45
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            Rectangle {
                                                id: ability2NameBezel
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 3
                                                anchors.bottomMargin: 3
                                                Rectangle {
                                                    id: ability2NameScreen
                                                    x: 10
                                                    y: 4
                                                    color: screenColor
                                                    radius: 4
                                                    border.color: "#128c17"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 5
                                                    anchors.rightMargin: 5
                                                    anchors.topMargin: 6
                                                    anchors.bottomMargin: 6
                                                    Text {
                                                        id: ability2NameText
                                                        color: "#c5002a02"
                                                        text: "Ability 2"
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        minimumPointSize: 10
                                                        minimumPixelSize: 10
                                                        z: 1
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Text {
                                                        id: ability2NameDropText
                                                        color: "#095f0c"
                                                        text: ability2NameText.text
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        minimumPointSize: 10
                                                        minimumPixelSize: 10
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Rectangle {
                                                        id: rectangle18
                                                        x: -6
                                                        y: -6
                                                        color: "#00ffffff"
                                                        radius: 4
                                                        border.color: "#25fb2e"
                                                        border.width: 1
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 3
                                                        anchors.rightMargin: 3
                                                        anchors.topMargin: 3
                                                        anchors.bottomMargin: 3
                                                    }
                                                }
                                            }
                                        }


                                        Rectangle {
                                            id: ability2TypeBlock
                                            width: 175
                                            height: 45
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            Rectangle {
                                                id: ability2TypeBezel
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 3
                                                anchors.bottomMargin: 3
                                                Rectangle {
                                                    id: ability2TypeScreen
                                                    x: 10
                                                    y: 4
                                                    color: screenColor
                                                    radius: 4
                                                    border.color: "#128c17"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 5
                                                    anchors.rightMargin: 5
                                                    anchors.topMargin: 6
                                                    anchors.bottomMargin: 6
                                                    Text {
                                                        id: ability2TypeText
                                                        color: "#c5002a02"
                                                        text: "Ability 2 Type"
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        z: 1
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Text {
                                                        id: ability2TypeDropText
                                                        color: "#095f0c"
                                                        text: ability2TypeText.text
                                                        anchors.fill: parent
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        z: 0
                                                        fontSizeMode: Text.HorizontalFit
                                                        font.styleName: "ExtraBold Italic"
                                                    }

                                                    Rectangle {
                                                        id: rectangle19
                                                        x: -6
                                                        y: -6
                                                        color: "#00ffffff"
                                                        radius: 4
                                                        border.color: "#25fb2e"
                                                        border.width: 1
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 3
                                                        anchors.rightMargin: 3
                                                        anchors.topMargin: 3
                                                        anchors.bottomMargin: 3
                                                    }
                                                }
                                            }
                                        }


                                        Rectangle {
                                            id: ability2DescriptionBlock
                                            width: 250
                                            height: 136
                                            color: "#c80d0d"
                                            radius: 8
                                            border.color: "#6c0101"
                                            border.width: 2
                                            Rectangle {
                                                id: ability2DescriptionBezel
                                                color: "#b2b2b2"
                                                radius: 8
                                                border.color: "#616161"
                                                border.width: 2
                                                anchors.fill: parent
                                                anchors.leftMargin: 4
                                                anchors.rightMargin: 4
                                                anchors.topMargin: 4
                                                anchors.bottomMargin: 4
                                                Rectangle {
                                                    id: ability2DescriptionScreen
                                                    x: 10
                                                    y: 4
                                                    color: screenColor
                                                    radius: 6
                                                    border.color: "#128c17"
                                                    border.width: 2
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 6
                                                    anchors.rightMargin: 6
                                                    anchors.topMargin: 6
                                                    anchors.bottomMargin: 6
                                                    Text {
                                                        id: ability2DescriptionDropText
                                                        visible: true
                                                        color: "#c5002a02"
                                                        text: "Ability 2 Description"
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        z: 1
                                                        minimumPointSize: 6
                                                        minimumPixelSize: 6
                                                        fontSizeMode: Text.Fit
                                                        font.styleName: "ExtraBold Italic"
                                                        font.pointSize: ability2DescriptionText.font.pointSize
                                                    }

                                                    Text {
                                                        id: ability2DescriptionText
                                                        color: "#095f0c"
                                                        text: ability2DescriptionDropText.text
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 4
                                                        anchors.rightMargin: 4
                                                        anchors.topMargin: 4
                                                        anchors.bottomMargin: 4
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignVCenter
                                                        wrapMode: Text.Wrap
                                                        z: 0
                                                        minimumPointSize: 6
                                                        minimumPixelSize: 6
                                                        fontSizeMode: Text.Fit
                                                        font.styleName: "ExtraBold Italic"
                                                        font.pointSize: ability2DescriptionDropText.font.pointSize
                                                    }

                                                    Rectangle {
                                                        id: rectangle20
                                                        x: -7
                                                        y: 18
                                                        color: "#00ffffff"
                                                        radius: 4
                                                        border.color: "#25fb2e"
                                                        border.width: 1
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 3
                                                        anchors.rightMargin: 3
                                                        anchors.topMargin: 3
                                                        anchors.bottomMargin: 3
                                                    }
                                                }
                                            }
                                        }

                                    }
                                }
                            }
                        }
                    }

                    ToolBar {
                        id: pagingButtonsToolbar
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        RowLayout {
                            height: 26
                            visible: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            z: 1
                            uniformCellSizes: false
                            spacing: 120

                            Button {
                                id: button
                                text: "Previous"
                                Layout.fillHeight: false
                                Layout.fillWidth: false
                                highlighted: false
                                flat: false
                                font.styleName: "Bold Italic"
                                enabled: selectedIndex > 0
                                onClicked: {
                                    onPrevCard()
                                }
                                palette {
                                    button: "blue"
                                }

                                Rectangle {
                                    id: rectangle9
                                    color: "#00ffffff"
                                    radius: 3
                                    border.color: "#6c0101"
                                    border.width: 2
                                    anchors.fill: parent
                                    anchors.leftMargin: -1
                                    anchors.rightMargin: 0
                                    anchors.topMargin: -1
                                    anchors.bottomMargin: -1
                                }
                                hoverEnabled: true

                                ToolTip.delay: 800
                                ToolTip.timeout: 5000
                                ToolTip.visible: hovered
                                ToolTip.text: qsTr("See the previous card in the search results.")

                                // Change scale when hovered
                                scale: hovered ? 1.05 : 1.0
                            }

                            Button {
                                text: "Next"
                                font.styleName: "Bold Italic"
                                font.pointSize: 11
                                font.bold: true
                                enabled: selectedIndex < cards.length - 1
                                onClicked: {
                                    onNextCard()
                                }
                                palette {
                                    button: "blue"
                                }

                                Rectangle {
                                    id: rectangle10
                                    x: -134
                                    y: -6
                                    color: "#00ffffff"
                                    radius: 3
                                    border.color: "#6c0101"
                                    border.width: 2
                                    anchors.fill: parent
                                    anchors.leftMargin: -1
                                    anchors.rightMargin: 0
                                    anchors.topMargin: -1
                                    anchors.bottomMargin: -1
                                }
                                hoverEnabled: true

                                ToolTip.delay: 800
                                ToolTip.timeout: 5000
                                ToolTip.visible: hovered
                                ToolTip.text: qsTr("See the next card in the search results.")

                                // Change scale when hovered
                                scale: hovered ? 1.05 : 1.0
                            }
                        }

                        Rectangle {
                            id: rectangle
                            color: "#951111"
                            radius: 4
                            border.color: "#cc1c1c"
                            border.width: 8
                            anchors.fill: parent
                            anchors.leftMargin: -6
                            anchors.rightMargin: -6
                            anchors.topMargin: 0
                            anchors.bottomMargin: 0
                            z: 0

                            Rectangle {
                                id: rectangle100
                                color: "#00ffffff"
                                radius: 3
                                border.color: "#ee0000"
                                border.width: 2
                                anchors.fill: parent
                            }
                        }

                        Rectangle {
                            id: rectangle2
                            color: "#00951111"
                            radius: 3
                            border.color: "#6c0101"
                            border.width: 2
                            anchors.fill: parent
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            anchors.topMargin: 8
                            anchors.bottomMargin: 8
                            z: 0
                        }

                        Rectangle {
                            id: rectangle3
                            color: "#00951111"
                            radius: 4
                            border.color: "#6c0101"
                            border.width: 2
                            anchors.fill: parent
                            anchors.leftMargin: -6
                            anchors.rightMargin: -6
                            anchors.topMargin: 0
                            anchors.bottomMargin: 0
                            z: 0
                        }

                        Rectangle {
                            id: rectangle11
                            y: 20
                            color: "#00951111"
                            radius: 3
                            border.color: "#6c0101"
                            border.width: 2
                            anchors.fill: parent
                            z: 0

                            Text {
                                id: _text
                                width: 109
                                height: 30
                                color: "#ffffff"
                                text: cards.length ? (selectedIndex + 1) + "/" + cards.length : "-/-"
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                                anchors.horizontalCenter: parent.horizontalCenter
                                fontSizeMode: Text.HorizontalFit
                                font.styleName: "Bold Italic"
                            }
                        }
                    }

                }

                ListModel {
                    id: imageModel
                    // Initial empty list
                }
            }

            Connections {
                target: backendController
                function onSearchResults(response) {

                    var data = JSON.parse(response)

                    if (data.error) {
                        console.log("Error in response:",
                                    data.error) // Log the error message
                        cards = []
                    } else {
                        cards = data.map(card => ({
                                                      "name": card.name,
                                                      "supertype": card.supertype,
                                                      "type1": card.type1,
                                                      "type2": card.type2,

                                                      // Card Scan Image Hi-Res
                                                      "imageUrl": card.imageUrl
                                                                  || "",

                                                      "set": card.set,
                                                      "setSymbol": card.setSymbol,
                                                      "setLogo": card.setLogo,

                                                      // Ability 1
                                                      "ability1Name": card.ability1Name || "",
                                                      "ability1Text": card.ability1Text || "",
                                                      "ability1Type": card.ability1Type || "",

                                                      // Ability 2
                                                      "ability2Name": card.ability2Name || "",
                                                      "ability2Text": card.ability2Text || "",
                                                      "ability2Type": card.ability2Type || "",

                                                      // Attack 1
                                                      "attack1Name": card.attack1Name || "",
                                                      "attack1Text": card.attack1Text || "",
                                                      "attack1Damage": card.attack1Damage || "",
                                                      "attack1ConvertedEnergyCost": card.attack1ConvertedEnergyCost || 0,
                                                      "attack1Cost1": card.attack1Cost1 || "Cost 1",
                                                      "attack1Cost2": card.attack1Cost2 || "Cost 2",
                                                      "attack1Cost3": card.attack1Cost3 || "Cost 3",
                                                      "attack1Cost4": card.attack1Cost4 || "Cost 4",
                                                      "attack1Cost5": card.attack1Cost5 || "Cost 5",

                                                      // Attack 2
                                                      "attack2Name": card.attack2Name || "",
                                                      "attack2Text": card.attack2Text || "",
                                                      "attack2Damage": card.attack2Damage || "",
                                                      "attack2ConvertedEnergyCost": card.attack2ConvertedEnergyCost || 0,
                                                      "attack2Cost1": card.attack2Cost1 || "Cost 1",
                                                      "attack2Cost2": card.attack2Cost2 || "Cost 2",
                                                      "attack2Cost3": card.attack2Cost3 || "Cost 3",
                                                      "attack2Cost4": card.attack2Cost4 || "Cost 4",
                                                      "attack2Cost5": card.attack2Cost5 || "",

                                                      // Attack 3
                                                      "attack3Name": card.attack3Name || "",
                                                      "attack3Text": card.attack3Text || "",
                                                      "attack3Damage": card.attack3Damage || "",
                                                      "attack3ConvertedEnergyCost": card.attack3ConvertedEnergyCost || 0,
                                                      "attack3Cost1": card.attack3Cost1 || "Cost 1",
                                                      "attack3Cost2": card.attack3Cost2 || "Cost 2",
                                                      "attack3Cost3": card.attack3Cost3 || "Cost 3",
                                                      "attack3Cost4": card.attack3Cost4 || "Cost 4",
                                                      "attack3Cost5": card.attack3Cost5 || "",

                                                      // Attack 4
                                                      "attack4Name": card.attack4Name || "",
                                                      "attack4Text": card.attack4Text || "",
                                                      "attack4Damage": card.attack4Damage || "",
                                                      "attack4ConvertedEnergyCost": card.attack4ConvertedEnergyCost || 0,
                                                      "attack4Cost1": card.attack4Cost1 || "Cost 1",
                                                      "attack4Cost2": card.attack4Cost2 || "Cost 2",
                                                      "attack4Cost3": card.attack4Cost3 || "Cost 3",
                                                      "attack4Cost4": card.attack4Cost4 || "Cost 4",
                                                      "attack4Cost5": card.attack4Cost5 || "",

                                                      // Subtypes
                                                      "subtype1" : card.subtype1 || "",
                                                      "subtype2": card.subtype2 || "",
                                                      "subtype3": card.subtype3 || "",
                                                      "subtype4": card.subtype4 || ""
                                                  }))



                        selectedIndex = 0; // Start with the first card
                        updateAttackInfo();
                        updateAbilityInfo();
                        updateSubTypeInfo();
                        updateSuperTypeInfo();
                        updateTypeInfo();
                        resetLeftColumnScroll();
                        resetRightColumnScroll();
                        view.visible = true
                    }
                }
            }

            Connections {
                target: backendController
                function discoverResults(response) {
                    var data = JSON.parse(response)
                    if (data.error) {
                        cards = []
                    } else {
                        cards = data.map(card => ({
                                                      "name": card.name,
                                                      "imageUrl": card.imageUrl
                                                                  || ""
                                                  }))
                        selectedIndex = 0 // Start with the first card
                    }
                }
            }

            Item {
                id: discoverPage
                width: parent.width
                height: parent.height
                // Page content for browsePage
            }

            Item {
                id: collectionPage
                width: parent.width
                height: parent.height
                // Page content for collectionPage
            }
        }

        // Page 2: Browse Page

        // Page 3: Collection Page
    }
}

/*##^##
Designer {
    D{i:0}D{i:32;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
