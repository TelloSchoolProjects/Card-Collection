// AttackInfoBlock.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt5Compat.GraphicalEffects


Rectangle {
    id: root
    property alias nameText: nameText.text

    property alias cost1Text: cost1Text.text
    property alias cost2Text: cost2Text.text
    property alias cost3Text: cost3Text.text
    property alias cost4Text: cost4Text.text

    property alias descText: descriptionText.text


    // Exposed properties
    property color blockBG: "#ff0000"
    property color blockBorderColor:"#00ff0000"
    property color mainColor: "#c80d0d"
    property color bezelColor: "#b2b2b2"
    property color bezelBorderColor: "#616161"
    property color screenColor: "#02d20b"
    property color screenShadeColor: "#128c17"
    property color screenHighlightColor: "#25fb2e"
    property color textColor: "#095f0c"
    property color dropTextColor: "#c5002a02"
    property color borderColor: "#6c0101"
    property color dropBorderColor: "#25fb2e"

    // Width and Height
    width: 250 // Default value, can be overridden
    height: 200
    color: blockBG
    radius: 4
    border.color: blockBorderColor
    border.width: 0 // Default value, can be overridden

    Rectangle {
        id: attackNameBlock
        height: 40
        color: mainColor
        radius: 8
        border.color: borderColor
        border.width: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        // Fill the parent rectangle

        Rectangle {
            id: attackNameBezel
            color: bezelColor
            radius: 8
            border.color: bezelBorderColor
            border.width: 2
            anchors.fill: parent
            anchors.leftMargin: 2
            anchors.rightMargin: 2
            anchors.topMargin: 2
            anchors.bottomMargin: 2

            Rectangle {
                id: attackNameScreen
                color: screenColor
                radius: 4
                border.color: screenShadeColor
                border.width: 2
                anchors.fill: parent
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                anchors.topMargin: 4
                anchors.bottomMargin: 4

                Text {
                    id: nameText
                    color: textColor
                    text: "Attack Name"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    fontSizeMode: Text.HorizontalFit
                    font.styleName: "ExtraBold Italic"

                    onTextChanged: {
                        nameDropText.text = nameText.text
                    }
                }

                Text {
                    id: nameDropText
                    color: dropTextColor
                    text: nameText.text
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    font.pointSize: nameText.font.pointSize
                    minimumPointSize: 10
                    minimumPixelSize: 10
                    fontSizeMode: Text.HorizontalFit
                    font.styleName: "ExtraBold Italic"

                }

                Rectangle {
                    id: screenHighlight
                    color: "#00ffffff"
                    radius: 4
                    border.color: dropBorderColor
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
        id: costBlock
        height: 40
        color: "#00c80d0d"
        radius: 6
        border.color: "#006c0101"
        border.width: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: attackNameBlock.bottom
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2

        Flow {
            id: costFlow
            anchors.fill: parent
            layoutDirection: Qt.LeftToRight
            spacing: 3
            flow: Flow.LeftToRight

            Rectangle {
                id: cost1Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2

                Rectangle {
                    id: cost1Bezel
                    visible: true
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
                    border.width: 2
                    anchors.fill: parent
                    anchors.leftMargin: 2
                    anchors.rightMargin: 2
                    anchors.topMargin: 2
                    anchors.bottomMargin: 2
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 60
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        id: cost1Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenShadeColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4
                        anchors.topMargin: 4
                        anchors.bottomMargin: 4
                        Text {
                            id: cost1Text
                            color: textColor
                            text: "Cost 1"
                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            state: "base state4"
                            z: 0
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: cost1DropShadow
                            opacity: 0.8
                            visible: false
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: cost1Text
                            source: cost1Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: cost1DropText
                            visible: true
                            color: dropTextColor
                            text: cost1Text.text
                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.pointSize: cost1Text.font.pointSize
                            z: 0
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                        }

                        Rectangle {
                            id: cost1BlockHightlight
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
                id: cost2Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2
                Rectangle {
                    id: cost2Bezel
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
                    border.width: 2
                    anchors.fill: parent
                    anchors.leftMargin: 2
                    anchors.rightMargin: 2
                    anchors.topMargin: 2
                    anchors.bottomMargin: 2
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Rectangle {
                        id: cost2Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenShadeColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4
                        anchors.topMargin: 4
                        anchors.bottomMargin: 4
                        Text {
                            id: cost2Text
                            color: textColor
                            text: "Cost 2"
                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            z: 0
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: cost2DropShadow
                            opacity: 0.8
                            visible: false
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: cost2Text
                            source: cost2Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: cost2DropText
                            visible: true
                            color: dropTextColor
                            text: cost2Text.text
                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.pointSize: cost2Text.font.pointSize
                            z: 0
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                        }

                        Rectangle {
                            id: cost2BlockHightlight
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
                id: cost3Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2
                Rectangle {
                    id: cost3Bezel
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
                    border.width: 2
                    anchors.fill: parent
                    anchors.leftMargin: 2
                    anchors.rightMargin: 2
                    anchors.topMargin: 2
                    anchors.bottomMargin: 2
                    Rectangle {
                        id: cost3Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenShadeColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4
                        anchors.topMargin: 4
                        anchors.bottomMargin: 4
                        Text {
                            id: cost3Text
                            color: textColor
                            text: "Cost 3"
                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            z: 0
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: cost3DropShadow
                            opacity: 0.8
                            visible: false
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: cost3Text
                            source: cost3Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: cost3DropText
                            visible: true
                            color: dropTextColor
                            text: cost3Text.text

                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.pointSize: cost3Text.font.pointSize
                            z: 0
                            minimumPointSize: 6
                            minimumPixelSize: 6
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                        }

                        Rectangle {
                            id: cost3BlockHightlight
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
                id: cost4Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2

                Rectangle {
                    id: cost4Bezel
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
                    border.width: 2
                    anchors.fill: parent
                    anchors.leftMargin: 2
                    anchors.rightMargin: 2
                    anchors.topMargin: 2
                    anchors.bottomMargin: 2
                    Rectangle {
                        id: cost4Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenShadeColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4
                        anchors.topMargin: 4
                        anchors.bottomMargin: 4
                        Text {
                            id: cost4Text
                            color: textColor
                            text: "Cost 4"
                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            z: 0
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: cost4DropShadow
                            opacity: 0.8
                            visible: false
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: cost4Text
                            source: cost4Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: cost4DropText
                            visible: true
                            color: dropTextColor
                            text: cost4Text.text
                            anchors.fill: parent
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.pointSize: cost4Text.font.pointSize
                            z: 0
                            minimumPointSize: 6
                            minimumPixelSize: 6
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                        }

                        Rectangle {
                            id: cost4BlockHighlight
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
        id: descriptionBlock
        x: 0
        color: mainColor
        radius: 8
        border.color: borderColor
        border.width: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: costBlock.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2

        Rectangle {
            id: descriptionTextBezel
            color: bezelColor
            radius: 8
            border.color: bezelBorderColor
            border.width: 2
            anchors.fill: parent
            anchors.leftMargin: 2
            anchors.rightMargin: 2
            anchors.topMargin: 2
            anchors.bottomMargin: 2

            Rectangle {
                id: textScreen
                color: screenColor
                radius: 6
                border.color: screenHighlightColor
                border.width: 2
                anchors.fill: parent
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                anchors.topMargin: 4
                anchors.bottomMargin: 4

                Text {
                    id: descriptionDropText
                    visible: true
                    color: dropTextColor
                    text: descriptionText.text
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    anchors.bottomMargin: 4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    font.pointSize: descriptionText.font.pointSize
                    minimumPointSize: 6
                    minimumPixelSize: 6
                    z: 1
                    fontSizeMode: Text.Fit
                    font.styleName: "ExtraBold Italic"
                }

                Text {
                    id: descriptionText
                    visible: true
                    color: textColor
                    text: "Attack Description"
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    anchors.bottomMargin: 4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    font.pointSize: 15
                    minimumPointSize: 6
                    minimumPixelSize: 6
                    z: 0
                    fontSizeMode: Text.Fit
                    font.styleName: "ExtraBold Italic"
                }

                Rectangle {
                    id: descriptionScreenShadeBorder
                    color: "#00ffffff"
                    radius: 4
                    border.color: screenShadeColor
                    border.width: 1
                    anchors.fill: parent
                }
            }
        }
    }

    Item {
        id: __materialLibrary__
    }


}
