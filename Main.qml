import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Window {
    width: 640
    height: 380
    visible: true
    title: qsTr("EncryptAES")

    FileSection
    {
        id: fileSectionId
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
    }

    Rectangle
    {
        id: dividerLine
        width: parent.width
        height: 2
        color: "grey"
        anchors.top: fileSectionId.bottom
        anchors.topMargin: 10
    }

    EncryptSection
    {
        id: encryptSectionId
        width: parent.width
        anchors.top: dividerLine.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
    }

    SaveSection
    {
        id: saveSectionId
        width: parent.width
        anchors.top: encryptSectionId.bottom
        anchors.left: parent.left
        anchors.topMargin: 50
        anchors.leftMargin: 10
    }

    /*
    RowLayout {
        id: encryptionRow
        anchors.top: fileDetailsComponent.bottom
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
        id: customText
        width: 250
        anchors.top: encryptionRow.bottom
        anchors.left: encryptionRow.left
    }
    CustomButton
    {
        id: customButton
        //width: 250
        anchors.top: customText.bottom
        anchors.left: encryptionRow.left
        anchors.topMargin: 150
        anchors.leftMargin: 50
        isEnabled: true
        iconOnRight: true
        iconSource: "qrc:/Assets/folder.png"
    }
    */
}
