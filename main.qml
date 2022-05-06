import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.platform 1.1

Window {
    property int curImageWidth: 885
    property int curImageHeight: 505
    height: curImageHeight
    width: curImageWidth
    visible: true
    title: qsTr("ImageViewer")
    id: mainwin

    property string rgb_str: "null"

    Component.onCompleted: {
        subwin.show()
    }

    Image {
        id: img
        source: "qrc:/startup-image.webp"
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        onSourceSizeChanged: {
            curImageWidth = sourceSize.width
            curImageHeight = sourceSize.height
        }
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: {
                if (mouse.button === Qt.LeftButton) {
                    fileDialog.open()
                } else {
                    if(!image_util.isReady())
                        return
                    var pixels_str = image_util.getImagePixelsOfArea(maskwin.x, maskwin.y, maskwin.width, maskwin.height)
                    rgb_str = pixels_str

//                    console.log(pixels_str[1])
                }

            }
            HoverHandler {
                onHoveredChanged: {
                    if(hovered) {
                        cursor.setHoveredCursor(parent)
                    } else {
                        cursorShape = Qt.ArrowCursor
                    }
                }
            }
            onPositionChanged: {
                maskwin.x = mouse.x - maskwin.width / 2 - 8
                maskwin.y = mouse.y - maskwin.height / 2 + 10
            }
        }
    }

    SubWin {
        id: subwin
        visible: true
        x: mainwin.x + mainwin.width
        y: mainwin.y
    }

    FileDialog {
        id: fileDialog
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFile
        nameFilters: ["image files (*.png *.jpg *.tif *.jpeg *.webp)"]
        onAccepted: {
//            console.log(file)
            img.source = file
            image_util.setImage(file)
        }
    }

    Rectangle {
        id: maskwin
//        anchors.centerIn: parent
        width: 20
        height: 20
        color: "#1abc9c";
        opacity: 0.3
    }
}
