import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: encryptionRootItem
    implicitHeight: 60
    RowLayout {
        id: encryptionRow
        anchors.top: parent.top
        spacing: 10
        Item {
            id: passwordId
            width: 250
        CustomTextField
        {
            id: password
            placeholderLabel: "Enter Password"
        }
        }
        Item {
            id: encryptId
            width: 150
        CustomButton {
            id: encryptButton
            buttonText: "Encrypt file"
            onClicked:
            {
                myApp.cipherPassword = password.enteredText
                myApp.encrypt()
            }
        }
        }
        Item {
            id: decryptId
            width: 150
            CustomButton {
                id: decryptButton
                isEnabled: true
                buttonText: "Decrypt file"
                onClicked:
                {
                    myApp.cipherPassword = password.enteredText
                    myApp.decrypt()
                }
            }
        }

    }
    Text
    {
        id: progressLabel
        anchors.top: encryptionRootItem.bottom
        anchors.topMargin: 20
        anchors.left: encryptionRootItem.left
        anchors.leftMargin: 15
        visible: myApp.isProcessed
        text: "Done file processing..."
        font.bold: true
        font.pixelSize: 16
    }
}
