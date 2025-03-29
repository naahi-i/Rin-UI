import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt5Compat.GraphicalEffects  // 图形库
import "../themes"
import "../components"
import "../windows"

// 内容层 / Content Area
Page {
    id: fluentPage
    default property alias content: container.data
    property alias contentHeader: headerContainer.data
    property alias customHeader: headerRow.data
    property int radius: Theme.currentTheme.appearance.windowRadius
    property int wrapperWidth: 1000
    horizontalPadding: 56


    // 头部 / Header //
    header: Item {
        height: fluentPage.title !== "" ? 36 + 44 : 0

        Item {
            id: headerRow
            width: Math.min(fluentPage.width - fluentPage.horizontalPadding * 2, fluentPage.wrapperWidth)  // 限制最大宽度
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height

            Text {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                typography: Typography.Title
                text: fluentPage.title
                visible: fluentPage.title !== ""  // 标题
            }
        }
    }


    background: Item {}

    Flickable {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical: ScrollBar {}
        contentHeight: container.height + 18 + headerContainer.height

        layer.enabled: true
        layer.effect: OpacityMask{
            maskSource: Rectangle{
                width: fluentPage.width
                height: fluentPage.height
                radius: fluentPage.radius

                Rectangle {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    width: parent.width - Theme.currentTheme.appearance.windowRadius
                    height: Theme.currentTheme.appearance.windowRadius
                }
            }
        }


        Row {
            id: headerContainer
            width: fluentPage.width
        }

        ColumnLayout {
            id: container
            anchors.top: headerContainer.bottom
            anchors.topMargin: 18
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.min(fluentPage.width - fluentPage.horizontalPadding * 2, fluentPage.wrapperWidth)  // 24 + 24 的边距
            spacing: 14

            // anchors.left: parent.left
            // anchors.right: parent.right
            // anchors.leftMargin: 24
            // anchors.rightMargin: 24
        }
    }

    // anchors.fill: parent
}
