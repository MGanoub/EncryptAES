import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        visible: false
        //currentFolder: shortcuts.desktop
        onAccepted: {
            // console.log("User has selected " + dialogFile.folder);
            var path = fileDialog.currentFile.toString()
            // remove prefixed "file:///"
            path = path.replace(/^(file:\/{3})/, "")
            console.log("path" + path)
            myFileData.path = path
            filePathLabel.text = path
            filesize.sizeText = myFileData.fileSize
            fileExtension.text = myFileData.fileExtension
            fileDialog.close()
        }
        onRejected: {
            myFileData.path = ""
            filePathLabel.text = ""
            fileDialog.close()
        }
    }

    Button {
        id: selectFileButton
        text: "Select a file"
        onClicked: fileDialog.open()
    }

    GroupBox {
        id: fileInfo
        width: parent.width - 40
        padding: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: selectFileButton.bottom

        title: "File info"
        ColumnLayout {
            anchors {
                topMargin: 10
            }
            spacing: 2
            Label {
                id: filePathLabel
                text: ""
            }
            Label {
                id: filesize
                property string sizeText: ""
                text: sizeText + " bytes"
            }

            Label {
                id: fileExtension
                text: ""
            }
        }
    } // groupbox

    RowLayout {
        id: encryptionRow
        anchors.top: fileInfo.bottom
        anchors.topMargin: 20
        spacing: 10
        TextField
        {
            id: password
            placeholderText: "Enter Password"
        }
        Button {
            id: encryptButton
            text: "Encrypt file"
            onClicked:
            {
                myApp.cipherPassword = password.text
                myApp.encrypt()
            }
        }

        Button {
            id: decryptButton
            text: "Decrypt file"
            onClicked:
            {
                myApp.cipherPassword = password.text
                myApp.decrypt()
            }
        }
        TextField
        {
            id: saveFileName
            placeholderText: "fileName"
        }

        Button {
            id: saveButton
            text: "save file"
            onClicked: saveFolderDialog.open()
            enabled: saveFileName.text !== ""

        }
    }

    FolderDialog {
        id: saveFolderDialog
        title: "Please save file"
        visible: false
        //currentFolder: shortcuts.desktop

        onAccepted: {
            var saveFolderPath = saveFolderDialog.currentFolder.toString()
            // remove prefixed "file:///"
            saveFolderPath = saveFolderPath.replace(/^(file:\/{3})/, "")
            saveFolderPath = saveFolderPath + "/" + saveFileName.text
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
    CustomTextField
    {
        id: custom
        width: 250
        anchors.top: encryptionRow.bottom
        anchors.left: encryptionRow.left
    }
}
