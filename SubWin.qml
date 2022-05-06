import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: curImageHeight
    height: curImageHeight
    id: textwin
//    flags:  Qt.FramelessWindowHint
    color:  "#fad390"
    ScrollView {
        anchors.fill: parent
        TextArea {
            id: textarea
            anchors.fill: parent
            color: "black"
            font.family: "Times New Roman"
            text: rgb_str
            padding: 0
            textFormat: TextArea.RichText
            focus: true
            selectByMouse:true
            selectByKeyboard: true
            onTextChanged: {
                textwin.height = textarea.contentHeight
                textwin.width = textarea.contentWidth
            }
        }
    }
}
