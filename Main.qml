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

    FileSection {
        id: fileSectionId
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
    }

    Rectangle {
        id: dividerLine
        width: parent.width
        height: 2
        color: "grey"
        anchors.top: fileSectionId.bottom
        anchors.topMargin: 10
    }

    EncryptSection {
        id: encryptSectionId
        width: parent.width
        anchors.top: dividerLine.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
    }

    SaveSection {
        id: saveSectionId
        width: parent.width
        anchors.top: encryptSectionId.bottom
        anchors.left: parent.left
        anchors.topMargin: 50
        anchors.leftMargin: 10
    }
}
