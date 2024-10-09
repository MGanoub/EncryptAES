import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property string placeholderLabel: "Label"
    property bool isPasswordField: false
    id: customTextField
    implicitWidth: parent.width
    TextField {
        property string hintText: "Label"
        id: field
        width: parent.implicitWidth
        height: 54
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 16
            rightMargin: 16
            topMargin: 24
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
            text: field.hintText
            color: "gray"
        }
        Rectangle {
            id: floatingPlaceholderBg
            anchors.fill: floatingPlaceholder
            color: "white"
            visible: false
        }

        Text {
            text: field.hintText
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

    PageIndicator
    {
        id: passwordIndicator
        width: parent.width
        count: 3
        spacing: 8
        currentIndex: 0
        anchors.top: field.bottom
        anchors.left: field.left
        anchors.topMargin: 8
        delegate: Rectangle{
          implicitHeight: 2
          implicitWidth: field.width / passwordIndicator.count
          color: 'blue'
          }
    }
}
