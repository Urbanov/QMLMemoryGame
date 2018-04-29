import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: cardContainer

    property int size: 200

    property int flipDuration: 400
    property int cooldown: 400

    property url frontImage
    property url backImage: "qrc:/generic/card_back.png"

    property int pairID

    signal selected
    signal animationFinished

    width: size
    height: size
    radius: 0.1 * size
    color: "#000000"
    state: "inactive"

    transform: Rotation {
        origin.x: 0.5 * size
        id: rotation
        axis {
            x: 0
            y: 1
            z: 0
        }
        angle: 0
    }

    Image {
        id: image
        anchors {
            fill: parent
            margins: 3
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: backImage
        antialiasing: true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: image.width
                height: image.height
                radius: 0.08 * size
            }
        }
    }

    MouseArea {
        id: clickableArea
        anchors.fill: parent
        onClicked: selected()
    }

    states: [
        State {
            name: "inactive"
            PropertyChanges {
                target: rotation
                angle: 0
            }
        },

        State {
            name: "active"
            PropertyChanges {
                target: clickableArea
                enabled: false
            }
            PropertyChanges {
                target: rotation
                angle: 180
            }
            PropertyChanges {
                target: image
                source: frontImage
            }
        },

        State {
            name: "removed"
            extend: "active"
            PropertyChanges {
                target: cardContainer
                opacity: 0.0
            }
        }
    ]

    transitions: [
        Transition {
            from: "inactive"
            to: "active"
            onRunningChanged: running ? undefined : animationFinished()
            ParallelAnimation {
                NumberAnimation {
                    property: "angle"
                    duration: flipDuration
                    easing.type: Easing.OutQuad
                }
                PropertyAnimation {
                    property: "source"
                    duration: 0.3 * flipDuration
                }
            }
        },
        Transition {
            from: "active"
            to: "inactive"
            onRunningChanged: running ? undefined : animationFinished()
            ParallelAnimation {
                NumberAnimation {
                    property: "angle"
                    duration: flipDuration + cooldown
                    easing.type: Easing.InQuint
                }
                PropertyAnimation {
                    property: "source"
                    duration: 0.87 * (flipDuration + cooldown)
                }
            }
        },
        Transition {
            from: "active"
            to: "removed"
            onRunningChanged: running ? undefined : animationFinished()
            NumberAnimation {
                property: "opacity"
                duration: flipDuration + cooldown
                easing.type: Easing.InCubic
            }
        }
    ]
}
