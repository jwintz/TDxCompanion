import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

ListView {
    id: stylePicker
    width: parent.width
    height: parent.height * 0.06
    interactive: false
    spacing: -1

    orientation: ListView.Horizontal

    readonly property string currentStylePath: stylePicker.model.get(stylePicker.currentIndex).path
    readonly property bool currentStyleDark: stylePicker.model.get(stylePicker.currentIndex).dark !== undefined
        ? stylePicker.model.get(stylePicker.currentIndex).dark
        : true

    function toPixels(percentage) {
        return percentage * Math.min(parent.width, parent.height);
    }

    ExclusiveGroup {
        id: styleExclusiveGroup
    }

    delegate: Button {
        width: Math.round(stylePicker.width / stylePicker.model.count)
        height: stylePicker.height
        checkable: true
        checked: index === ListView.view.currentIndex
        exclusiveGroup: styleExclusiveGroup

        onCheckedChanged: {
            if (checked) {
                ListView.view.currentIndex = index;
            }
        }

        style: ButtonStyle {
            background: Rectangle {
                readonly property color checkedColor: currentStyleDark ? "#444" : "#777"
                readonly property color uncheckedColor: currentStyleDark ? "#222" : "#bbb"
                color: checked ? checkedColor : uncheckedColor
                border.color: checkedColor
                border.width: 1
                radius: 1
            }

            label: Text {
                text: name
                color: currentStyleDark ? "white" : (checked ? "white" : "black")
                font.pixelSize: toPixels(0.04)
                // font.family: openSans.name
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
