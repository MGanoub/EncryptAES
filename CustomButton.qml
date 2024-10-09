import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: rootItem
    property string iconSource: ""
    property bool iconOnRight: false
    property string buttonText: ""
    signal clicked
    implicitWidth: parent.width - anchors.leftMargin - anchors.rightMargin
    property alias isEnabled: root.enabled
    Button {
        id: root
        property color backgroundDefaultColor: "#4287f5"
        property color backgroundPressedColor: Qt.darker(
                                                   backgroundDefaultColor, 1.2)
        property color contentItemTextColor: "white"
        hoverEnabled: false
        implicitWidth: rootItem.width
        topPadding: 20
        bottomPadding: 20
        leftPadding: 16
        rightPadding: 16
        enabled: true

        text: buttonText
        contentItem:
            Item {

            Image {
                visible: iconSource !== null && !iconOnRight
                id: iconLeft
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                fillMode: Image.PreserveAspectFit
                sourceSize.height: 18
                sourceSize.width: 18
                source: iconSource
                anchors.right: contextText.left
                anchors.rightMargin: 8
                anchors.bottom: contextText.bottom
                anchors.top: contextText.top

            }

            Text {
                id: contextText
                text: root.text
                color: root.contentItemTextColor
                font.pixelSize: 18
                font.weight: Font.Medium
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            Image {
                visible: iconSource !== null && iconOnRight
                id: iconRight
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                fillMode: Image.PreserveAspectFit
                sourceSize.height: 18
                sourceSize.width: 18
                source: iconSource
                anchors.left: contextText.right
                anchors.leftMargin: 8
                anchors.bottom: contextText.bottom
                anchors.top: contextText.top
            }
        }

        background: Rectangle {
            id: bgRect
            implicitWidth: root.width
            color: root.down ? root.backgroundPressedColor : root.backgroundDefaultColor
            radius: 16
        }

        onClicked: rootItem.clicked()

        onHighlightedChanged: {
            if (highlighted) {
                state = "highlighted"
            } else {
                state = "default"
            }
        }
        onEnabledChanged: {
            if (!enabled) {
                state = "disabled"
            } else {
                state = "default"
            }
        }

        // onClicked: enabled = !enabled
        states: [
            State {
                name: "default"
                PropertyChanges {
                    target: bgRect
                    color: root.backgroundDefaultColor
                }
                PropertyChanges {
                    target: contextText
                    color: root.contentItemTextColor
                }
                PropertyChanges {
                    target: bgRect
                    border.width: 0
                }
            },
            State {
                name: "disabled"
                PropertyChanges {
                    target: bgRect
                    color: "grey"
                }
                PropertyChanges {
                    target: contextText
                    color: "darkgrey"
                }
            },
            State {
                name: "highlighted"
                PropertyChanges {
                    target: bgRect
                    border.width: 1
                }
                PropertyChanges {
                    target: bgRect
                    border.color: "red"
                }
            }
        ]
    }
}
