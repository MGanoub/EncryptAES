import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: rootItem
    property string placeholderLabel: "Label"
    property bool isPasswordField: false
    property alias enteredText: field.text
    implicitWidth: parent.width
    TextField {
        id: field
        width: parent.implicitWidth
        height: 54
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 16
            rightMargin: 16
        }
        leftPadding: 20
        rightPadding: 20
        topPadding: 17
        bottomPadding: 17

        background: Rectangle {
            id: fieldRectBg
            radius: 8
            border.color: "darkgray"
            border.width: 0.5
        }

        Text {
            id: placeholdersection
            anchors.left: parent.left
            anchors.top: parent.top
            leftPadding: 20
            rightPadding: 20
            topPadding: 17
            bottomPadding: 17
            text: rootItem.placeholderLabel
            color: "gray"
        }
        Rectangle {
            id: floatingPlaceholderBg
            anchors.fill: floatingPlaceholder
            color: "white"
            visible: false
        }

        Text {
            text: rootItem.placeholderLabel
            id: floatingPlaceholder
            anchors.top: placeholdersection.top
            anchors.left: placeholdersection.left
            anchors.topMargin: 17
            anchors.leftMargin: 20
            anchors.rightMargin: 8
            color: "grey"
            transformOrigin: Item.Center
            visible: false
        }

        Image {
            id: showPasswordId
            source: "qrc:/Assets/hide.png"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 18
            sourceSize.width: 18
            visible: rootItem.isPasswordField
            anchors.right: field.right
            anchors.rightMargin: 20
            anchors.bottom: field.bottom
            anchors.top: field.top
        }



        Item
        {
            id: floatingPlaceHolderTransitions
            states: [
                State {
                    name: "shown"
                    when: field.activeFocus || field.text.length !== 0
                    PropertyChanges {
                        target: floatingPlaceholder
                        scale: 0.8
                    }

                    PropertyChanges {
                        target: floatingPlaceholder
                        anchors.topMargin: -9
                    }

                    PropertyChanges {
                        target: floatingPlaceholder
                        anchors.leftMargin: 8
                    }
                    PropertyChanges {
                        target: floatingPlaceholderBg
                        visible: true
                    }
                    PropertyChanges {
                        target: fieldRectBg
                        border.color: "grey"
                    }
                }
            ]

            transitions: [
                Transition {
                    to: "shown"
                    SequentialAnimation {
                        PropertyAction {
                            target: floatingPlaceholder
                            property: "visible"
                            value: true
                        }
                        PropertyAction {
                            target: placeholdersection
                            property: "visible"
                            value: false
                        }
                        PropertyAction {
                            target: floatingPlaceholderBg
                            property: "visible"
                            value: true
                        }
                        ParallelAnimation {
                            NumberAnimation {
                                target: floatingPlaceholder
                                property: "scale"
                                duration: 100
                                easing.type: Easing.InCubic
                            }
                            NumberAnimation {
                                target: floatingPlaceholder
                                property: "anchors.topMargin"
                                duration: 100
                                easing.type: Easing.InCubic
                            }
                            NumberAnimation {
                                target: floatingPlaceholder
                                property: "anchors.leftMargin"
                                duration: 100
                                easing.type: Easing.InCubic
                            }
                        }
                    }
                },
                Transition {
                    from: "shown"
                    SequentialAnimation {
                        ParallelAnimation {
                            NumberAnimation {
                                target: floatingPlaceholder
                                property: "scale"
                                duration: 100
                                easing.type: Easing.InCubic
                            }
                            NumberAnimation {
                                target: floatingPlaceholder
                                property: "anchors.topMargin"
                                duration: 100
                                easing.type: Easing.InCubic
                            }
                            NumberAnimation {
                                target: floatingPlaceholder
                                property: "anchors.leftMargin"
                                duration: 100
                                easing.type: Easing.InCubic
                            }
                        }
                        PropertyAction {
                            target: floatingPlaceholderBg
                            property: "visible"
                            value: false
                        }
                        PropertyAction {
                            target: floatingPlaceholder
                            property: "visible"
                            value: false
                        }
                        PropertyAction {
                            target: placeholdersection
                            property: "visible"
                            value: true
                        }
                    }
                }
            ]
        }
    }
    Item
    {
        id: passwordIndicator
        width: field.width
        anchors.top: field.bottom
        anchors.left: field.left
        anchors.right: field.right
        anchors.topMargin: 8
        visible: rootItem.isPasswordField
        property int indicatorsCount: 3
        property color indicatorColor: "grey"
        Row {
            spacing: 8
            Repeater {
                model: passwordIndicator.indicatorsCount
                    Rectangle {
                        id: indicator
                        width: (passwordIndicator.width - (8*2))/ passwordIndicator.indicatorsCount
                        height: 2
                        color: passwordIndicator.indicatorColor
                    }
            }
    }

}
}
