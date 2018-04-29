import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

ApplicationWindow {
    id: mainWindow

    property bool initialized: false
    property int sizeIndex: 0   // small
    property int themeIndex: 1  // cars

    visible: true
    width: 640
    height: 480
    minimumHeight: 180
    minimumWidth: 150
    title: "MemoryGame"

    onAfterSynchronizing: {
        if (!initialized) {
            initialized = true;
            gameBoard.state = "running";
        }
    }

    MessageDialog {
        title: "Winner!"
        text: "Time: " + gameBoard.elapsed + " seconds"
        visible: gameBoard.state === "finished"
        onAccepted: close()
        onVisibleChanged: visible ? undefined : close()
    }

    Image {
        fillMode: Image.Tile
        anchors.fill: parent
        source: "qrc:/generic/background.png"
    }

    SettingsWindow {
        id: settingsWindow
        themeModel: settings.themeModel
        sizeModel: settings.sizeModel
        onSettingsChanged: {
            mainWindow.sizeIndex = newSizeIndex;
            mainWindow.themeIndex = newThemeIndex;
        }
    }

    Settings {
        id: settings
    }

    header: ToolBar {
        id: toolBar
        RowLayout {
            width: mainWindow.width

            ToolButton {
                id: newGameButton
                text: "New game"
                anchors.leftMargin: 0
                onClicked: {
                    gameBoard.state = "ready";
                    gameBoard.state = "running";
                }
            }

            ToolButton {
                text: "Settings"
                anchors.left: newGameButton.right
                onClicked: {
                    // trigger changes
                    settingsWindow.themeIndex = -1;
                    settingsWindow.sizeIndex = -1;
                    settingsWindow.themeIndex = themeIndex;
                    settingsWindow.sizeIndex = sizeIndex;
                    settingsWindow.show()
                }
            }

            Label {
                text: gameBoard.elapsed + "s"
                anchors.right: parent.right
                anchors.rightMargin: 5
                visible: gameBoard.state === "running"
            }
        }
    }

    GameBoard {
        id: gameBoard
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0
        path: settings.getThemePath(themeIndex)
        boardWidth: settings.getWidth(sizeIndex)
        boardHeight: settings.getHeight(sizeIndex)
    }
}
