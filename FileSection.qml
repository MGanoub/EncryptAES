import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

Item {
    id: rootFileDetailsItem
    implicitHeight: 100
    GroupBox {
        id: fileInfoGroup
        width: parent.width * 0.7
        padding: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        title: "File Details"
        ColumnLayout {
            anchors {
                topMargin: 10
            }
            spacing: 2
            Row {
                Label {
                    id: filePathText
                    text: "File Path: "
                }
                Label {
                    id: filePathLabel
                    text: ""
                }
            }
            Row {
                id: fileSizeRow
                property string sizeText: "0"
                Label {
                    id: fileSizeText
                    text: "File Size: "
                }
                Label {
                    id: fileSize
                    text: fileSizeRow.sizeText + " bytes"
                }
            }
            Row {
                Label {
                    id: fileExtText
                    text: "File Extension: "
                }
                Label {
                    id: fileExtension
                    text: ""
                }
            }
        }
    } // groupbox

    CustomButton {
        id: selectFileButton
        width: parent.width * 0.25
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.topMargin: 35
        anchors.top: parent.top
        isEnabled: true
        iconOnRight: true
        buttonText: "Open File"
        iconSource: "qrc:/Assets/folder.png"
        onClicked: fileDialog.open()
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        visible: false
        onAccepted: {
            var path = fileDialog.currentFile.toString()
            // remove prefixed "file:///"
            path = path.replace(/^(file:\/{3})/, "")
            console.log("path" + path)
            myFileData.path = path
            filePathLabel.text = path
            fileSizeRow.sizeText = myFileData.fileSize
            fileExtension.text = myFileData.fileExtension
            fileDialog.close()
        }
        onRejected: {
            myFileData.path = ""
            filePathLabel.text = ""
            fileDialog.close()
        }
    }

}
