import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import "../themes"
import "../components"


Base {
    id: root
    interactive: true  // 是否可以交互
    property int mode: 0  //0:max 1:min 2:close
    property alias icon: icon.icon

    // tooltip
    Tooltip {
        parent: parent
        delay: 500
        visible: mouseArea.containsMouse
        text: mode === 0 ? qsTr("Maximize") : mode === 1 ? qsTr("Minimize") : mode === 2 ? qsTr("Close") : qsTr("Unknown")
    }

    //关闭 最大化 最小化按钮
    function toggleControl(mode) {
        if (mode === 0) {
            if (window.visibility === Window.Maximized) {
                window.showNormal();
            } else {
                window.showMaximized();
            }
        } else if (mode===1) {
            window.showMinimized();
        } else if (mode===2) {
            window.close();
        }
    }

    width: 48
    height: parent.height


    // 背景 / Background
    Rectangle {
        id: background
        anchors.fill: parent
        color: mode === 2 ? Theme.currentTheme.colors.captionCloseColor : Theme.currentTheme.colors.subtleSecondaryColor
        opacity: 0

        Behavior on opacity { NumberAnimation { duration: 100; easing.type: Easing.InOutQuad } }
    }


    // 按钮图标
    IconWidget {
        id: icon
        // icon: {
        //     switch (mode) {
        //         case 1: // 最大化
        //             return "ic_fluent_dismiss_square_multiple_20_regular"
        //         case 0:  // 最小化
        //             return window.visibility === Window.Minimized ?
        //                 "ic_fluent_square_multiple_20_regular" :
        //                 "ic_fluent_square_20_regular"
        //         case 2:  // close
        //             return "ic_fluent_dismiss_20_regular"
        //         default:
        //             return "ic_fluent_square_multiple_20_regular"
        //     }
        // }
        icon: mode === 0 ?
                window.visibility === Window.Maximized ?
                    "ic_fluent_square_multiple_20_regular" :
                    "ic_fluent_square_20_regular" :
            mode === 1 ?
                "ic_fluent_subtract_20_regular" :
            mode === 2 ?
                "ic_fluent_dismiss_20_regular"
            :
                "ic_fluent_circle_20_regular"
        size: mode === 0 ? 14 : 16
        anchors.centerIn: parent
    }

    // 鼠标区域 / MouseArea
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: enabled
        hoverEnabled: true
        onClicked: {
            toggleControl(mode)
        }
    }

    states: [
        State {
        name: "disabledCtrl"
            when: !enabled
            PropertyChanges {  // 禁用时禁止改变属性
                target: icon;
                opacity: 0.3614
            }
            PropertyChanges {  // 禁用时禁止改变属性
                target: root;
            }
        },
        State {
            name: "pressedCtrl"
            when: mouseArea.pressed
            PropertyChanges {
                target: background;
                opacity: 0.8
            }
            PropertyChanges {
                target: icon;
                opacity: 0.6063
                color: root.mode === 2 ? Theme.currentTheme.colors.captionCloseTextColor : textColor
            }
        },
        State {
            name: "hoveredCtrl"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: background;
                opacity: 1
            }
            PropertyChanges {
                target: icon;
                opacity: 0.6063
                color: root.mode === 2 ? Theme.currentTheme.colors.captionCloseTextColor : textColor
            }
        }
    ]
}