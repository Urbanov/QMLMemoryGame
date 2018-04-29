import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    property int sizeIndex
    property int themeIndex
    property ListModel sizeModel
    property ListModel themeModel

    id: window
    modality: Qt.ApplicationModal
    width: 400
    height: 290
    minimumWidth: 300
    minimumHeight: 260
    title: "MemoryGame"

    signal settingsChanged(int newSizeIndex, int newThemeIndex)

    footer: DialogButtonBox {
        id: dialogButtonBox
        x: 170
        y: 175
        width: 230
        height: 55
        z: 1
        clip: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        Layout.fillWidth: false
        transformOrigin: Item.Center
        anchors.right: parent.right
        anchors.rightMargin: 0
        visible: true
        Button {
            text: qsTr("OK")
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        Button {
            text: qsTr("Cancel")
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }

        onAccepted: {
            settingsChanged(boardSizeComboBox.currentIndex, themeComboBox.currentIndex);
            close();
        }
        onRejected: close()
    }

    GridLayout {
        id: gridLayout
        height: 93
        columnSpacing: 20
        rowSpacing: 5
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 110
        rows: 2
        columns: 2
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top

        Text {
            id: boardSizeLabel
            text: qsTr("Board Size")
            font.pixelSize: 12
        }

        ComboBox {
            id: boardSizeComboBox
            model: sizeModel
            textRole: "name"
            Layout.fillWidth: true
            currentIndex: sizeIndex
        }

        Text {
            id: themeLabel
            text: qsTr("Theme")
            font.pixelSize: 12
        }

        ComboBox {
            id: themeComboBox
            model: themeModel
            textRole: "name"
            currentIndex: themeIndex
            Layout.fillWidth: true
        }
    }

    Image {
        id: imageLabel
        x: 10
        y: 10
        width: 80
        height: 80
        source: "qrc:/generic/settings.png"
    }

    Text {
        id: titleLabel
        x: 100
        y: 20
        color: "#505050"
        text: qsTr("Settings")
        font.family: "Tahoma"
        font.pixelSize: 50
    }

}
