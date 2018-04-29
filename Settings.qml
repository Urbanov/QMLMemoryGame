import QtQuick 2.0

Item {
    id: settings

    property ListModel themeModel: themes
    property ListModel sizeModel: sizes

    ListModel {
        id: themes

        ListElement {
            name: "Animals"
            source: "qrc:/animals"
        }

        ListElement {
            name: "Cars"
            source: "qrc:/cars"
        }

        ListElement {
            name: "Fruits"
            source: "qrc:/fruits"
        }
    }

    ListModel {
        id: sizes

        ListElement {
            name: "Small"
            width: 3
            height: 4
        }

        ListElement {
            name: "Medium"
            width: 4
            height: 5
        }

        ListElement {
            name: "Big"
            width: 5
            height: 6
        }
    }

    function getThemePath(index) {
        return themes.get(index).source;
    }

    function getWidth(index) {
        return sizes.get(index).width;
    }

    function getHeight(index) {
        return sizes.get(index).height;
    }
}
