
import QtQuick 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.1
import QtQuick.Extras 1.4

Rectangle {

    id: view

    width: 400
    height: 300

    property bool triggered: false;

    color: customizerItem.currentStyleDark ? "#111" : "#555"

    Behavior on color {
        ColorAnimation {}
    }

    Text {
        id: textSingleton
    }
  
    property bool darkBackground: true

    property Component customizer: Item {
        property alias currentStylePath: stylePicker.currentStylePath
        property alias currentStyleDark: stylePicker.currentStyleDark

        StylePicker {
            id: stylePicker
            currentIndex: 0
            width: Math.round(Math.max(textSingleton.implicitHeight * 6 * 2, parent.width * 0.5))
            anchors.centerIn: parent

            model: ListModel {
                ListElement {
                    name: "Default"
                    path: "PieMenuDefaultStyle.qml"
                    dark: false
                }
                ListElement {
                    name: "Dark"
                    path: "PieMenuDarkStyle.qml"
                    dark: true
                }
            }
        }
    }
   
    property alias controlItem: pieMenu
    property alias customizerItem: customizerLoader.item

    Item {
        id: controlBoundsItem
        width: parent.width
        height: parent.height
        visible: customizerLoader.opacity === 0

        PieMenu {
            id: pieMenu
            width: Math.min(controlBoundsItem.width, controlBoundsItem.height) * 0.75
            height: width

            anchors.centerIn: parent;

            visible: view.triggered;

            style: Qt.createComponent(customizerItem.currentStylePath)

            MenuItem {
                text: "LMB"
                onTriggered: {

                }
                iconSource: "qrc:/TDxCompanion-lmb.png"
            }
            MenuItem {
                text: ""
                onTriggered: {

                }
                iconSource: ""
            }
            MenuItem {
                text: "RMB"
                onTriggered: {

                }
                iconSource: "qrc:/TDxCompanion-rmb.png"
            }
        }
    }

    Loader {
        id: customizerLoader
        sourceComponent: customizer
        opacity: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        y: parent.height / 2 - height / 2
        visible: customizerLoader.opacity > 0

        property alias view: view

        Behavior on y {
            NumberAnimation {
                duration: 300
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
    }
}
