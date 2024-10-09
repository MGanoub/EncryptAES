import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts

Item {

    implicitHeight: 100

    RowLayout {
        id: encryptionRow
        anchors.fill: parent
        spacing: 10

        Item {
            id: passwordId
            width: 250
            CustomTextField {
                id: saveFileName
                placeholderLabel: "Save file Name"
            }
        }
        Item {
            id: encryptId
            width: 150
            CustomButton {
                id: saveButton
                buttonText: "Save file"
                onClicked: {
                    saveFolderDialog.open()
                }
                enabled: saveFileName.enteredText !== ""
            }
        }
    }

    FolderDialog {
        id: saveFolderDialog
        title: "Please save file"
        visible: false
        onAccepted: {
            var saveFolderPath = saveFolderDialog.currentFolder.toString()
            // remove prefixed "file:///"
            saveFolderPath = saveFolderPath.replace(/^(file:\/{3})/, "")
            saveFolderPath = saveFolderPath + "/" + saveFileName.enteredText
            console.log("savePath" + saveFolderPath)
            myFileData.savePath = saveFolderPath
            saveFolderDialog.close()
            myApp.saveFile()
        }
        onRejected: {
            myFileData.savePath = ""
            saveFolderDialog.close()
        }
    }
}
