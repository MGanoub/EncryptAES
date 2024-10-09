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
        property bool isPasswordShown: false
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

        echoMode: field.isPasswordShown ? TextInput.Normal : TextInput.Password

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
            source: field.isPasswordShown? "qrc:/Assets/show.png" :"qrc:/Assets/hide.png"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 18
            sourceSize.width: 18
            visible: rootItem.isPasswordField
            anchors.right: field.right
            anchors.rightMargin: 20
            anchors.bottom: field.bottom
            anchors.top: field.top
            MouseArea
            {
                id: showPasswordArea
                anchors.fill: parent
                onClicked:
                {
                    field.isPasswordShown = !field.isPasswordShown
                    state = "highlighted"
                }
            }
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

    Item
    {
        id: fieldStatesId
        states: [
            State {
                name: "default"
            },
            State {
                name: "Error"
                when: rootItem.enteredText.length > 0 && rootItem.enteredText.length < 3 && isPasswordField
                PropertyChanges {
                    target: fieldRectBg
                    border.color: "red"
                }
                PropertyChanges {
                    target: passwordIndicator
                    coloredIndicatorCount: 0
                }
                PropertyChanges {
                    target: passwordIndicator
                    indicatorColor: "red"
                }
                PropertyChanges {
                    target: floatingPlaceholder
                    color: "red"
                }
            },
            State {
                name: "Warning"
                when: rootItem.enteredText.length > 0 && rootItem.enteredText.length < 5 && isPasswordField
                PropertyChanges {
                    target: fieldRectBg
                    border.color: "orange"
                }
                PropertyChanges {
                    target: passwordIndicator
                    coloredIndicatorCount: 1
                }
                PropertyChanges {
                    target: passwordIndicator
                    indicatorColor: "orange"
                }
                PropertyChanges {
                    target: floatingPlaceholder
                    color: "orange"
                }
            },
            State {
                name: "success"
                when: rootItem.enteredText.length >= 5 && isPasswordField
                PropertyChanges {
                    target: fieldRectBg
                    border.color: "green"
                }
                PropertyChanges {
                    target: passwordIndicator
                    coloredIndicatorCount: 2
                }
                PropertyChanges {
                    target: passwordIndicator
                    indicatorColor: "green"
                }
                PropertyChanges {
                    target: floatingPlaceholder
                    color: "green"
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
        property int coloredIndicatorCount: 1
        Row {
            spacing: 8
            Repeater {
                id: myRepeaterId
                model: passwordIndicator.indicatorsCount
                    Rectangle {
                        id: indicator
                        width: (passwordIndicator.width - (8*2))/ passwordIndicator.indicatorsCount
                        height: 2
                        color: index <= passwordIndicator.coloredIndicatorCount? passwordIndicator.indicatorColor: "grey"
                    }
            }
    }
    }

        Item {
            id: hintSection
            anchors.top: rootItem.isPasswordField ? passwordIndicator.bottom: field.bottom
            anchors.left: field.left
            anchors.topMargin: 8
            Row
            {
                id: hintRowId
                spacing: 2
                anchors.left: hintSection.left
                Image {
                    id: hintIconId
                    source: "qrc:/Assets/check.png"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: 18
                    sourceSize.width: 18
                    visible: true
            }
                Text {
                    id: hintTextId
                    text: qsTr("Hint text......")
                    color: "grey"
                }
        }
        }
}
