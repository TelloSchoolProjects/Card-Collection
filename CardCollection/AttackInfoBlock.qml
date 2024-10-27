// AttackInfoBlock.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt5Compat.GraphicalEffects


Rectangle {
    id: root
    property alias attackNameText: attackName.text
    property alias attackDropNameText: attackDropName.text

    // Exposed properties
    property color mainColor: "#c80d0d"
    property color bezelColor: "#b2b2b2"
    property color bezelBorderColor: "#616161"
    property color screenColor: "#02d20b"
    property color screenBorderColor: "#128c17"
    property color textColor: "#095f0c"
    property color dropTextColor: "#c5002a02"
    property color borderColor: "#6c0101"
    property color dropBorderColor: "#25fb2e"

    // Width and Height
    width: 200 // Default value, can be overridden
    height: 50 // Default value, can be overridden

    Rectangle {
        color: mainColor
        radius: 8
        border.color: borderColor
        border.width: 2
        anchors.fill: parent // Fill the parent rectangle

        Rectangle {
            color: bezelColor
            radius: 8
            border.color: bezelBorderColor
            border.width: 2
            anchors.fill: parent
            anchors.leftMargin: 4
            anchors.rightMargin: 4
            anchors.topMargin: 4
            anchors.bottomMargin: 4

            Rectangle {
                x: 10
                y: 4
                color: screenColor
                radius: 4
                border.color: screenBorderColor
                border.width: 2
                anchors.fill: parent
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.topMargin: 6
                anchors.bottomMargin: 6

                Text {
                    id: attackName
                    color: textColor
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    fontSizeMode: Text.HorizontalFit
                    font.styleName: "ExtraBold Italic"
                }

                Text {
                    id: attackDropName
                    color: dropTextColor
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
                    id: rectangle13
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
        id: attack1CostBlock
        width: 245
        height: 40
        color: mainColor
        radius: 6
        border.color: borderColor
        border.width: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Flow {
            id: attack1CostFlow
            anchors.fill: parent
            layoutDirection: Qt.LeftToRight
            spacing: 3
            flow: Flow.LeftToRight

            Rectangle {
                id: attack1Cost1Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2

                Rectangle {
                    id: attack1Cost1Bezel
                    visible: true
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
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
                        id: attack1Cost1Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenBorderColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 6
                        anchors.rightMargin: 6
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        Text {
                            id: attack1Cost1Text
                            color: "#c5002a02"
                            text: "Cost"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            state: "base state4"
                            z: 1
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: attack1Cost1DropShadow
                            opacity: 0.8
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: attack1Cost1Text
                            source: attack1Cost1Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: attack1Cost1DropText
                            visible: false
                            color: "#2a7b2d"
                            text: attack1Cost1Text.text
                            anchors.fill: parent
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

                        Rectangle {
                            id: attack1Cost1BlockHighlight
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
                id: attack1Cost2Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2
                Rectangle {
                    id: attack1Cost2Bezel
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
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
                        id: attack1Cost2Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenBorderColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 6
                        anchors.rightMargin: 6
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        Text {
                            id: attack1Cost2Text
                            color: "#c5002a02"
                            text: "Cost"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            z: 1
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: attack1Cost2DropShadow
                            opacity: 0.8
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: attack1Cost2Text
                            source: attack1Cost2Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: attack1Cost2DropText
                            visible: false
                            color: "#2a7b2d"
                            text: attack1Cost2Text.text
                            anchors.fill: parent
                            anchors.leftMargin: 4
                            anchors.rightMargin: 4
                            anchors.topMargin: 4
                            anchors.bottomMargin: 4
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

                        Rectangle {
                            id: attack1Cost2BlockHighlight
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
                id: attack1Cost3Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2
                Rectangle {
                    id: attack1Cost3Bezel
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
                    border.width: 2
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    anchors.bottomMargin: 4
                    Rectangle {
                        id: attack1Cost3Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenBorderColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 6
                        anchors.rightMargin: 6
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        Text {
                            id: attack1Cost3Text
                            color: "#c5002a02"
                            text: "Cost"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            z: 1
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: attack1Cost3DropShadow
                            opacity: 0.8
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: attack1Cost3Text
                            source: attack1Cost3Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: attack1Cost3DropText
                            visible: false
                            color: "#2a7b2d"
                            text: attack1Cost3Text.text
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
                            id: attack1Cost3BlockHighlight
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
                id: attack1Cost4Block
                width: 59
                height: 40
                visible: true
                color: mainColor
                radius: 6
                border.color: "#6c0101"
                border.width: 2

                Rectangle {
                    id: attack1Cost4Bezel
                    color: "#b2b2b2"
                    radius: 8
                    border.color: bezelBorderColor
                    border.width: 2
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    anchors.bottomMargin: 4
                    Rectangle {
                        id: attack1Cost4Screen
                        x: 7
                        y: 4
                        color: screenColor
                        radius: 4
                        border.color: screenBorderColor
                        border.width: 2
                        anchors.fill: parent
                        anchors.leftMargin: 6
                        anchors.rightMargin: 6
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        Text {
                            id: attack1Cost4Text
                            color: "#c5002a02"
                            text: "Cost"
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            z: 1
                            minimumPointSize: 4
                            minimumPixelSize: 4
                            fontSizeMode: Text.Fit
                            font.styleName: "Bold Italic"
                            font.pointSize: 30
                        }

                        DropShadow {
                            id: attack1Cost4DropShadow
                            opacity: 0.8
                            color: "#095f0c"
                            radius: 3.8
                            anchors.fill: attack1Cost4Text
                            source: attack1Cost4Text
                            verticalOffset: 3
                            samples: 16
                            horizontalOffset: 3
                        }

                        Text {
                            id: attack1Cost4DropText
                            visible: false
                            color: "#2a7b2d"
                            text: attack1Cost4Text.text
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
                            id: attack1Cost4BlockHighlight
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
        id: attack1DescriptionBlock
        width: 250
        height: 120
        color: mainColor
        radius: 8
        border.color: "#6c0101"
        border.width: 2

        Rectangle {
            id: attack1TextBezel
            color: "#b2b2b2"
            radius: 8
            border.color: bezelBorderColor
            border.width: 2
            anchors.fill: parent
            anchors.leftMargin: 4
            anchors.rightMargin: 4
            anchors.topMargin: 4
            anchors.bottomMargin: 4

            Rectangle {
                id: attack1Screen
                x: 10
                y: 4
                color: screenColor
                radius: 6
                border.color: screenBorderColor
                border.width: 2
                anchors.fill: parent
                anchors.leftMargin: 6
                anchors.rightMargin: 6
                anchors.topMargin: 6
                anchors.bottomMargin: 6

                Text {
                    id: attack1DescriptionDropText
                    visible: true
                    color: "#c5002a02"
                    text: "Attack 1 Description"
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    anchors.bottomMargin: 4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    font.pointSize: attack1DescriptionText.font.pointSize
                    minimumPointSize: 6
                    minimumPixelSize: 6
                    z: 1
                    fontSizeMode: Text.Fit
                    font.styleName: "ExtraBold Italic"
                }

                Text {
                    id: attack1DescriptionText
                    color: "#095f0c"
                    text: attack1DescriptionDropText.text
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.topMargin: 4
                    anchors.bottomMargin: 4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                    font.pointSize: attack1DescriptionDropText.font.pointSize
                    minimumPointSize: 6
                    minimumPixelSize: 6
                    z: 0
                    fontSizeMode: Text.Fit
                    font.styleName: "ExtraBold Italic"
                }

                Rectangle {
                    id: rectangle24
                    x: -7
                    y: 167
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
